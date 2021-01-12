sub betanken {
    my ($hostname, $transport, $username, $password, $timeout) = @_;
	
    
    my $a = `snmpget -v 2c -c $snmp_ro_community -O vq $hostname .1.3.6.1.4.1.9.2.1.73.0 2>/dev/null`;
	
	$a =~ m/flash.{0,1}\:\/{0,1}(.*)"/i;
	
	unless ($1) {
		print "$hostname\tError\tnot reachable via SNMP\n";
		$pm->finish;
	}
	
	my $running_ios = $1;

	unless($zuordnungen{$running_ios}) {
		print "$hostname\tError\tno new matching IOS found (found: $running_ios)\n";
		$pm->finish;
	}
	my $new_ios = $zuordnungen{$running_ios}{'ZIEL-IOS'};
	
	unless($checksums{$new_ios}) {
		print "$hostname\tError\tno Checksum for new IOS found\n";
		$pm->finish;
	}
	
	
	
	#my $ram_in_byte = `snmpget -v 2c -c $snmp_ro_community -O vq $hostname .1.3.6.1.4.1.9.3.6.6.0 2>/dev/null`;
    
	
	
    my $s = Net::Appliance::Session->new({
        host      => $hostname,
        transport => $transport,
        personality => 'ios',     
		Timeout   => 600,
		connect_options => {
			opts=> [ '-o', 'StrictHostKeyChecking=no'],
			},
    });
	
	
	#print "\n DEBUG WIRD NACH ".$debug_dir.$hostname." geschrieben \n";
	$s->nci->logger->log_config({
					dispatchers => ['file_debug','file_info','file_notice','file_warning'],
					screen => {
						class => 'Log::Dispatch::Screen',
						min_level => 'debug',
					},
					file_debug => {
						class => 'Log::Dispatch::File',
						min_level => 'debug',
						filename => $debug_dir.$hostname.".debug",
					},
					file_info => {
						class => 'Log::Dispatch::File',
						min_level => 'info',
						filename => $debug_dir.$hostname.".info",
					},
					file_notice => {
						class => 'Log::Dispatch::File',
						min_level => 'notice',
						filename => $debug_dir.$hostname.".notice",
					},
					file_warning => {
						class => 'Log::Dispatch::File',
						min_level => 'warning',
						filename => $debug_dir.$hostname.".warning",
					},
	 });
	 
	open (FH, "> ".$debug_dir.$hostname.".extract");
	
	$s->set_global_log_at('debug');
	# $s->nci->logger->log_flags({
						# dump => 'debug',
						# });
	
    
    my $debug_log = $debug_dir.$hostname;
    
 
    eval {

        $s->connect({  
            username => $username,
            password => $password,
        }); 
        
      
            
		my @memory = $s->cmd('sh ver | i memory|Flash');
		
		my ($type, $mem, $flash);
		
		if (@memory ~~ /Cisco (\w*\d+).* with (\d+)K\/(\d+)K bytes of memory/){
			$type = $1;
			$mem = int (($2+$3)/1024);
		}
		
		if (@memory ~~ /(\d+)K bytes of .*Read/){
			$flash = int ($1/1000);
		}
		
		if ($mem < ($checksums{$new_ios}{'DRAM'} * 0.90)) {
			print "$hostname\tError\ttoo less DRAM\tFound: $mem Needed: ".$checksums{$new_ios}{'DRAM'}."\n";
			$pm->finish;
		}
		
		if ($flash < ($checksums{$new_ios}{'FLASH'} * 0.90)) {
			print "$hostname\tError\ttoo less FLASH\tFound: $flash Needed: ".$checksums{$new_ios}{'FLASH'}."\n";
			$pm->finish;
		}

		
		
		my @dir = $s->cmd('dir');
		
		my $drive;
		if (@dir ~~ m/Directory of (\w+):/) {
		   $drive = $1;
		}
		else {
			print ("$hostname\tError\tCould not determine destionation flash drive");
			$pm->finish;
		}		
		
		my $banner = <<'HERE';
banner login ^C

        ############################
        #    !!! Attention !!!     #
        ############################
        # Router will be cuurently #
        # upgraded to new IOS      #
        #                          #
        # DON'T CHANGE THE CONFIG  #
        # DON'T REBOOT THE ROUTER  #
        #                          #
        ############################
^C

HERE
	
		
		$s->cmd("conf t");
		$s->cmd($banner);
		$s->cmd("no ip ftp passive");
		$s->cmd("ip ftp source-interface Loopback0");
		$s->cmd("no boot system");
		$s->cmd("line vty 0 4");
		$s->cmd("exec-timeout 60 0");
		$s->cmd("end");
		$s->cmd("wr");
	
	    $s->cmd("format $drive:\n\n\n");
		

		my @transfer_status;
		my $erfolg = 'false';
		my $i;
		SCHLEIFE: for ($i = 1; $i<$max_ftp_retries; $i++ ){
			 @transfer_status = $s->cmd('copy ftp://summer:summer@'.$file_host.'/'.$ftp_image_dir.$new_ios." ".$drive.":\n\n\n");
			 print FH "\n\n".'copy ftp://summer:summer@'.$file_host.'/'.$ftp_image_dir.$new_ios." ".$drive.":\n\n\n"."\n\n";
			 print FH Dumper(@transfer_status);
			 foreach my $a (@transfer_status) {
				if ($a =~ m/OK/i) {
					$erfolg = 'true';
					last SCHLEIFE;
				}
			 }
			 sleep(60);
		}

		
		if ($erfolg eq 'false') {
		  @transfer_status = $s->cmd('copy tftp://'.$file_host.$tftp_image_dir.$new_ios." ".$drive.":\n\n\n");
		  print FH "\n\n".'copy tftp://'.$file_host.$tftp_image_dir.$new_ios." ".$drive.":\n\n\n"."\n\n";
		  print FH Dumper(@transfer_status);
		  foreach my $a (@transfer_status) {
				if ($a =~ m/OK/i) {
					$erfolg = 'true';
					last;
				}
			 }
		}
		
		if ($erfolg eq 'false') {
			print ("$hostname\tError\tTransfer of IOS Image failed Anzahl $i\n");
			#print Dumper($ftp_status);
			$pm->finish;
		}
		
			
		
		$s->cmd("dir");
		
		my @verify = $s->cmd(
	 			   'verify /md5 '.$drive.':'.$new_ios." ".$checksums{$new_ios}{'MD5'}
	 	);
		
		print FH "\n\n".'verify /md5 '.$drive.':'.$new_ios." ".$checksums{$new_ios}{'MD5'}."\n\n";
		print FH Dumper(@verify);
		
		
		if (@verify ~~ m/^Verified/) {
			$s->cmd("conf t");
			$s->cmd("no banner login");
			$s->cmd("end");
			$s->cmd("wr");
			print "$hostname\tOK\tRUN: $running_ios New: $new_ios Type: $type RAM: $mem ".$drive.": $flash\n";
		}
		else {
			print "$hostname\tError\tRUN: $running_ios New: $new_ios Type: $type RAM: $mem ".$drive.": $flash\n";
		}
       
    };
	
	if ( UNIVERSAL::isa($@,'Net::Appliance::Session::Exception') ) {
		open (FERROR, ">> ".$error_dir.$hostname) or croak "Cannot open $error_dir.$hostname $1\n";
		print FERROR $@->message, "\n";  # fault description from Net::Appliance::Session
		print FERROR $@->errmsg, "\n";   # message from Net::Telnet
		print FERROR $@->lastline, "\n"; # last line of output from your appliance
		close (FERROR);
		# perform any other cleanup as necessary
	}
	
	$s->close;
	close(FH);
    
	
	
}
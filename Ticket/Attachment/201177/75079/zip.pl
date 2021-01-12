	  my $data_file_zip;
	  if ($row_printed == 0 or $row_updated == 0)
	  {
	  }
	  else
	  {
	    open(SOURCE,$data_file) || die "Unable to open data file from $data_file: $!";
	    close SOURCE || die "Unable to close data file from $data_file: $!";
	    
	    ## To zip the file to send.
	    $data_file_zip = "hera_"."$LA_Code_First"."_"."$date$file_type.zip";
	    print_to_log("Creating the Zip file for LA Code $LA_Code_First ");
	    write_to_zip($zip,$data_file,$opt_d);
	  }

	    ## Create the multipart container
	  print_to_log("Creating Email for Customer $LA_Code_First to email address $Email_Address");
	  my $msg;
	  $msg = MIME::Lite->new (
	    From => $from_address,
	    To => $Email_Address,
	    Subject => $subject,
	    Type =>'multipart/mixed'
	  ) or die "Error creating multipart container: $!\n";
	  if($row_printed != 0){
	    if($Trans_Mech eq 'E'){
	        ## Add the text message part
	      $msg->attach (
	        Type => 'TEXT',
	        Data => $message_body1
	      ) or die "Error adding the text message part: $!\n";
	      

	        ## Add the DATA file
	      $msg->attach (
	         Type => 'application/zip',
	         Path => "$data_file_zip",
	         Filename => "$data_file_zip",
	         Disposition => 'attachment'
	      ) or die "Error adding $data_file_zip: $!\n";

	      }
	    else{
	        ## Add the text message part
	      $msg->attach (
	        Type => 'TEXT',
	        Data => $message_body2
	      ) or die "Error adding the text message part: $!\n";
	    }
	  }
	  else{
	      ## Tell viewer that there are no rows to send.
	    print_to_screen(" No updated rows to send.\n");
	      ## Add the text message part
	    $msg->attach (
	    Type => 'TEXT',
	    Data => $message_body3
	      ) or die "Error adding the text message part: $!\n";
	    }
	    ## Send the Message
	  print_to_log("Sending email to customer");
	  MIME::Lite->send('smtp', $mail_host, Timeout=>60);
	  $msg->send;
	  print_to_log("Email Sent");
	  
	  if ($row_printed == 0 or $row_updated == 0)
	  {}
	  else
	  {
	      ##Move the files into another directory.	  
	    move($data_file_zip,"$opt_d$data_file_zip");
	    print_to_log("Moved $data_file_zip to $opt_d$data_file_zip");
	    move($data_file,"$opt_d$data_file");
	    print_to_log("Moved $data_file to $opt_d$data_file");
	  }
	}
	


  ##Sub-routine to write a file to zip
sub write_to_zip{
	my $zip = @_[0];
	my $data_file = @_[1];
	my $new_dir = @_[2];
	my $data_file_zip = "$data_file.zip";
	$zip->addFile( $data_file ) || die "Problem with addfile: $!";
        my $output = $zip->writeToFileNamed("$data_file_zip") || die "\nProblem with writeToFileNamed: $!";
}

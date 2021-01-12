# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl ./t/10-complex.t'

#########################

# Goal here is to give as many success messagse as possible.
# Especially when not all FTP servers support all functions.
# So the logic here can be a bit convoluted.

use strict;
use warnings;

# Uncomment if you need to trace issues with IO::Socket:SSL methods as well.
# Proper values are: debug0, debug1, debug2 & debug3.  3 is the most verbose!
# use IO::Socket::SSL qw(debug3);

use Test::More tests => 60;   # Also update skipper (one less)
use File::Copy;

my $skipper = 59;

# plan tests => 59;  # Can't use due to BEGIN block

BEGIN { use_ok('Net::FTPSSL') }    # Test # 1

sleep (1);  # So test 1 completes before the message prints!

# So can more easily detect warnings instead of trolling my logs.
my $trap_warnings = "";
$SIG{__WARN__} = sub { $trap_warnings .= $_[0]; };

# These log files need to be global ...
my $debug_log1 = "./t/BABY_1_new.txt";
my $debug_log2 = "./t/BABY_2_new.txt";
my $debug_log3 = "./t/BABY_3_new.txt";

diag( "" );
diag( "\nYou can also perform a deeper test." );
diag( "Some information will be required for this test:" );
diag( "A secure ftp server address, a user, a password and a directory" );
diag( "where the user has permissions to read and write." );

my $p_flag = proxy_supported ();

my $more_test = ask_yesno("Do you want to make a deeper test");

SKIP: {
    skip ( "Deeper test skipped for some reason...", $skipper ) unless $more_test;

    my( $address, $server, $port, $user, $pass, $dir, $mode, $data, $encrypt_mode, $psv_mode ); 

    $address = ask2("Server address ( host[:port] )", undef, undef, $ENV{FTPSSL_SERVER});
    ( $server, $port ) = split( /:/, $address );
    $port = ""  unless (defined $port);   # Gets rid of warning while FTPSSL provides default port!

    $user = ask2("\tUser", "anonymous", undef, $ENV{FTPSSL_USER});

    $pass = ask2("\tPassword [a space for no password]", "user\@localhost", undef, $ENV{FTPSSL_PWD});

    $dir = ask2("\tDirectory", "<HOME>", undef, $ENV{FTPSSL_DIR});
    $dir = "" if ($dir eq "<HOME>");   # Will ask server for it later on.

    $mode = ask("\tConnection mode (I)mplicit, (E)xplicit, or (C)lear.",
                EXP_CRYPT, "(I|E|C)");

    if ( $mode eq CLR_CRYPT ) {
       $data = $encrypt_mode = "";   # Make sure not undef ...
    } else {
       $data = ask("\tData Connection mode (C)lear or (P)rotected.",
                   DATA_PROT_PRIVATE, "(C|S|E|P)");

       $encrypt_mode = ask("\tUse (T)LS or (S)SL encryption", "T", "(T|S)");
    }
    $encrypt_mode = ($encrypt_mode eq "S") ? 1 : 0;

    $psv_mode = ask("\tUse (P)ASV or (E)PSV for data connections", "P", "(P|E)");

    my $proxy;
    $proxy = ask_proxy_questions ()  if ($p_flag);


    # INET didn't support despite comments elsewhere.
    # my @svrs = split (/,\s*/, $server);
    # if (scalar (@svrs) > 1) { $server = \@svrs; }   # Requested list of servers

    # The main copy of the log file ...
    my $log_file = "./t/test_trace_log_new.txt";  # A common copy to work with.

    # The custom copy mentioned in the README file.
    my $copy_file = "./t/test_trace_log_new.$server-$mode-$data-$encrypt_mode.txt";

    # -----------------------------------------------------------
    # End of user interaction ...
    # -----------------------------------------------------------

    # This section initializes an unsupported feature to Net::FTPSSL.
    # Code is left here so that I can easily revisit it in the future if needed.
    # That's why option SSL_Client_Certificate is commented out for %ftps_opts
    # below but left uncommented here.  This feature tested in other test file.
    # So do not use this feature here unless you absolutely have no choice!
    my %advanced_hash = ( SSL_version => ($encrypt_mode ? "SSLv23" : "TLSv1"),
                          Timeout => 22 );
    # -----------------------------------------------------------

    my %callback_hash;
    # Delete test files from previous run
    unlink ("./t/test_file_new.tar.gz",
            "./t/FTPSSL.pm_new.tst",
            $log_file, $copy_file,
            $debug_log1, $debug_log2, $debug_log3);

    # So we can save the Debug trace in a file from this test.
    # We don't use DebugLogFile for this on purpose so that everything
    # written to STDERR is in the log file, including msgs from this test!
    # But doing it this way is very undesireable in a real program!
    # See test_log_redirection () for correct way to save to a log file.
    open (OLDERR, ">&STDERR");
    open (STDERR, "> $log_file");

    # Leave SSL_Client_Certificate commented out ... Unsupported feature for test ...
    # This hash provides the basic info for all the FTPSSL connections
    # based on the user's answers above.
    my %ftps_opts = ( Port => $port, Encryption => $mode,
                      DataProtLevel => $data, useSSL => $encrypt_mode,
                      # SSL_Client_Certificate => \%advanced_hash,
                      Timeout => 121, Debug => 1, Trace => 1 );

    # Set if we are going through a proxy server ...
    if (defined $proxy) {
       $ftps_opts{ProxyArgs} = $proxy;
    }

    unless ( valid_credentials ( $server, \%ftps_opts, $user, $pass ) ) {
       skip("Can't log into the FTPS Server.  Skipping the remaining tests ...",
            $skipper );
    }

    # Only call if the command channel is encrypted during the test ...
    if ( $mode ne CLR_CRYPT ) {
       # Will dynamically add OverrideHELP for future calls to new() if required ...
       check_for_help_issue ( $server, \%ftps_opts, $user, $pass );
    }

    if ( $psv_mode eq "P" && (! exists $ftps_opts{Pret}) ) {
       # Will dynamically add OverridePASV for future calls to new() if required ...
       unless (check_for_pasv_issue ( $server, \%ftps_opts, $user, $pass, $mode )) {
          skip ( "PASV not working, there are issues with your FTPS server.",
                 $skipper );
       }
    }

    # Put back into hash going forward ...
    $ftps_opts{PreserveTimestamp} = 1;
    $ftps_opts{Croak} = 1;

    print STDERR "\n**** Starting the real server test ****\n";
    $trap_warnings = "";

    # Writes logs to STDERR which this script redirects to a file ...
    my $ftp = Net::FTPSSL->new( $server, \%ftps_opts );

    isa_ok( $ftp, 'Net::FTPSSL', 'Net::FTPSSL object creation' );

    ok ( $ftp->login ($user, $pass), "Login to $server" );
    # is ( $trap_warnings, "", "New & Login produce no warnings (OK to fail this test)" );

    # Turning off croak now that our environment is correct!
    $ftp->set_croak (0);

    if ( $psv_mode ne "P" ) {
       my $t = $ftp->force_epsv (1);
       $psv_mode = ( $t ) ? "1" : "2";
       $t = $ftp->force_epsv (2)  unless ( $t );
       ok ( $t, "Force Extended Passive Mode (EPSV $psv_mode)" );
       unless ( $t ) {
         --$skipper;
         skip ( "EPSV not supported, please rerun test using PASV instead!",
                $skipper );
       }
    } else {
       ok ( 1, "Using PASV mode for data connections" );
    }

    # Ask for the user's HOME dir if it's not provided!
    $dir = $ftp->pwd ()  unless ($dir);

    # -------------------------------------------------------------------------
    # Verifying extra connections work as expected and don't interfere
    # with the logs for this main test going to STDERR ...
    # Can ignore any warnings from this section ...
    # -------------------------------------------------------------------------
    my $save_warnings = $trap_warnings;
    test_log_redirection ( $server, \%ftps_opts, $user, $pass, $psv_mode );
    $trap_warnings = $save_warnings;

    # -------------------------------------------------------------------------
    # Back to processing the real test cases ...
    # -------------------------------------------------------------------------
    ok( $ftp->cwd( $dir ), "Changed the dir to $dir" );
    my $pwd = $ftp->pwd();
    ok( defined $pwd, "Getting the directory: ($pwd)" );
    $dir = $pwd  if (defined $pwd);     # Convert relative to absolute path.

    my $res = $ftp->cdup ();
    $pwd = $ftp->pwd();
    ok ( $res, "Going up one level: ($pwd)" );

    $res = $ftp->cwd ( $dir );
    $pwd = $ftp->pwd();
    ok ( $res, "Returning to proper dir: ($pwd)" );

    # Verifying supported() & _help() work as expected.
    # Must check logs for _help() success, since it returns a hash reference.

    ok( $ftp->supported("HELP"), "Checking if HELP is supported" );
    ok( $ftp->_help("HELP"), "Getting the HELP usage" );  # Never fails
    print STDERR "--- " . $ftp->last_message() . " ---\n";

    ok( $ftp->_help("HELP"), "Getting the HELP usage again (cached?)" );
    print STDERR "--- " . $ftp->last_message() . " -- (cached?) --\n";

    ok( $ftp->supported("HELP"), "Checking HELP supported again (cached?)" );
    ok( ! $ftp->supported("BADCMD"), "Verifying BADCMD isn't supported" );
    ok( ! $ftp->supported("SITE", "BADCMD"), "Verifying SITE BADCMD isn't supported" );
    ok( $ftp->_help("BADCMD"), "Getting the BADCMD usage" );  # Never fails

    # Verifying we can check out valid SITE sub-commands ...
    # Returns hash ref of valid SITE commands
    my $site = $ftp->_help ("SITE");
    if (scalar (keys %{$site}) > 0) {
       my @sites = sort (keys %{$site});
       ok( $ftp->supported("SITE", $sites[0]), "Verifying SITE $sites[0] is supported" );
    } else {
       ok( 1, "verifyed \"supported ('SITE', <cmd>)\" is not supported!  List of SITE cmds not available" );
    }

    ok( $ftp->noop(), "Noop test" );

    # -----------------------------------------------
    # Start put/uput/get/rename/delete section ...
    # -----------------------------------------------

    # Check if timestamps are preserved via get/put commands ... (Both sides)
    my $supported = ($ftp->supported ("MFMT") && $ftp->supported("MDTM"));

    ok( $ftp->put( './FTPSSL.pm' ), "puting a test ascii file on $dir" );

    # So the supported test will appear in the log file 1st!
    $res = $ftp->supported ("STOU");
    my $uput_name = $ftp->uput ( './FTPSSL.pm' );
    my $do_delete = 0;

    if ($res) {
       ok( $uput_name, "uput the same test ascii file again as: $uput_name" );
       if ( $uput_name ne "FTPSSL.pm" ) {
          $do_delete = 1;    # Deferring till afer the listings ...
       } else {
          ok( 0, "Did we correctly detect new uput name used? ($uput_name)" );
       }
    } else {
       ok( ! $uput_name, "uput should fail since STOU not supported on this server" );
       ok ( 1, "uput delete skiped since uput not supported!" );
    }

    ok( $ftp->binary (), 'putting FTP in binry mode' );
    ok( $ftp->put( './t/test_file.tar.gz' ), "puting a test binary file on $dir" );

    # Query after put() call so there is something to find!
    # (Otherwise it looks like it may have failed.)
    my @lst = $ftp->list ();
    ok( scalar @lst != 0, 'list() command' );
    print_result (\@lst);

    $ftp->set_callback (\&callback_func, \&end_callback_func, \%callback_hash);
    @lst = $ftp->list ();
    ok( scalar @lst != 0, 'list() command with callback' );
    print_result (\@lst);
    $ftp->set_callback ();   # Disable callbacks again

    @lst = $ftp->list (undef, "*.p?");
    ok( scalar @lst != 0, 'list() command with wildcards (*.p?)' );
    print_result (\@lst);

    if ( $do_delete ) {
       ok( $ftp->delete($uput_name), "deleting $uput_name on $server" );
    }

    # -----------------------------------
    # Check if the rename fails, since that will affect the remaining tests ...
    # Possible reasons: Command not supported or your account doesn't have
    # permission to do the rename!
    # -----------------------------------
    my $rename_works = 0;
    $res = $ftp->rename ('test_file.tar.gz', 'test_file_new.tar.gz');
    my $msg = $ftp->last_message();      # If it failed, find out why ...
    if ($ftp->supported ("RNFR") && $ftp->supported ("RNTO")) {
       if ($res) {
          ok( $res, 'renaming bin file works' );
          $rename_works = 1;
       } else {
          ok( ($msg =~ m/Permission denied/) || ($msg =~ m/^550 /),
              "renaming bin file check: ($msg)" );
       }
    } else {
       ok( ! $res, "Rename is not supported on this server" );
    }

    # So we know what to call the renamed file on the FTP server.
    my $file = $res ? "test_file_new.tar.gz" : "test_file.tar.gz";

    $do_delete = 0;
    ok( $ftp->ascii (), 'putting FTP back in ascii mode' );
    $res = $ftp->xput ('./FTPSSL.pm', './ZapMe.pm');
    $msg = $ftp->last_message();      # If it failed, find out why ...
    if ($rename_works) {
       ok ($res, "File Recognizer xput Test to a directory Completed");
       ok ($ftp->xput ('./FTPSSL.pm', 'ZapMe2.pm'), "Using current directory");
    } else {
       ok (1, "File Recognizer xput Test Skipped ($msg)");
       ok( $ftp->noop(), "Noop test - Skip 2nd xput test as well" );
    }

    # With call back
    $ftp->set_callback (\&callback_func, \&end_callback_func, \%callback_hash);
    @lst = $ftp->nlst ();
    ok( scalar @lst != 0, 'nlst() command with callback' );
    print_result (\@lst);
    $ftp->set_callback ();   # Disable callbacks again

    # Without call back
    @lst = $ftp->nlst ();
    ok( scalar @lst != 0, 'nlst() command' );
    print_result (\@lst);

    @lst = $ftp->nlst (undef, "*.p?");
    ok( scalar @lst != 0, 'nlst() command with wildcards (*.p?)' );
    print_result (\@lst);

    # Silently delete it, don't make it part of the test ...
    # Since if the xput test failed, this test will fail.
    $ftp->delete ("ZapMe.pm");
    $ftp->delete ("ZapMe2.pm");

    ok( $ftp->binary (), 'putting FTP back in binary mode' );
    ok( $ftp->get($file, './t/test_file_new.tar.gz'), 'retrieving the binary file' );
    my $size = $ftp->size ($file);
    my $original_size = -s './t/test_file.tar.gz';
    ok ( defined $size, "The binary file's size via FTPS on $server was $size vs $original_size");

    # Now check out the before & after BINARY images
    ok( $original_size == -s './t/test_file_new.tar.gz',
        "Verifying BINARY file matches original size" );
    ok( $original_size == $size,
        "Verifying FTPS Server agreed with the sizes." );
    my $same_dates = (stat ('./t/test_file.tar.gz'))[9] == (stat ('./t/test_file_new.tar.gz'))[9];
    ok( (! $supported) || $same_dates,
        $supported ? "The binary file's Timestamp was preserved!"
                   : "Preserving Binary file timestamps are not supported!" );
    ok( $ftp->delete($file), "deleting the test bin file on $server" );

    ok( $ftp->ascii (), 'putting FTP back in ascii mode' );
    ok( $ftp->xget("FTPSSL.pm", './t/FTPSSL.pm_new.tst'), 'retrieving the ascii file again via xget()' );
    ok( $ftp->delete("FTPSSL.pm"), "deleting the test file on $server" );

    # Now check out the before & after ASCII images
    ok( -s './FTPSSL.pm' == -s './t/FTPSSL.pm_new.tst',
        "Verifying ASCII file matches original size" );
    $same_dates = (stat ('./FTPSSL.pm'))[9] == (stat ('./t/FTPSSL.pm_new.tst'))[9];
    ok( (! $supported) || $same_dates,
        $supported ? "The ASCII Timestamps were preserved!"
                   : "Preserving ASCII timestamps are not supported!" );

    $file = "delete_me_I_do_not_exist.txt";
    ok ( ! $ftp->get ($file), "Get a non-existant file!" );
    if (-f $file) {
       $size = -s $file;
       unlink ($file);
       print STDERR " *** Deleted local file: $file  [$size byte(s)].\n";
    } else {
       print STDERR " *** No local copy was created!\n";
    }

    # -----------------------------------------
    # End put/get/rename/delete section ...
    # -----------------------------------------

    # -----------------------------------------
    # Clear the command channel, do limited work after this ...
    # Add any new tests before this block ...
    # -----------------------------------------
    if ( $mode eq CLR_CRYPT ) {
       ok ( $ftp->noop (), "Noop since CCC not supported using regular FTP." );
    } elsif ( $ftp->supported ("ccc") ) {
       ok ( $ftp->ccc (), "Clear Command Channel Test" );
    } else {
       ok ( $ftp->noop (), "Noop since CCC not supported on this server." );
    }
    ok ( $ftp->pwd (), "Get Current Directory Again" );

    # -----------------------------------------
    # Closing the connection ...
    # -----------------------------------------

    $ftp->quit();

    # Free so any context messages will still appear in the log file.
    $ftp = undef;

    # -----------------------------------------
    # Did the code generate any warnings ???
    # -----------------------------------------
    if ( $trap_warnings ne "" ) {
       diag ("\nCheck out the following warnings from Net-FTPSSL and report to developer with logs:\n$trap_warnings\n");
    }

    # Restore STDERR now that the tests are done!
    open (STDERR, ">&OLDERR");
    if (1 == 2) {
       print OLDERR "\n";   # Perl gives warning if not present!  (Not executed)
    }

    # Create the custom copy mentioned in the README file.
    File::Copy::copy ($log_file, $copy_file);
}

# =====================================================================
# Start of subroutines ...
# =====================================================================

sub valid_credentials {
   my $server = shift;
   my $opts = shift;
   my $user = shift;
   my $pass = shift;

   print STDERR "\nValidating the user input credentials & PRET test against the server ...\n";

   my $ftps = Net::FTPSSL->new( $server, $opts );

   isa_ok( $ftps, 'Net::FTPSSL', 'Net::FTPSSL ' . $Net::FTPSSL::ERRSTR );
   --$skipper;

   my $sts = 0;    # Assume failure ...

   if ( defined $ftps ) {
      $sts = $ftps->login ($user, $pass);
      ok( $sts, "Login to $server" );
      --$skipper;

      if ( $sts ) {
         if ($ftps->quot ("PRET", "LIST") == CMD_OK) {
            diag ("\n=========================================================");
            diag ('=== Adding option "Pret" to all future calls to new() ===');
            diag ("=========================================================\n");
            $opts->{Pret} = 1;   # Assumes all future calls will need!
         }
         $ftps->quit ();
      } else {
         diag ("\n=========================================================");
         diag ("=== Your FTPS login credentials are probably invalid! ===");
         diag ("=========================================================");
         diag ("\n");
      }
   }

   return ( $sts );
}

# -----------------------------------------------------------------------------
# Test for Bug # 61432 (Help responds with mixed encrypted & clear text on CC.)
# Bug's not in my software, but on the server side!
# But still need tests for it in this script so all test cases will work.
# Does no calls to ok() on purpose ...
# Never open a data channel here ...
# -----------------------------------------------------------------------------
sub check_for_help_issue {
   my $server = shift;
   my $opts = shift;
   my $user = shift;
   my $pass = shift;

   print STDERR "\nTrying to determine if HELP works on encrypted channels ...\n";
   my $ftps = Net::FTPSSL->new( $server, $opts );
   $ftps->login ($user, $pass);
   $ftps->noop ();
   my $sts = $ftps->quot ("HELP");
   if ( $sts == CMD_ERROR && $Net::FTPSSL::ERRSTR =~ m/Unexpected EOF/ ) {
      diag ("\nThis server has issues with the HELP Command.");
      diag ("You Must use OverrideHELP when calling new() for this server!");
      diag ("Adding this option for all further testing.");
      $opts->{OverrideHELP} = 1;   # Assume all FTP commands supported.
   }
   $ftps->quit ();
}

# -----------------------------------------------------------------------------
# Test for Bug # 61432 (Where PASV returns wrong IP Address)
# Bug's not in my software, but on the server side!
# But still need tests for it in this script so all test cases will work.
# Does no calls to ok() on purpose ...
# -----------------------------------------------------------------------------
sub check_for_pasv_issue {
   my $server = shift;
   my $opts   = shift;
   my $user   = shift;
   my $pass   = shift;
   my $crypt  = shift;

   print STDERR "\nTrying to determine if PASV returns wrong IP Address ...\n";

   # Uncomment the line below to force the failure case (to debug this code)
   # I don't have a server to test against where this happens ...
   # $opts->{OverridePASV} = "abigbadservername";

   my $ftps = Net::FTPSSL->new( $server, $opts );
   $ftps->login ($user, $pass);

   # WARNING: Do not copy this code, it calls internal undocumented functions
   # that probably change between releases.  I'm the developer, so I will keep
   # any changes here in sync with future releases.  But I need this low
   # level access to see if the server set up PASV correctly through the
   # firewall. (Bug 61432)  Should be fairly rare to see it fail ...

   if ( $crypt ne CLR_CRYPT ) {
      $ftps->_pbsz ();
      return (0)  unless ($ftps->_prot ());
   }

   my ($h, $p) = $ftps->_pasv ();

   print STDERR "Calling _open_data_channel ($h, $p)\n";

   # Can we open up the returned data channel ?
   if ( $ftps->_open_data_channel ($h, $p) ) {
      $ftps->_abort();
      $ftps->quit ();
      print STDERR "\nPASV works fine ...\n";
      return (1);    # Yes, we don't have to worry about it.
   }

   # Very, very rare to get this far ...

   print STDERR "Attempting to reopen the same data channel using OveridePASV\n";

   # Now let's see if OverridePASV would have worked ....
   if ( $ftps->_open_data_channel ($server, $p) ) {
      print STDERR "Success!\n";
      diag ("\nThis server has issues with returning the correct IP Address via PASV.");
      diag ("You Must use OverridePASV when calling new() for this server!");
      diag ("Adding this option for all further testing.");

      $opts->{OverridePASV} = $server;      # Things should now work!

      $ftps->_abort();
      $ftps->quit ();
      print STDERR "\nMust use OverridePASV ...\n";
      return (1);
   }

   $ftps->quit();
   print STDERR "Failure!\n";

   return (0);    # PASV doesn't seem to work at all!
}

# -------------------------------------------------------------------------
# Just ignore these connections, just verifying that it's not sharing/stealing
# the log file.  Must manually examine the logs to be sure it's correct.
# Also checks the 2 override options in various modes ...
# Just be aware that OverrideHELP & OverridePASV may already be overriden!
# -------------------------------------------------------------------------
sub test_log_redirection {
   my $server   = shift;
   my $loc_opts = shift;
   my $user     = shift;
   my $pass     = shift;
   my $psv_flg  = shift;   # P, 1 or 2.  For opening data channels.

   print STDERR "\nCreating secondary connections for other log files ...\n";
   my @help = ("MFMT", "NOOP");

   my $hlp_ovr_flg = (exists $loc_opts->{OverrideHELP});
   my $psv_ovr_flg = (exists $loc_opts->{OverridePASV});

   $loc_opts->{PreserveTimestamp} = 0;
   $loc_opts->{DebugLogFile} = $debug_log1;
   my $badftp1 = Net::FTPSSL->new( $server, $loc_opts );

   $loc_opts->{PreserveTimestamp} = 1;
   $loc_opts->{DebugLogFile} = $debug_log2;
   $loc_opts->{OverridePASV} = $server;
   my $badftp2 = Net::FTPSSL->new( $server, $loc_opts );

   $loc_opts->{PreserveTimestamp} = 1;
   $loc_opts->{DebugLogFile} = $debug_log3;
   delete ($loc_opts->{OverridePASV}) unless ($psv_ovr_flg);
   $loc_opts->{OverrideHELP} = 1;    # All commands valid
   my $badftp3 = Net::FTPSSL->new( $server, $loc_opts );

   isa_ok( $badftp1, 'Net::FTPSSL', '2nd Net::FTPSSL object creation' );
   isa_ok( $badftp2, 'Net::FTPSSL', '3rd Net::FTPSSL object creation' );
   isa_ok( $badftp3, 'Net::FTPSSL', '4th Net::FTPSSL object creation' );
   ok( $badftp1->login ($user, $pass), "2nd Login to $server" );
   ok( $badftp2->login ($user, $pass), "3rd Login to $server" );
   ok( $badftp3->login ($user, $pass), "4th Login to $server" );
   $badftp1->set_croak (0);
   $badftp2->set_croak (0);
   $badftp3->set_croak (0);

   $badftp2->force_epsv ($psv_flg)  if ($psv_flg ne "P");

   $badftp1->pwd ();
   $badftp2->list ();    # Uses a data channel
   $badftp3->noop ();
   $badftp1->quit ();
   $badftp2->quit ();
   $badftp3->quit ();

   $loc_opts->{OverrideHELP} = \@help;  # Some commands valid
   $loc_opts->{Debug} = 2;
   $badftp3 = Net::FTPSSL->new( $server, $loc_opts );

   isa_ok( $badftp3, 'Net::FTPSSL', 'Appending to 4th Net::FTPSSL object logs' );
   ok( $badftp3->login ($user, $pass), "Repeat 4th Login to $server" );
   $badftp3->set_croak (0);
   $badftp3->pwd ();
   $badftp3->quit ();

   $loc_opts->{OverrideHELP} = 0;        # No commands valid
   $badftp3 = Net::FTPSSL->new( $server, $loc_opts );

   isa_ok( $badftp3, 'Net::FTPSSL', 'Appending to 4th Net::FTPSSL object logs again' );
   ok( $badftp3->login ($user, $pass), "Repeat 4th Login to $server again" );
   $badftp3->set_croak (0);
   $badftp3->pwd ();
   my $t = $badftp3->force_epsv (1);
   $t = $badftp3->force_epsv (2)   unless ( $t );
   ok ( $t, "Force Extended Passive Mode" );
   my @lst = $badftp3->list ();
   push (@lst, "SUB-TEST-LIST-RESULTS-FROM-OTHER-SECTION");
   print_result (\@lst);   # Display's the list in the main log, not this one!
   $badftp3->quit ();

   print STDERR "End of secondary connections for other log files ...\n\n";

   return;
}

# Does an automatic shift to upper case for all answers
sub ask {
  my $question = shift;
  my $default  = uc (shift);
  my $values   = uc (shift);

  my $answer = uc (prompt ($question, $default, $values));

  if ( $values && $answer !~ m/^$values$/ ) {
     $answer = $default;   # Change invalid value to default answer!
  }

  # diag ("ANS: [$answer]");

  return $answer;
}

# This version doesn't do an automatic upshift
# Also provides a way to enter "" as a valid value!
# The Alternate Default is from an optional environment variable
sub ask2 {
  my $question = shift;
  my $default  = shift || "";
  my $values   = shift || "";
  my $altdef   = shift || $default;

  my $answer = prompt ($question, $altdef, $values);

  if ( $answer =~ m/^\s+$/ ) {
     $answer = "";         # Overriding any defaults ...
  } elsif ( $values && $answer !~ m/^$values$/ ) {
     $answer = $altdef;    # Change invalid value to default answer!
  }

  # diag ("ANS2: [$answer]");

  return $answer;
}

sub ask_yesno {
  my $question = shift;

  my $answer = prompt ("$question", "N", "(Y|N)");

  # diag ("ANS-YN: [$answer]");

  return $answer =~ /^y(es)*$/i ? 1 : 0;
}

# Save the results from the list() & nlst() calls.
# Remember that STDERR should be redirected to a log file by now.
sub print_result {
   my $lst = shift;

   # Tell the max number of entries you may print out.
   # Just in case the list is huge!
   my $cnt = 5;

   my $max = scalar (@{$lst});
   print STDERR "------------- Found $max file(s) -----------------\n";
   foreach (@{$lst}) {
      if ($cnt <= 0) {
         print STDERR "...\n";
         print STDERR "($lst->[-1])\n";
         last;
      }
      print STDERR "($_)\n";
      --$cnt;
   }
   print STDERR "-----------------------------------------------\n";
}

# Testing out the call back functionality as of v0.07 on ...
sub callback_func {
   my $ftps_function_name = shift;
   my $data_ref     = shift;      # The data to/from the data channel.
   my $data_len_ref = shift;      # The size of the data buffer.
   my $total_len    = shift;      # The number of bytes to date.
   my $callback_data_ref = shift; # The callback work space.

   if ( $ftps_function_name =~ m/:list$/ ) {
      ${$data_ref} =~ s/[a-z]/\U$&/g;    # Convert to upper case!
      # Reformat #'s Ex: 1234567 into 1,234,567.
      while ( ${$data_ref} =~ s/(\d)(\d{3}\D)/$1,$2/ ) { }
      ${$data_len_ref} = length (${$data_ref});  # May have changed data length!

   } elsif ( $ftps_function_name =~ m/:nlst$/ ) {
      ${$data_ref} =~ s/[a-z]/\U$&/g;    # Convert to upper case!
      ${$data_ref} =~ s/^/[0]: /gm;      # Add a prefix per line.

      # Make the prefix unique per line ...
      my $cnt = ++$callback_data_ref->{counter};
      while ( ${$data_ref} =~ s/\[0\]/[$cnt]/) {
         $cnt = ++$callback_data_ref->{counter};
      }

      # Fix so counter is correct for next time called!
      --$callback_data_ref->{counter};

      ${$data_len_ref} = length (${$data_ref});  # Changed length of data!

   } else {
      print STDERR " *** Unexpected callback for $ftps_function_name! ***\n";
   }

   return ();
}

# Testing out the end call back functionality as of v0.07 on ...
sub end_callback_func {
   my $ftps_function_name = shift;
   my $total_len          = shift;   # The total number of bytes sent out
   my $callback_data_ref  = shift;   # The callback work space.

   my $tail;   # Additional data channel data to provide ...

   if ( $ftps_function_name =~ m/:nlst$/ ) {
      my $cnt;
      my $sep = "";
      $tail = "";
      foreach ("Junker", "T-Bird", "Coup", "Model-T", "Horse & Buggy") {
         $cnt = ++$callback_data_ref->{counter};
         $tail .= $sep . "[$cnt]: $_!";
         $sep = "\n";
      }

      # So the next nlst call will start counting all over again!
      delete ($callback_data_ref->{counter});
   }

   return ( $tail );
}


# Based on ExtUtils::MakeMaker::prompt
# (can't use since "make test" doesn't display questions!)

sub prompt {
   my ($question, $def, $opts) = (shift, shift, shift);

   my $isa_tty = -t STDIN && (-t STDOUT || !(-f STDOUT || -c STDOUT));

   my $dispdef = defined $def ? "[$def] " : " ";
   $def = defined $def ? $def : "";

   if (defined $opts && $opts !~ m/^\s*$/) {
      diag ("\n$question ? $opts $dispdef");
   } else {
      diag ("\n$question ? $dispdef");
   }

   my $ans;
   if ( $ENV{PERL_MM_USE_DEFAULT} || (!$isa_tty && eof STDIN)) {
      diag ("$def\n");
   } else {
      $ans = <STDIN>;
      chomp ($ans);
      unless (defined $ans) {
         diag ("\n");
      }
   }

   $ans = $def  unless ($ans);

   return ( $ans );
}

# Check if using a proxy server is supported ...
sub proxy_supported {
   eval {
      require Net::HTTPTunnel;
   };
   if ($@) {
      diag ("NOTE: Using a proxy server is not supported without first installing Net::HTTPTunnel\n");
      return 0;
   }

   return 1;
}

# Ask the proxy server related questions ...
sub ask_proxy_questions {
   my $ans = ask_yesno ("Will you be FTP'ing through a proxy server?");
   unless ($ans) {
      return undef;
   }

   my %proxy_args;
   $proxy_args{'proxy-host'} = ask2 ("\tEnter your proxy server name", undef, undef, $ENV{FTPSSL_PROXY_HOST});
   $proxy_args{'proxy-port'} = ask2 ("\tEnter your proxy port", undef, undef, $ENV{FTPSSL_PROXY_PORT});
   $ans = ask_yesno ("\tDoes your proxy server require a user name/password pair?", undef, undef, $ENV{FTPSSL_PROXY_USER_PWD_REQUIRED});
   if ($ans) {
      $proxy_args{'proxy-user'} = ask2 ("\tEnter your proxy user name", undef, undef, $ENV{FTPSSL_PROXY_USER});
      $proxy_args{'proxy-pass'} = ask2 ("\tEnter your proxy password", undef, undef, $ENV{FTPSSL_PROXY_PWD});
   }

   # diag ("Host: ", $proxy_args{'proxy-host'}, "   Port: ", $proxy_args{'proxy-port'}, "  User: ", ($proxy_args{'proxy-user'} || "undef"), "  Pwd: ", ($proxy_args{'proxy-pwd'} || "undef"));

   return \%proxy_args;
}

# vim:ft=perl:


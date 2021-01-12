#!/usr/bin/env perl
#
# Base on 'Modbus/TCP Server query' by Cosimo Feb 1st, 2007
# Issues a read coils request on an IP address / port
# Here Protocol::Modbus is used only to build request
# $Id: read_coils_simple.pl,v 1.2 2007/02/05 11:16:02 cosimo Exp $
#
# UC Berkeley Physics -- Electronics shop -- gtp 3/19/09
# This script runs as a cron job every minute or longer.
# This script creates a three files; a last-read file; a history file; a feature-state file.
# See initialization below.
# The feature-state file is delivered to the user's browser by a cgi script.
# changes: Nov 4, 2009 migrate from basic read paradigm to general paradigm

use strict;
use warnings;
use carp;
use Protocol::Modbus;
use Net::Domain;
use Sys::Hostname;
use Socket;

my $netdebug = 0;
if ( ( defined  $ARGV[0] ) && ( $ARGV[0] =~ m/debug/ ) ) { $netdebug=1; } # Turn on the tcp debugging 

my $version = ' V1.0' ;
my $modbusHost = q!echo.physics.berkeley.edu!;
#my $ip = join(/./,unpack("C4",(gethostbyname($modbusHost))[4]));
my $ip = '128.32.117.40';  # the IP of the ethernet input device
my $trials   = 5;
my $datapath = "/var/www/Documents/LN2/snapshot/"; # Where non-cgi files are located
#my $datapath = "/Users/electronicsshop/embedded/"; # Where non-cgi files are located
my $logpath  = "/var/log/" ;
#my $logpath  = "/Users/electronicsshop/embedded/" ;
my $lndata   = $datapath.'lndata';	# Formatted snapshot of the last device read
my $lnhistory= $logpath.'lnhistory';	# Ultimately holds date-stamped changes of state.
my $snapshot = $datapath.'last' ;	# bit-pattern
my $reportRoute = "1" ;
my @features = ( "Sub-floor Temperature:", 
		"Sub-floor Water Level state:", 
		"Atmosphere (per ODM):",  # future home of oxygen depletion monitor
		"Scale:", 
		"Scale BP:", # bypass switch on interlock system state
		"Chain:", 
		"Permit:",
		"VB-Permit:",# The input pin of the Nitromatic's controller.
		"START:",    # Nitromatic "Start" button state
		"Station:",  # Nitromatic Fill System "Filling" state
		"Station:",  # Small Dewar Solenoid Valve Status
                "Power:");
my @featureStates =( "Normal#<font color=\"blue\">Subnormal. Clears within 15 min. unless there is a system fault.</font><font color=\"black\"></font>",
		"Normal#Flooded. Potential scale sensor damage from immursion.",
		"Safe#<font color=\"red\">DANGER!! Anoxic! UNSAFE TO ENTER WHILE ALARM SOUNDS!!</font><font color=\"black\"></font>",
		"Fill Permitted#Fill Disallowed",
		"Bypass Mode#Normal Mode",
		"Complete#Open Interlock",
		"Normal#Not Granted",
		"Permit#STOPPED",
		"DEPRESSED#Normal",
		"Filling#Not Filling",
		"Filling#Not Filling",
                "On#Off");
$| = 1;

my $mylast = q!000000000000!;
if ( open( RFH, "<".$snapshot ) ) { # Recall data from the preavious pass through the program, if it exists
    $mylast = <RFH>;
    close( RFH );
}

my $timestamp = localtime();  # a time stamp very close to the actual read time.

my $sysstatus = 0;
if ($netdebug) {
     $sysstatus = `/var/www/CGI-Executables/dotcpdump start echo 128.32.117.40`;  # print 'started dump at '.localtime().'status-'.$sysstatus."-\n";
}

# the dotcpdump script runs tcpdump as a bsackground process, and captures the PID of it in a file so it can be killed later
# The "stop" invocation reads the PID from a file, and issues a kill command
# If the 'connect' succeeds, the tcp dump file can or should be deleted with the "unsave" invocation of the script
# usage dotcpdump start|stop|unsave [filename [hostname|ip]]


my $areyouthere = `/sbin/ping -qc1 -t1 $ip` ; # ping once to see if there's a path to the host. Produces a 2 packet ICMP transaction
if ( $areyouthere =~ /100%\s+packet\+loss/) { 
    if ($netdebug) { $sysstatus = system("/var/www/CGI-Executables/dotcpdump stop echo") ;}
    if ( $mylast =~ /path error/ ) {   # Still out of service
        exit 0; # exiting cleanly prevents cron from sending emails; die provikes email reports
    } else { open( LOGFH, ">".$snapshot ) or die " can't open snapshot file after ping failure \n";  # The beginning of an outage
        print LOGFH "path error ".$timestamp.$version;
        close LOGFH; 
        open( LOGFH, ">>".$lnhistory ) or die "can't open the log file after ping failure \n";
        print LOGFH "Ping failed. No network path to I/O module at ".$timestamp;
        close LOGFH;
        die "Ping failed. No network path to $ip at $timestamp \n";
    }
}

my $name = hostname();	# Make a randomizer to avoid collisions if multiple pollers
my $randomizer = ((unpack("C4",(gethostbyname($name))[4]))[3])/16;

# The MODBUS dialog begins here.
my $modbus = Protocol::Modbus->new(driver=>'TCP');
my $req = $modbus->readInputsRequest(
    address  => 0,
    quantity => 12,
);

# Open a Socket to Device
# use IO::Socket::INET;
my $trial=$trials ;

select(undef, undef, undef, $randomizer );

# the dotcpdump script runs tcpdump as a bsackground process, and captures the PID of it in a file so it can be killed later
# The "stop" invocation reads the PID from a file, and issues a kill command
# If the 'connect' succeeds, the tcp dump file can or should be deleted

my $trs ;
until ( defined( $trs = Protocol::Modbus::Transport->new(
    driver=>'TCP',
    address => $ip,
    PeerPort => 502,
    Timeout  => 3, )))  # Even works with ADAM-6050 with Timeout=1... i.e. no connect errors.
{
    if ( 0 < --$trial ){
        if ( $reportRoute && ( $trials-$trial == 2 ) ) {
#           $route = system("/usr/local/bin/lft -SVV echo.physics.berkeley.edu") ; # Possible place for a diagnostic
#           LFT doesn't seem to work properly in this context... especially as a cron job
        }
    } else {
        if ($netdebug) { $sysstatus = system( "/var/www/CGI-Executables/dotcpdump stop echo" ) ;}
        if ( $mylast =~ "connect error" ) {
            exit 0 ; # prevents the stream of emails
        } else {
            open( LOGFH, '>>'.$logpath.'ln-mod-error' ) or die "Can't open mod error file: $! while reporting connect error \n";
            # print "Failed to connect to I/O module at ".$timestamp."\n";
            print LOGFH "Can't connect to I/O module after multiple attempts. $timestamp\n";
            close LOGFH;
            open( LOGFH, '>>'.$lnhistory ) or die "Can't open history log file: $! while reporting connect error";
            print LOGFH "Can't connect to I/O module after multiple attempts. $timestamp\n";
            close LOGFH; # When the network comes back up, an idle state entr: should be appended to the log file.
            open( XFH, '>'.$snapshot ) or die "Can't open snapshot file $snapshot for write: $!\n";
            print XFH "connect error ".$timestamp.$version  ;
            close XFH;
            die "Can't connect to I/O module after $trials attempts. \n" ;
        }
    }
    select( undef, undef, undef, $trials-$trial );
}
# print "Connected.\n";
# Should have generated a 3 packet [SYN] transaction

$timestamp = localtime();  # a time stamp very close to the actual read time.
my $trn = $modbus->transaction( $trs, $req ); # $req asks for 12 bytes in the read-coils request. 16 bytes are returned.
my $res = $trn->execute();
my @mypat = @{ $res->inputs() }; 
my $mybits = join( "", @mypat[0..11] ); # Trim the vector to the fields actually returned.
if ( 16 !=  @mypat  ) { 
    if ( $netdebug ) { system( "dotcpdump stop echo" ); }
    die "Received @mypat ". @mypat ." bytes. 16 bytes expected. \n";
}

# print "data bytes: [@mypat] Reading >".$mybits."< Last reading %$mylast% at $timestamp \n";

open( XFH, '>'.$snapshot ) or die "Can't open snapshot file $snapshot for write: $!";
print XFH "$mybits $timestamp$version"  ;
close XFH;

if ( not $mylast =~ $mybits ) { # Integrity check. 
    $res = $trn->execute(); 
    my $rebits = join( "", @{ $res->inputs() }[0..11] );
    # print "reading $mybits; check rearad $rebits.\n";
    if ( not $mybits =~ $rebits ){
        open( LOGFH, '>>'.$logpath.'ln-mod-error' ) or die "Can't open mod error file: $!";
        print LOGFH "pattern $mybits check-pattern $rebits $timestamp\n";
        close LOGFH;
        carp ( "Alert: reading pattern $mybits check-pattern $rebits $timestamp\n" );
    }
}

# print ' mylast '. $mylast. ' mybits '.$mybits.' file '.$lnhistory." \n";
if ( not $mylast =~ $mybits ) {  # The place to recognize particular state transitions... like fill ended...
    my $flags = ( $mybits =~ ".{9}0.{2}"  ) ? 'L':'';		# Recognize large dewar fill
    $flags   .= ( $mybits =~ ".{8}00.{2}" ) ? '*':'';		# Recognize tape on the start switch! '01' and '10' are normal
    $flags   .= ( $mybits =~ ".{10}0.{1}" ) ? 'S':'';		# Recognize small dewar fill
    open( LOGFH, '>>'.$lnhistory ) or die "Can't open history log file: $!";
    print LOGFH $mybits." ".$timestamp.$flags."\n";
    close LOGFH;
}

open MYFH, ">".$lndata or die "couldn't open $!";
my $index=0;
foreach ( @mypat[0..11] ) {	# Build record for the CGI script to spit out
    print MYFH $features[$index],'§',(split(/#/,$featureStates[$index]))[$_],"#";
    $index++;
}
print MYFH '['.$timestamp.']'."#";
close MYFH;
 
print "$mybits at $timestamp\n"; 

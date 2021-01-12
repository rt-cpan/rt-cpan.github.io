#!perl

use Win32::Daemon;

my $param = shift;
my $servicename = 'ServiceName';

%Hash = (
	machine =>  '',
	name    =>  $servicename,
	display =>  'Displayed Name',
	path    =>  $^X,
	user    =>  '',
	pwd     =>  '',
	description => 'Description of the service.',
	parameters  => 'c:\perlzone\service\gtheperlgod.pl "c:\perlzone\service"'
	);

if ($param eq "-install") {
	if (Win32::Daemon::CreateService(\%Hash)) { print "\n$servicename installed successfully!\n"; } 
	else { print "\n$servicename installtion failed: " . Win32::FormatMessage(Win32::Daemon::GetLastError()); }
	exit();
} 

if ($param eq "-uninstall") {
	if (Win32::Daemon::DeleteService ('', $servicename)) { print "\n$servicename uninstalled successfully!\n"; } 
	else { print "\n$servicename uninstallation failed: " . Win32::FormatMessage(Win32::Daemon::GetLastError()); }
	exit();
}

open (LOG, ">> $0.log");
select(LOG);
$| = 1;

Win32::Daemon::StartService();
logwrite("Service Starting");

while (SERVICE_STOPPED != Win32::Daemon::State()) {

	if (SERVICE_START_PENDING == Win32::Daemon::State()) {
		Win32::Daemon::State(SERVICE_RUNNING);
		logwrite("Service Started");
	}

	if (SERVICE_STOP_PENDING == Win32::Daemon::State()) {
		Win32::Daemon::State(SERVICE_STOPPED);
		logwrite("Service Stopping");
	}

	if (SERVICE_RUNNING == Win32::Daemon::State()) {
		# Program Here
		logwrite("Failure: net send gebitt Hi") if (system("net send gebitt Hi"));
		sleep(30);
	}

	sleep(1);

}

Win32::Daemon::StopService();
logwrite("Service Stopped\n");

sub logwrite { print "[" . localtime() . "] $_[0]\n"; }

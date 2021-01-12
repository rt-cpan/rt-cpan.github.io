use vars qw( $VERSION );
use Win32::Daemon;


my $log_file = @ARGV ? $ARGV[0] : "$0.log";

open(my $log, '>', $log_file);
select( (select($log), $| = 1 )[0] ); # Autoflush
close(STDOUT);
close(STDERR);
*STDOUT = *STDERR = $log;

my $count = 0;

# Start the service...
Win32::Daemon::StartService() or die "StartService failure!";

my $PrevState = SERVICE_STARTING;
while( SERVICE_STOPPED != ( $State = Win32::Daemon::State() ) )
{
    print scalar localtime(), ' ', $State, "\n";
    if( SERVICE_START_PENDING == $State ) {
        # Initialization code
        Win32::Daemon::State( SERVICE_RUNNING );
        $PrevState = SERVICE_RUNNING;
    } elsif( SERVICE_PAUSE_PENDING == $State ) {
        # "Pausing...";
        Win32::Daemon::State( SERVICE_PAUSED );
        $PrevState = SERVICE_PAUSED;
	next;
    } elsif( SERVICE_CONTINUE_PENDING == $State ) {
        # "Resuming...";
        Win32::Daemon::State( SERVICE_RUNNING );
        $PrevState = SERVICE_RUNNING;
	next;
    } elsif( SERVICE_STOP_PENDING == $State ) {
        # "Stopping...";
        Win32::Daemon::State( SERVICE_STOPPED );
        $PrevState = SERVICE_STOPPED;
	next;
    } elsif( SERVICE_RUNNING == $State ) {
        # The service is running as normal...
        $PrevState = SERVICE_RUNNING;

        $count++;
        if ($count == 4) {
            my $pid = fork();
            unless ($pid) {
                print "Child start\n";
                sleep 5;
                print "Child end\n";
                exit 0;
            }
        } else {
	    sleep(1);
	}
    } else {
        # We have some unknown state...
        # reset it back to what we last knew the state to be...
        Win32::Daemon::State( $PrevState );
	sleep( 1 );
    }
}

Win32::Daemon::StopService();

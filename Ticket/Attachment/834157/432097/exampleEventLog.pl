use strict;

use Win32::EventLog;

# each event has a type, this is a translation of the common types
my %type = (1  => "ERROR",
         2  => "WARNING",
         4  => "INFORMATION",
         8  => "AUDIT_SUCCESS",
         16 => "AUDIT_FAILURE");

# if this is set, we also retrieve the full text of every
# message on each Read(  )
$Win32::EventLog::GetMessageText = 1;

my $machinename  = @ARGV ? $ARGV[0] : $ENV{COMPUTERNAME};

print "Machine: $machinename\n";

# open the System event log
my $log = new Win32::EventLog("Application", $machinename)
  or die "Unable to open log:$^E\n";

# read through it one record at a time, starting with the first entry
my ($oldest, $lastRec);
$log->GetOldest($oldest);
$log->GetNumber($lastRec);
my $offset = $oldest + $lastRec-1;
my $entry;
while ($log->Read((EVENTLOG_SEEK_READ|EVENTLOG_BACKWARDS_READ),
             $offset,$entry)){
    if (index($entry->{Source}, "Symantec") >=0) {
        # this is a symantec entry
        print "====================================================\n";
        print scalar localtime($entry->{TimeGenerated})." ";
        print $entry->{Computer}."[".($entry->{EventID} &
              0xffff)."] ";
        print $entry->{Source}.":".$type{$entry->{EventType}};
        print $entry->{Message};
        print "====================================================\n";

    } else {
        print scalar localtime($entry->{TimeGenerated})." Source: $entry->{Source} ".$type{$entry->{EventType}}."\n";
    }
    $offset--;
}

$log->Close();


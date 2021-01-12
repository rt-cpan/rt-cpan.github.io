use strict;

use Win32::EventLog;
my $EventLog;

# each event has a type, this is a translation of the common types
my %type = (1  => "ERROR",
         2  => "WARNING",
         4  => "INFORMATION",
         8  => "AUDIT_SUCCESS",
         16 => "AUDIT_FAILURE");
 
# if this is set, we also retrieve the full text of every 
# message on each Read(  )
$Win32::EventLog::GetMessageText = 1; 


my $machinename  = "BG60246";

print "Machine: $machinename\n";

# open the System event log
my $log = new Win32::EventLog("Application", $machinename) 
  or die "Unable to open system log:$^E\n";

# read through it one record at a time, starting with the first entry
my $entry;
while ($log->Read((EVENTLOG_SEQUENTIAL_READ|EVENTLOG_BACKWARDS_READ),
             1,$entry)){
    if (index($entry->{Source}, "Symantec") >=0) {
        # this is a symantec entry
        print "====================================================\n";
        print scalar localtime($entry->{TimeGenerated})." ";
        print $entry->{Computer}."[".($entry->{EventID} &
              0xffff)."] ";
        print $entry->{Source}.":".$type{$entry->{EventType}};
        print $entry->{Message};

    } else {
        print "!!!!!\nSource: $entry->{Source}\n";
    }
}







 


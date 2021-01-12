#!/usr/bin/perl -w

use strict;
use diagnostics;

use Mail::Box::Manager;

my $mgr = Mail::Box::Manager->new; 

my $new_file = $ARGV[0];
my $new_folder = $mgr->open(folder => $new_file, access => 'rw', extract => 'ALWAYS', cache_body => 'DELAY', cache_head => 'DELAY') or die "cannot open folder $new_file: $!\n";

my $msg = $new_folder->message(0);

        
print "original subj is '", $msg->subject, "'\n";

# but I want pure UTF-8, no ?iso-88..? etc left
my $subject = $msg->study('subject');

if ($subject) { # msg might not have a Subject: line at all....
    print " studied subj is '$subject'\n";
    $subject = $subject->decodedBody();
    print " decoded subj is '$subject'\n";


} else {
    print "SUBJECT is FALSE (no Subject: line?)\n";
}
       
            


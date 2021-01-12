#!/usr/bin/perl -w

use strict;

use Mail::Box::Manager;
my $mgr = Mail::Box::Manager->new; 
Mail::Reporter->defaultTrace('ERRORS');

my $folder = $mgr->open(folder => 'folder.mbox', access => 'rw') or die "cannot open folder.mbox: $!\n";


foreach my $msg ($folder->messages) {
    
        my $subject = $msg->study('subject');

        print "ok so far\n";
        print "Subject is '$subject'\n";
        print "(error above)\n";

        # WORKAROUND:
        if (defined $subject && $subject ne '') {
            # print $subject...
        }
        
    
        # ... do other stuff ... 
        
}



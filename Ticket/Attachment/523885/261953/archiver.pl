#!/usr/bin/perl -w

use Mail::Box::Manager;

use strict;
use diagnostics;

# archiver.pl
# walks over new messages, and if a tag can be identified, archive the whole thread

$|=1;

my $seen_file = 'seen.mbox';
my $new_file = $ARGV[0];
(-s $new_file) || die "can't find $new_file -- is it an mbox?\n";


my $mgr = Mail::Box::Manager->new;
my $seen_folder = $mgr->open(folder => $seen_file, access => 'rw', create => 1) or die "cannot open folder $seen_file: $!\n";
my $new_folder = $mgr->open(folder => $new_file, access => 'rw') or die "cannot open folder $new_file: $!\n";
my $threads = $mgr->threads(folders => [$seen_folder,$new_folder]);


# examine new mail in turn
foreach my $newmsg ($new_folder->messages) {
    next if $newmsg->isDeleted or $newmsg->isDummy;
    
    print "DEBUG: ", $newmsg->messageId, "\n";

    # find the start of the thread this new message is in
    my $threadstart = $threads->threadStart($newmsg);
    
    print "DEBUG: ...not reached...\n";

    # take alle messages in thread
    my @thread = $threadstart->threadMessages;
    my %tags = ();
    
    # examine thread starting from last message
    while (my $msg = pop @thread) {
        my $subject = $msg->head->study('subject');
        if ($subject) { # spam might not have a subject...
            $subject = $subject->decodedBody(); # ?iso-88..? in subject...
            while ($subject =~ /\[(\d+)\]/g) {
                $tags{$1} = 1;
            }
            #...
        }
        
        # test BODY
        # ...
        
        # stop if we've found a tag
        last if (scalar keys %tags);
    }
    
    # save result
    
}


#!/usr/bin/perl -w

use strict;
use diagnostics;
# DEBUG-LIBs
#use lib '/server/newsadm/tmp/fschlich/mail__box/perl/share/perl/5.8.4/';
use Mail::Box::Manager;

my $debug = 1;

$|=1 if $debug;

my $seen_file = 'seen.mbox';
(-f $seen_file) || `touch $seen_file`;
my $new_file = $ARGV[0];
(-e $new_file) || die "kann $new_file nicht finden. Wirklich eine mbox? $!\n";



# MAIL::BOX to the rescue
my $mgr = Mail::Box::Manager->new; 
my $seen_folder = $mgr->open(folder => $seen_file, access => 'rw') or die "cannot open folder $seen_file: $!\n";
my $new_folder = $mgr->open(folder => $new_file, access => 'rw', extract => 'ALWAYS', cache_body => 'DELAY', cache_head => 'DELAY') or die "cannot open folder $new_file: $!\n";
my $threads = $mgr->threads(folders => [$seen_folder,$new_folder]);



# look at all threads in turn
foreach my $startnode ($threads->all) {
    my @thread = $startnode->threadMessages;
    
    my %uids = ();
    
    # walk along thread looking for tags in subject header
    while (my $msg = pop @thread) {
        next if $msg->isDeleted or $msg->isDummy;
        print 'DEBUG: working on ', $msg->messageId, "\n" if $debug;
        
        # get pure UTF-8 body, no ?iso-88..? etc left
        my $subject = $msg->study('subject');
        
        # this would be a workaround
#        eval { # stirbt bei unbekanntem encoding...
#            $subject = $subject->decodedBody(); # ?iso-88..? im subject...
#        };
#        if ($@) {
#            print 'ERROR: ', $@;
#            $subject = 0;
#        }
#        

        #$subject = $subject->decodedBody(); # OHNE DIESE ZEILE GEHT'S... undef muss nicht stringifiziert!
        
#        if ($subject) { # Falls decoding-error oder Mail ohne Subject

            while ($subject =~ /\[(\d{2,6})\]/g) {
                next if ($1 < 23 || $1 > 399999);
                $uids{$1} = 1;
                print "DEBUG:     found user [$1]\n" if $debug;
            }
            
#        }
        
            
        last if scalar keys %uids;
    }
    
    
    # process results

    
}


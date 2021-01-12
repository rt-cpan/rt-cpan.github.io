#!/usr/bin/perl
use warnings;
use strict;
use Text::LevenshteinXS qw(distance);
use Benchmark qw(timediff timestr);

#use Term::ProgressBar;
use Data::Dumper;
use IPC::ShareLite qw(:lock);
use Storable qw(freeze thaw);
use Parallel::ForkManager;

my $t0 = Benchmark->new();

my %contacts;
my $minimum_score = 80;
my $max_childs    = 2;

# set global var, should be a reference
get_db_data();

my @control = keys(%contacts);

my $db = IPC::ShareLite->new(
    -key     => 1978,
    -create  => 'yes',
    -destroy => 'yes'
) or die "$!\n";

$db->store( freeze( \%contacts ) );

print 'shared mem key is ', $db->key(), ', version ', $db->version(), "\n";

# free memory
undef %contacts;

print 'Starting processing data with maximum of ', $max_childs, ' childs', "\n";

#my $progress = Term::ProgressBar->new(
#    { name => 'Find Duplicated', count => scalar(@control) } );

#my $total_processed = 0;

#my $i = 0;

my $manager = Parallel::ForkManager->new($max_childs);

$manager->set_max_procs($max_childs);

my $max_tries = 3;

foreach my $id (@control) {

    $manager->start() and next;

    print 'shared mem key is ', $db->key(), ', version ', $db->version(), "\n";

    my $tries = 0;

    while (1) {

        if ( $db->lock(LOCK_EX) ) {

            print "child $$ got a lock\n";

            my $contacts_ref = thaw( $db->fetch() );

            my $testing_ref = delete( $contacts_ref->{$id} );

            $db->store( freeze($contacts_ref) );

            unless ( $db->lock(LOCK_UN) ) {

                print "child $$ could not release the lock\n";

            } else {

				print "child $$ released the lock\n";

			}

            validate_contact( $id, $testing_ref, $contacts_ref );
            last;
        }
        else {

            print "child $$ can't lock\n";
            sleep 1;
            $tries++;
            last if ( $tries >= $max_tries );

        }
    }

    $manager->finish();

}

#$total_processed += $i;

#$progress->update($total_processed);

$manager->wait_all_children();

my $t1 = Benchmark->new();
my $td = timediff( $t1, $t0 );
print "\nThe code took: ", timestr($td), "\n";

sub validate_contact {

    my $id = shift;

    # array ref
    my $testing_ref  = shift;
    my $contacts_ref = shift;
    my $file         = 'tmp/processing-' . $id . '.log';

    my $source_name = $testing_ref->[0] . ' ' . $testing_ref->[1];

    foreach my $contact ( keys( %{$contacts_ref} ) ) {

        my $dest_name =
          $contacts_ref->{$contact}->[0] . ' ' . $contacts_ref->{$contact}->[1];

        my $dest_len = length($dest_name);

        $dest_len = 1 unless ( $dest_len > 0 );

        my $distance = distance( $source_name, $dest_name );

        my $score = 100 - ( ( $distance * 100 ) / $dest_len );

        # how much equal is the current row with the original one
        if ( $score >= $minimum_score ) {

            open( my $out, '>:utf8', $file ) or die "Cannot create $file: $!\n";

            print $out $testing_ref->[0], '|', $testing_ref->[1],
              '|',
              $testing_ref->[2], '|', $id, '|';

            # dest FST_NAME|LAST_NAME|CON_CD|PERSON_UID|SCORE
            print $out $contacts_ref->{$contact}->[0], '|',
              $contacts_ref->{$contact}->[1],
              '|', $contacts_ref->{$contact}->[2], '|', $contact, '|', $score,
              "\n";

            close($out);
        }

    }

}

sub get_db_data {

    print 'Fetching contacts from database... ';

    my $file = 'contacts.txt';

    open( my $in, '<:utf8', $file ) or die "cannot read $file: $!\n";

    while (<$in>) {

        chomp;

        my @temp = split( /\|/, $_ );

        my $id = splice( @temp, 2, 1 );

        $contacts{$id} = \@temp;

    }

    close($in);

    print "OK\n";

    return;

}

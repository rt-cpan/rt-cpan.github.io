# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl filename.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More; # tests => 5;
#BEGIN { use_ok('Sys::SigAction') };

use Sys::SigAction;
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

use strict;
#use warnings;

use Carp qw( carp cluck croak confess );
use Data::Dumper;
use Sys::SigAction qw( set_sig_handler );
use POSIX  ':signal_h' ;
use Config;

#plan is a follows:
#
#  A test that sets signal handlers in nested blocks, and tests that
#  at each level of nesting, the signal handler at the next level up
#  is still valid (for the same signal).  The idea is that the scope of
#  the block prevents the next level up signal handle from being overwritten.
#
# NOTE: smoke testers on ARM find that this test fails with a perl segfault
# two levels up from the deepest level... :-(
#global... should be good at the end...


my @levels = ( );
my $depth = $ARGV[0];
my $repetitions = $ARGV[1];
$repetitions = 2 if not defined $repetitions;

my $arch = $Config{'archname'} ;
print "archname = $arch}\n" ;
if ( $Config{'archname'} =~ m/arm/i )
{
   if ( not defined $depth ) 
   {
      print qq(

   NOTE:  'arm' found in \$Config{'archname'}
   
       Bug #  was filed against Sys::SigAction noting that
       this test causes a perl segfault (apparently if the depth of
       nested invocations is greater than 2). Forcing depth to $depth
       on this platform.
       
           depth=$depth
       
       If this test is run manually, you can explicitly 
       set both the depth of nesting and the number of 
       repetitions of this test. 

       perl -Ilib t/nested.t 5 2 #depth=5 repetitions=2

       Because this works fine on all the POSIX (unix) platforms the smoke
       testers have tested on, the author suspect this is a problem with
       the underlying signal handling in perl on ARM platforms. Apparently
       there are no smoke testers using ARM.  So, if you want this port
       of perl fixed, you'll want to get a stack trace from the core file
       resulting from the segfault and file a bug against this perl port.

);
      $depth = 2
   }
}
else
{
   $depth = 5 if not defined $depth;
   $repetitions = 2 if not defined $repetitions;
}

plan tests => $depth*$repetitions;

#recurses until $level > $depth
sub do_level
{
    my ( $level ) = @_;
    return if $level > $depth;
    print "entered do_level( $level )\n" ;
    do_level( $level+1 );
    eval {
       my $ctx = set_sig_handler( SIGALRM ,sub { print "in ALRM handler level $level\n"; $levels[$level-1] = $level; } );
       kill ALRM => $$;
    };
    if ($@) { warn "handler died at level $level: $@\n"; }
}


sub do_test
{
   my ( $p ) = ( @_ );
   my $i = 0;
   print "depth = $depth\n" ;
   print "initializing levels array to all 0 for every depth\n" ;
   while ( $i < $depth ) { push( @levels, 0 ); $i++; }

   do_level( 1 );

   $i = 0;
   for ( $i = $depth-1; $i > -1; $i-- )
   {
      ok( $levels[$i] ,"pass $p: \$levels[$i] was set by the signal handler to $levels[$i]" );
      print "\$levels[$i] = " .$levels[$i] . "\n" ;
   }
}
my $pass = 1;
while ( $pass <= $repetitions ) {
   print "starting pass $pass\n" ;
   do_test( $pass  );
   $pass++;
} 

exit;

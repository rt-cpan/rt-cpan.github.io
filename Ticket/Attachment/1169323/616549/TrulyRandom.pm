use strict;
use warnings;
use Time::HiRes qw/ualarm/;
our $VERSION = '2.00';

use Exporter qw(import);
our @EXPORT_OK = qw( truly_random_value random_byte );
our %EXPORT_TAGS = (all => [ @EXPORT_OK ]);
# export everything by default
our @EXPORT = qw( truly_random_value );


my $count  = 0;
my $ocount = 0;
my $buffer = 0;

sub _roulette {
  eval {
    local $SIG{ALRM} = sub { die "alarm\n" };
    # DJ: Same constant and incrementing integer as in the original C code.
    ualarm(16665);
    $count++ while 1;
    alarm 0;
  };
  die "alarm failed\n" unless $@;
  die unless $@ eq "alarm\n";
  # Same mixing function as used in the original C code.
  # Modern systems would use a cryptographic hash for this.
  $count = $count ^ ($count >> 3) ^ ($count >> 6) ^ $ocount;
  $count &= 0x7;
  $ocount = $count;
  $buffer = ($buffer << 3) ^ $count;
  return ($buffer & 0xFFFFFFFF);
}

sub truly_random_value {
  $count = 0;
  _roulette();
  _roulette();
  _roulette();
  _roulette();
  _roulette();
  _roulette();
  _roulette();
  _roulette();
  _roulette();
  _roulette();
  _roulette();
}

sub random_byte {
  $count = 0;
  _roulette();
  _roulette();
  chr(_roulette() & 0xFF);
}

1;

=head1 NAME

TrulyRandom - Generate non-pseudo random numbers in pure Perl

=head1 SYNOPSIS

    use Math::TrulyRandom;
    
    $random = truly_random_value();

=head1 DESCRIPTION

The B<TrulyRandom> module provides an ability to generate non-pseudo random
32-bit numbers from within Perl programs.  The source of the randomness
is from interrupt timing discrepancies.


=head1 EXAMPLE

    $random = truly_random_value();

=head1 BUGS

This code uses only CORE Perl code, but needs Time::HiRes::ualarm which is
not supported on Win32.

The name is a bit misleading, as this technique generates decent entropy only
on select platforms.  My understanding is that one of the primary authors,
Matt Blaze, now believes this to be an obsolete method, and O/S sources such
as /dev/random are the proper solution.

This implementation is based on version 1 of TrueRand, which had numerous
issues and was superseded by TrueRand 2.1.  The expected entropy for each
32-bit value of this code is approximately 8-16 bits, and the mixing method
leaves much to be desired.  The newer version uses cryptographic hashes for
mixing, as well as mixing the result of multiple raw calls to create one
result.  The documentation specifically warns to not use the raw call (hence
this earlier version does exactly what the author now indicates not to do).

More sophisticated systems like L<HAVEGE|http://www.issihosts.com/haveged/>
and L<EGD|http://egd.sourceforge.net/> generate randomness with more sources
and run much faster.  These are meant to feed entropy pools, which are in
turn managed and doled out via /dev/random.  This module is userspace
"I<voodoo entropy>" and really shouldn't be used.

The random numbers take a long time (in computer terms) to generate,
so are only really useful for seeding pseudo random sequence generators.


=head1 SEE ALSO

=head2 L<Crypt::Random::TESHA2> is another module that generates non-pseudo
random data from timer/scheduler variations.  It works on more platforms and
runs much faster while using less CPU.  It uses SHA-256 and SHA-512 for mixing,
as well as pushing all generated randomness through an entropy pool.

=head2 L<Crypt::Random::Seed> is a simple module that finds the best strong
random source available and uses it to return random data.

=head2 L<Math::Random::Source> is a very flexible and oft-used module that
finds available entropy sources and presents a unified interface for getting
random data from them.

=head2 L<Crypt::URandom> is a simple module that gets the best non-blocking
random source available and uses it to return random data.

=head2 L<Bytes::Random::Secure> is a straightforward module that (1) finds
a good source of strong randomness, and (2) uses it to seed
L<Math::Random::ISAAC> (a cryptographically secure pseudo-random number
generator).  This is a very good combination for most purposes.  It provides
a nice API.

=head2 L<Math::Random::Secure> is similar to L<Bytes::Random::Secure>, but
offers a different set of features.

=head2 L<Crypt::Random> offers an interface to random values in arbitrary
bigint ranges, using the best source of randomness it finds -- typically
/dev/random.  It uses the L<Math::Pari> module which creates portability
issues, and its use of /dev/random for all activities means it blocks
on many operations, making it unsuitable for embedded systems unless they
have an entropy daemon running.


=head1 COPYRIGHT

This implementation derives from the truly random number generator function
developed by Matt Blaze and Don Mitchell, and is copyright of AT&T.

Other parts of this perl extension are copyright of Systemics Ltd
(L<http://www.systemics.com/>).

The rewrite in pure Perl is Copyright (c) 2013, Dana Jacobsen.

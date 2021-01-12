#!/usr/bin/perl

# This just happens to be the version I'm using
require v5.8.4;

use strict;
use warnings;

use Test::More qw( no_plan );
use Readonly;
use Config::Std;

# Memory leakage is worse with a real config file, but even an empty breaks
Readonly my $CONFIG_FILE => '/dev/null';

# Bug shows with 100 iterations, but just to be sure...
Readonly my $ITERATIONS => 1_000;

# This is to validate the test.
# If I just do all this looping without any read_config, there's no problem.
{
    my $initial_size;
    my $current_size;
    my $iteration = 0;
    my $failures = 0;

    while ( $iteration++ < $ITERATIONS ) {

        {
            my %config;
#            read_config $CONFIG_FILE => %config;
        }

        if ( ! defined $initial_size ) {
            $initial_size = $current_size = my_mem();
        }
        else {
            $current_size = my_mem();
            if ( $current_size != $initial_size ) {
                # report failure
                is( $current_size, $initial_size, 'still using the same mem' );

                # count failure
                $failures++;

                # supress failures until we grow again
                $initial_size = $current_size;
            }
        }
    }

    is( $failures, 0, 'no memory growth (without Config::Std)!' );
}

# This shows the bug
{
    my $initial_size;
    my $current_size;
    my $iteration = 0;
    my $failures = 0;

    while ( $iteration++ < $ITERATIONS ) {

        {
            my %config;
            read_config $CONFIG_FILE => %config;
        }
        
        if ( ! defined $initial_size ) {
            $initial_size = $current_size = my_mem();
        }
        else {
            $current_size = my_mem();
            if ( $current_size != $initial_size ) {
                # report failure
                is( $current_size, $initial_size, 'still using the same mem' );

                # count failure
                $failures++;

                # supress failures until we grow again
                $initial_size = $current_size;
            }
        }
    }

    is( $failures, 0, 'no memory growth (with Config::Std)!' );
}

sub my_mem {
    my @pslines = grep( m{ \A \s* (?: \d+ \s+ ){2} $$ \b }xms, `ps axl` );

    die if ( scalar @pslines != 1 );
    
    my $line = $pslines[0];
    chomp( $line );
    my @words = split /\s+/, $line;

#     my $proc = join q{ }, @words[ 12 .. ( scalar @words - 1 ) ];
#     $proc =~ s/\s+$//;
#     print $words[ 6 ] . " $proc\n";

    return $words[6];
}
__END__

This is the version of Perl I'm using:

Summary of my perl5 (revision 5 version 8 subversion 4) configuration:
  Platform:
    osname=linux, osvers=2.6.15.6, archname=i386-linux-thread-multi
    uname='linux ernie 2.6.15.6 #1 thu mar 16 13:11:55 est 2006 i686 gnulinux '
    config_args='-Dusethreads -Duselargefiles -Dccflags=-DDEBIAN -Dcccdlflags=-fPIC -Darchname=i386-linux -Dprefix=/usr -Dprivlib=/usr/share/perl/5.8 -Darchlib=/usr/lib/perl/5.8 -Dvendorprefix=/usr -Dvendorlib=/usr/share/perl5 -Dvendorarch=/usr/lib/perl5 -Dsiteprefix=/usr/local -Dsitelib=/usr/local/share/perl/5.8.4 -Dsitearch=/usr/local/lib/perl/5.8.4 -Dman1dir=/usr/share/man/man1 -Dman3dir=/usr/share/man/man3 -Dsiteman1dir=/usr/local/man/man1 -Dsiteman3dir=/usr/local/man/man3 -Dman1ext=1 -Dman3ext=3perl -Dpager=/usr/bin/sensible-pager -Uafs -Ud_csh -Uusesfio -Uusenm -Duseshrplib -Dlibperl=libperl.so.5.8.4 -Dd_dosuid -des'
    hint=recommended, useposix=true, d_sigaction=define
    usethreads=define use5005threads=undef useithreads=define usemultiplicity=define
    useperlio=define d_sfio=undef uselargefiles=define usesocks=undef
    use64bitint=undef use64bitall=undef uselongdouble=undef
    usemymalloc=n, bincompat5005=undef
  Compiler:
    cc='cc', ccflags ='-D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS -DDEBIAN -fno-strict-aliasing -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64',
    optimize='-O2',
    cppflags='-D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS -DDEBIAN -fno-strict-aliasing -I/usr/local/include'
    ccversion='', gccversion='3.3.5 (Debian 1:3.3.5-13)', gccosandvers=''
    intsize=4, longsize=4, ptrsize=4, doublesize=8, byteorder=1234
    d_longlong=define, longlongsize=8, d_longdbl=define, longdblsize=12
    ivtype='long', ivsize=4, nvtype='double', nvsize=8, Off_t='off_t', lseeksize=8
    alignbytes=4, prototype=define
  Linker and Libraries:
    ld='cc', ldflags =' -L/usr/local/lib'
    libpth=/usr/local/lib /lib /usr/lib
    libs=-lgdbm -lgdbm_compat -ldb -ldl -lm -lpthread -lc -lcrypt
    perllibs=-ldl -lm -lpthread -lc -lcrypt
    libc=/lib/libc-2.3.2.so, so=so, useshrplib=true, libperl=libperl.so.5.8.4
    gnulibc_version='2.3.2'
  Dynamic Linking:
    dlsrc=dl_dlopen.xs, dlext=so, d_dlsymun=undef, ccdlflags='-Wl,-E'
    cccdlflags='-fPIC', lddlflags='-shared -L/usr/local/lib'


Characteristics of this binary (from libperl): 
  Compile-time options: MULTIPLICITY USE_ITHREADS USE_LARGE_FILES PERL_IMPLICIT_CONTEXT
  Built under linux
  Compiled at May 10 2006 03:55:26
  @INC:
    /etc/perl
    /usr/local/lib/perl/5.8.4
    /usr/local/share/perl/5.8.4
    /usr/lib/perl5
    /usr/share/perl5
    /usr/lib/perl/5.8
    /usr/share/perl/5.8
    /usr/local/lib/site_perl
    .

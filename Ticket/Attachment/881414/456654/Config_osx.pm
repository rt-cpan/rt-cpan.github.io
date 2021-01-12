#!/usr/bin/perl -w
package Config_osx;

require ExtUtils::FakeConfig;
require Config;

my $ccflags = $Config::Config{ccflags};
my $cppflags = $Config::Config{cppflags};

my $cc = $Config::Config{cc};
my $ccname = $Config::Config{ccname};
my $ld = $Config::Config{ld};
my $cpp = $Config::Config{cpp};
my $cpprun = $Config::Config{cpprun};
my $cppstdin = $Config::Config{cppstdin};
my $lddlflags = $Config::Config{lddlflags};
my $ldflags = $Config::Config{ldflags};

my $flavour = (defined &ActivePerl::BUILD) ? 'activeperl' : 'standard';
my $osxver = get_osx_major_version();

# Remove -nostdinc option
unless(exists($ENV{FAKECONFIG_USE_NOSTDINC}) && $ENV{FAKECONFIG_USE_NOSTDINC}) {
    $ccflags =~ s/-nostdinc //g;
    $cppflags =~ s/-nostdinc //g;
}

# ActivePerl on Snow Leopard +
if(($flavour eq 'activeperl') && ( $osxver >= 10 ) ) {
  $cc       = 'gcc-4.0';
  $ccname   = 'gcc-4.0';
  $ld       = 'g++-4.0';
  $cpp      = 'gcc-4.0 -E';
  $cpprun   = 'gcc-4.0 -E';
  $cppstdin = 'gcc-4.0 -E';
}

# Architectures
if(exists($ENV{FAKECONFIG_USE_ARCHITECTURES}) && $ENV{FAKECONFIG_USE_ARCHITECTURES}) {
    my @arches = qw( ppc i386 x86_64 );
    # arch in $ccflags, $lddlflags, $ldflags
    
    for my $arch ( @arches ) {
       # remove exisiting
       $ccflags   =~ s/-arch $arch //g;
       $ldflags   =~ s/-arch $arch //g;
       $lddlflags =~ s/-arch $arch //g;
       # add required
       if( $ENV{FAKECONFIG_USE_ARCHITECTURES} =~ /$arch/ ) {
           print qq(Using architecture $arch\n);
           $ccflags   = qq(-arch $arch ) . $ccflags;
           $ldflags   = qq(-arch $arch ) . $ldflags;
           $lddlflags = qq(-arch $arch ) . $lddlflags;
       }
    }
    
}

my %values =
  ( cc        => $cc,
    ccflags   => $ccflags,
    cppflags  => $cppflags,
    ccname    => $ccname,
    ld        => $ld,
    cpp       => $cpp,
    cpprun    => $cpprun,
    cppstdin  => $cppstdin,
    lddlflags => $lddlflags,
    ldflags   => $ldflags,
    );

ExtUtils::FakeConfig->import( %values );


sub get_osx_major_version {
   my $verstr =  `uname -r`;
   if( $verstr =~ /^(\d+)/ ) {
       return $1;
   } else {
       die qq(Could not determine OSX version number);
   }
}

1;

__DATA__

=head1 NAME

Config_osx - compile Mac OS X modules without '-nostdinc' flag

=head1 SYNOPSIS

  perl -MConfig_osx Makefile.PL
  make
  make test
  make install

with CPAN.pm/CPANPLUS.pm

  set PERL5OPT=-MConfig_osx
  cpanp

=head1 DESCRIPTION

This module is only useful at Makefile.PL invocation time. It modifies
some %Config values allowing compilation of Perl XS modules without passing
the '-nostdinc' flag. For current versions of ActivePerl, will also set
the required compiler version (gcc-4.0).

You may override the -nostdinc exclusion  by setting environment variable

export FAKECONFIG_USE_NOSTDINC=1

The module also allows you to specify which architectures should be built
by setting the environment variable FAKECONFIG_USE_ARCHITECTURES.
Allowed architectures are ppc, i386, x86_64

For example, to specify universal 32 bit binaries

export FAKECONFIG_USE_ARCHITECTURES="i386 ppc"

to specify combined 32 and 64bit intel binaries

export FAKECONFIG_USE_ARCHITECTURES="i386 x86_64"


=head1 AUTHOR

Mark Dootson <mdootson@cpan.org>

=cut





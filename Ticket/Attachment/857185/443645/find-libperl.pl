#!/usr/bin/perl -w
# Copyright 2002-2009 by Audrey Tang.
# Copyright (c) 2002 Mattia Barbon.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

use strict;
use warnings;
use Config;
use File::Spec;
use ExtUtils::Embed;
use DynaLoader;
use File::Basename;

xsinit(undef);

# used for searching libperls.
sub find_file {
    my $file = shift;

    my @paths = (
	    $Config{bin},
    	File::Spec->catdir($Config{'archlibexp'}, 'CORE'),
	    split(/\Q$Config{path_sep}\E/, $ENV{$Config{ldlibpthname}} || ''),
    	split(/ /, $Config{libpth}),
    );

    my $libperl;
    if ($libperl = DynaLoader::dl_findfile("-lperl")) {
        if (-l $libperl) {
            my $realpath = readlink($libperl);
            if (!File::Spec->file_name_is_absolute($realpath)) {
                $realpath = File::Spec->rel2abs(
                    File::Spec->catfile(
                        dirname($libperl) => $realpath
                    )
                );
            }
            $libperl = $realpath;
        }
        return $libperl if -e $libperl;
    }

    foreach my $path (@paths) {
	    $libperl = File::Spec->catfile($path, $file);
    	return $libperl if -e $libperl;
        
    	# for MinGW
	    $libperl = File::Spec->catfile($path, $1) if $file =~ /^lib(.+)/;
    	return $libperl if -e $libperl;
        
       	# for Cygwin
    	$libperl = File::Spec->catfile($path, $file.$Config{_a});
    	return $libperl if -e $libperl;
    }
}

my $pldflags = ldopts();

my $dynperl = $Config{useshrplib} && ($Config{useshrplib} ne 'false');
$dynperl = 1 if $pldflags =~ /\B-lperl\b/; # Gentoo lies to us!

my $libperl;
if ($dynperl) {
    my $file = $Config{libperl};
    my $so = $Config{so} || 'so';
    $file = "libperl.$so" if $file eq 'libper'; # workaround Red Hat bug

    $file =~ s/\.(?!\d)[^.]*$/.$Config{so}/;
    $file =~ s/^lib// if $^O eq "MSWin32";

    $libperl = find_file($file);
    if (not -e $libperl) {
        $file =~ s/\.(?!\d)[^.]*$/.a/;
        $libperl = find_file($file);
    }
}
else
{
    print "no libperl DSO in use\n";
    exit 0;
}

if (-e $libperl)
{
    print "libperl is \"$libperl\"\n";
    
    my $name = basename($libperl);
    if ($^O =~ /linux/)
    {
        my ($soname) = qx(objdump -ax $libperl) =~ /^\s*SONAME\s+(\S+)/m;
        if ($? == 0 && defined $soname)
        {
            print "soname is \"$soname\"\n";
            $name = $soname;
        }
    }
    print "link name is \"$name\"\n";
}
else
{
    print "libperl appears to be \"$libperl\", but it doesn't exist\n";
}

# local variables:
# mode: cperl
# end:

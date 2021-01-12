#!/usr/bin/perl

#
# Script for reading CPIO archives on the fly. 
# No files are modified or written. 
# Output is sent to STDOUT.
# 
# Add the -v flag to force the script to output additional information.
#
# To read an uncompressed CPIO file: 
# cat file.cpio | ./perl_cpio_out_stdin.pl
#
# To read a compressed CPIO file: 
# uncompress.real -c test.cpio.compressed.Z | ./perl_cpio_out_stdin.pl
# 

use Archive::Cpio;
use strict;

my $VERBOSE = 0;

# read in flags
foreach my $arg (@ARGV)
{
	if ($arg eq '-h' || $arg eq '-help' || $arg eq '--help' || $arg eq '--h')
	{
		print "Usage: cat inputfile | $0 [-v] [-h]\n";
		print "  -v : Print additional information.\n";
		print "  -h : Print this help message.\n";
		exit(0);
	}
	elsif ($arg eq '-v')
	{
		$VERBOSE = 1;
	}
}

# read cpio file
my $cpio = Archive::Cpio->new;
$cpio->read_with_handler(\*STDIN, sub { 
        my ($e) = @_;
	push @{$cpio->{list}}, $e;
    });

# output cpio files to STDOUT
foreach my $cfile ($cpio->get_files())
{
	print "Format: " . $cpio->{archive_format} . "\n" if $VERBOSE;
	print "File: " . $cfile->name() . "\n" if $VERBOSE;
	print "Size: " . $cfile->size() . "\n" if $VERBOSE;
	print "Size (length): " . length($cfile->{data}) . "\n" if $VERBOSE;
	print $cfile->get_content();
	print "__END_OF_FILE__\n" if $VERBOSE;
}


#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}
use Archive::Zip qw( :ERROR_CODES );
use Test::More tests => 8;

my $zip = Archive::Zip->new();
isa_ok( $zip, 'Archive::Zip' );
is( $zip->read('t/data/python.zip'), AZ_OK, 'Read file' );

is( $zip->extractTree( undef, 'extracted/python' ), AZ_OK, 'Extracted archive' );
ok( -d 'extracted/python/Foo-0.2.0', 'Checked directory' );
is( -s 'extracted/python/Foo-0.2.0/bar/__init__.py', 0, 'Checked empty file');

# Now rebuild it.
is( $zip->writeToFileNamed('extracted/new_python.zip'), AZ_OK, 'Write file');

# Use system unzip to unzip it. The test does not fail when use use
# Archive::Zip to unzip it.
system qw(unzip -qqod extracted/new_python extracted/new_python.zip);
# is( $zip->read('extracted/new_python.zip'), AZ_OK, 'Read new file' );
# is( $zip->extractTree( undef, 'extracted/new_python' ), AZ_OK, 'Extracted archive' );

# __init___.py should be 0 bytes.
ok( -d 'extracted/new_python/Foo-0.2.0', 'Checked directory' );
is( -s 'extracted/new_python/Foo-0.2.0/bar/__init__.py', 0, 'Checked empty file');

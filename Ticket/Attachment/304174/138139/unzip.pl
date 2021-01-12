#!/usr/bin/perl
use strict;
use warnings;
use Archive::Zip qw( :ERROR_CODES );
use Digest::MD5;
use Test::More tests => 5;
use Carp;

use constant ERROR_PRONE_FILE => 'error.jpg';
use constant ERROR_FILE       => 'corrupterror.jpg';
use constant ERROR_ARCHIVE    => 'out.zip';

my $zip = Archive::Zip->new();

my ( $before, $after );

##
## OPEN GOOD FILE GET MD5
##
{
	my $md5 = Digest::MD5->new;
	open ( my $fh, '<', ERROR_PRONE_FILE )
		or die 'Can not open file'
	;
	binmode( $fh );
	$before = $md5->addfile( $fh )->md5_hex;
	close $fh;

}


##
## ZIP UP AND WRITE OUT
##
{
	my $md5 = Digest::MD5->new;
	$zip->addFile( ERROR_PRONE_FILE );
	$zip->extractMember( ERROR_PRONE_FILE, ERROR_FILE );
	
	open ( my $fh, '<', ERROR_FILE )
		or die 'Can not open file'
	;
	binmode( $fh );
	$after = $md5->addfile( $fh )->md5_hex;
	close $fh;
	
	unlink ERROR_FILE;

	cmp_ok(
		$after, 'eq', $before
		, 'Failed test, pre-zip, and post-pre-zip do not match'
	);

	my $status = $zip->writeToFileNamed( ERROR_ARCHIVE );
	cmp_ok( $status, '==', AZ_OK, 'Wrote zip out alright' );

}

##
## READ BACK
##
{
	my $md5 = Digest::MD5->new;
	my $zip2;
	eval {
		$zip2 = Archive::Zip->new( ERROR_ARCHIVE );
	};
	ok( !$@, "This stupid bugger crashed again, error:\n$@" );

	ok ( defined $zip2, 'Perl failed at spawning the object of doom' );
		
	$zip2->extractMember( ERROR_PRONE_FILE, ERROR_FILE );

	open ( my $fh, '<', ERROR_FILE )
		or croak 'Can not open file'
	;
	binmode( $fh );
	$after = $md5->addfile( $fh )->md5_hex;
	close $fh;

	unlink ERROR_FILE;
	unlink ERROR_ARCHIVE;

	cmp_ok(
		$after, 'eq', $before
		, 'Failed test, pre-zip, and post-zip do not match'
	);

}

print "Success sums match up all th way through!! Congrats";
print "Verbose: [ $before eq $after ]";

1;

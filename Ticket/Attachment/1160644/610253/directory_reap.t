#!/usr/bin/perl -w

use warnings 'all';
use strict;

use File::Temp qw( tempdir );
use File::Path qw( make_path );
use File::Spec;
use IO::Pipe;
use Cwd;

sub _cwd { File::Spec->rel2abs(Cwd::cwd) }

use Test::More;

my (@tests) = (
	{
		make_tempdir_in => '/base/',
		exit_in         => '/base/',
		label           => 'no chdir',
	},
	{ 
		make_tempdir_in => '/parent/base/',
		exit_in         => '/parent/',
		label           => 'parent dir',
	},
	{
		make_tempdir_in => '/base/',
		exit_in         => '/sibling/',
		label           => 'sibling dir',
	},
	{
		make_tempdir_in => '/base/',
		exit_in         => '/base/nephew/',
		label           => 'nephew dir',
	},
);

for my $test ( @tests ) {
	for my $file ( run_test( $test ) ) { 
		ok( ! -e $file , '$file should be gone in ' . $test->{label} . ' case');
	}
}


sub _make_test { 
	my ( $config ) = @_ ; 
	my $label = $config->{label};
	my $tempdir = tempdir("test.${label}.XXXX", DIR => _cwd , CLEANUP => 1 );
	my $outconfig = {
		make_tempdir_in => File::Spec->catdir( $tempdir , $config->{make_tempdir_in} ),
		exit_in         => File::Spec->catdir( $tempdir , $config->{exit_in} ),
	};
	make_path( $outconfig->{make_tempdir_in} , { verbose => 0 } );
	make_path( $outconfig->{exit_in}         , { verbose => 0 } );
	return $outconfig;
}

sub child { 
	my ( $test_config , $write_pipe ) = @_;
	chdir $test_config->{make_tempdir_in};
	note sprintf "child in %s\n", _cwd;
	my $tempdir = tempdir(  "THISWILLNOTDIE.XXXXX", CLEANUP => 1 );
	note sprintf "child made %s\n",  File::Spec->catdir( Cwd::cwd , $tempdir );
	$write_pipe->printf( "%s\n", File::Spec->catdir( Cwd::cwd , $tempdir ));
	chdir $test_config->{exit_in};
	note sprintf "child exiting in %s\n" , _cwd;
	exit;
}

sub run_test { 
	my ( $config ) = @_; 
	my $real_config = _make_test( $config );
	my $pipe = IO::Pipe->new();
	my $pid = fork;
	if( not $pid ){ 
		child( $real_config, $pipe->writer );
		exit 255;
	}
	my $read = $pipe->reader();
	my (@files) = map { chomp $_;$_ } <$read>;
	waitpid $pid, 0;
	return @files;
}

done_testing;



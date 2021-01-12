#!/usr/bin/perl

# Tests relating to foreign keys.

BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 27;
use File::Spec::Functions ':ALL';
use t::lib::Test;


#####################################################################
# Set up for testing

# Connect
my $file = test_db();
my $dbh  = create_ok(
	file    => catfile(qw{ t xx_foreign_keys_on.sql }),
	connect => [ "dbi:SQLite:$file" ],
);

# Create the test package

#####################################################################
# PRAGMA foreign_keys = ON;

eval <<"END_PERL"; die $@ if $@;
package Foo::Bar;

use strict;
use ORLite {
	file			=> '$file',
	foreign_keys	=> 1,
};

1;
END_PERL


#####################################################################
# Run the tests

my @album = Foo::Bar::Album->select;
is( scalar(@album), 1, 'Got one album object' );
isa_ok( $album[0], 'Foo::Bar::Album' );
is( $album[0]->album_id, 1, 'Got album.album_id' );
is( $album[0]->name, 'Album 1', 'Got album.name' );

my @track = Foo::Bar::Track->select;
is( scalar(@track), 1, 'Got one track object' );
isa_ok( $track[0], 'Foo::Bar::Track' );
is( $track[0]->track_id, 1, 'Got track.track_id' );
is( $track[0]->name, 'Track 1', 'Got track.name' );
isa_ok( $track[0]->album, 'Foo::Bar::Album' );
is( $track[0]->album->album_id, 1, 'Got track.album' );

# insert must fail
eval {
	Foo::Bar::Track->create(
		name	=> 'Track 2',
		album	=> 2,
	);
};
like( $@, qr/foreign key constraint failed/, 'insert with fk violation failed' );

@track = Foo::Bar::Track->select;
is( scalar(@track), 1, 'Got one track object' );

#####################################################################
# PRAGMA foreign_keys = OFF;

eval <<"END_PERL"; die $@ if $@;
package Foo::Bar2;

use strict;
use ORLite {
	file			=> '$file',
};

1;
END_PERL


#####################################################################
# Run the tests

@album = Foo::Bar2::Album->select;
is( scalar(@album), 1, 'Got one album object' );
isa_ok( $album[0], 'Foo::Bar2::Album' );
is( $album[0]->album_id, 1, 'Got album.album_id' );
is( $album[0]->name, 'Album 1', 'Got album.name' );

@track = Foo::Bar2::Track->select;
is( scalar(@track), 1, 'Got one track object' );
isa_ok( $track[0], 'Foo::Bar2::Track' );
is( $track[0]->track_id, 1, 'Got track.track_id' );
is( $track[0]->name, 'Track 1', 'Got track.name' );
isa_ok( $track[0]->album, 'Foo::Bar2::Album' );
is( $track[0]->album->album_id, 1, 'Got track.album' );

# insert succeeds
my $track = Foo::Bar2::Track->create(
	name	=> 'Track 2',
	album	=> 2,
);
isa_ok( $track, 'Foo::Bar2::Track' );
is( $track->name, 'Track 2', 'Got track.name' );
is( $track->album, undef, 'no linked album' );

@track = Foo::Bar2::Track->select;
is( scalar(@track), 2, 'Got two track objects' );

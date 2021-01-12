#!/usr/bin/perl

# mysql -h localhost -u root -p
# CREATE DATABASE greetings CHARACTER SET utf8;
# CREATE USER 'greetings'@'localhost' IDENTIFIED BY 'Cahphah3';
# GRANT INSERT,SELECT,UPDATE,DELETE ON greetings.* to 'greetings'@'localhost';
# USE greetings;
# CREATE TABLE greetings (text varchar(255) PRIMARY KEY);
#
# Settings in /etc/my.cnf:
#
# [client]
# default-character-set = utf8
#
# [server]
# collation-server = utf8_unicode_ci
# init-connect='SET NAMES utf8'
# character-set-server = utf8

use strict;
use warnings;

use utf8;

my $greeting = 'Grüß Gott';

my $dsn      = 'DBI:mysql:database=greetings;host=localhost';
my $user     = 'greetings';
my $pw       = 'Cahphah3';
my $args     = { mysql_enable_utf8 => 1 };

package Greetings::Schema::Result::Greetings;

use parent qw(DBIx::Class::Core);

__PACKAGE__->table('greetings');

__PACKAGE__->add_columns( 'text' => { data_type => 'varchar', size => 255 },
);

__PACKAGE__->set_primary_key('text');

package Greetings::Schema;

use parent qw(DBIx::Class::Schema);

__PACKAGE__->register_class( 'Greetings',
    'Greetings::Schema::Result::Greetings' );

package main;

my $schema = Greetings::Schema->connect( $dsn, $user, $pw, $args );

for ( 1 .. 2 ) {
    $schema->resultset('Greetings')->find_or_create( { text => $greeting } );
}

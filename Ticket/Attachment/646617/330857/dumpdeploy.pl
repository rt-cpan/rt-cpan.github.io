#!/usr/bin/perl

use strict;
use warnings;

package Some::Schema::Loader;
use base qw/DBIx::Class::Schema::Loader/;

__PACKAGE__ -> loader_options (
  dump_directory => '/tmp', 
	constraint => '^(test)$',
);

# Constants
our $dbname = "ABC";
our $dburo = "DEF";
our $dbpro = "GHI";
our $dbhost = "jkl";

sub new {
	my $self = shift;
	$self->connect(
		"dbi:mysql:dbname=$dbname:host=$dbhost",
		$dburo,
		$dbpro,
	);
}

1;

package main;

my $schema = Some::Schema::Loader -> new();
$schema -> dump_to_dir;
print $schema -> deployment_statements, "\n";

1;


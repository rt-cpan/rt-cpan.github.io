use strict;
use warnings;
use Test::More tests => 6;
use Test::Exception;
use lib 't/lib';

###########################################################################
{
	# Testform for updating has_many relations with Select-fields 
	package BookDB::Form::User4;

	use HTML::FormHandler::Moose;
	extends 'HTML::FormHandler::Model::DBIC';
	with 'HTML::FormHandler::Render::Simple';


	has '+item_class' => ( default => 'User');

	has_field 'addresses' => ( type => 'Select', multiple => 1);

	# HFH does not now how to fetch the options for 'addresses' from database
	# -> providing options
	sub options_addresses{
		my $self = shift;
		my $schema = $self->schema;
		my $addr_rs = $schema->resultset('Address');
		return [map { {label => $_->country_iso . '/' . $_->city . '/' . $_->street, value => $_->address_id} } $addr_rs->all];
	}

	no HTML::FormHandler::Moose;
	1;
}
###########################################################################

use_ok( 'HTML::FormHandler' );
use_ok( 'BookDB::Schema');

my $schema = BookDB::Schema->connect('dbi:SQLite:t/db/book.db');
ok($schema, 'get db schema');

my $user = $schema->resultset('User')->find('1');
my $form = BookDB::Form::User4->new(item => $user, );
ok( $form, 'form creation' );

my $orig = $form->values;
ok( $orig, 'extracting values' );

lives_ok {$form->process(params => $orig)} 'running form->process with has_many relation' ;


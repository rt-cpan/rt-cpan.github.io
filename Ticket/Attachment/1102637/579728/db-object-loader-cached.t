#!/usr/bin/env perl
# BUG: When you use Rose::DB::Object::Loader,
# init_db method of the base_class does not work
# ---------------- SETUP
{

  package My::DB;
  use strict;
  use warnings;

  use parent qw(Rose::DB);
  use File::Temp qw/ tempfile /;
  my ($fh, $filename) = tempfile();

  __PACKAGE__->use_private_registry;
  __PACKAGE__->register_db(driver => 'sqlite', database => $filename,);


CREATE: {
    my $dbh = __PACKAGE__->new()->retain_dbh;
    $dbh->do('DROP TABLE IF EXISTS `sites`');
    $dbh->do(<<CREATE);
CREATE TABLE `sites` (
  `id` int(10) NOT NULL,
  `host` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
CREATE


  }
}
{

  package My::DB::Object;
  use parent 'Rose::DB::Object';

  use Mojo::Base -strict;

  # CACHED!!!
  sub init_db {
    return My::DB->new_or_cached;
  }
}
{

  package My::Model::Site;

  use strict;
  use base qw(My::DB::Object);

  __PACKAGE__->meta->setup(
    table => 'sites',

    columns => [
      id   => {type => 'serial',  not_null => 1},
      host => {type => 'varchar', length   => 45},
    ],

    primary_key_columns => ['id'],
  );
}

# ---------------- TEST RIGHT NOW
package main;
use strict;
use warnings;
use Rose::DB::Object::Loader;
use Test::More tests => 3;
use Test::Deep;


#1: works as expected
is(My::Model::Site->new()->dbh, My::Model::Site->new()->dbh, 'cached dbh');

# overwrite our model with the help of the loader
my $loader = Rose::DB::Object::Loader->new(
  db_class     => 'My::DB',
  base_classes => 'My::DB::Object',
  class_prefix => 'My::Model::',
);
cmp_deeply [$loader->make_classes],
  [qw/My::Model::Site My::Model::Site::Manager/];

#2: fail! init_db with new_or_cached does not work after loader's work
is(
  My::Model::Site->new()->dbh,
  My::Model::Site->new()->dbh,
  'cached dbh (loader)'
);

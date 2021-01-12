package BugReport;

use 5.10.0;
use strict;
use warnings;
use Rose::DB;
our @ISA = qw( Rose::DB );
use Data::Dumper;

__PACKAGE__->use_private_registry;
__PACKAGE__->register_db(
    driver   => 'sqlite',
    database => 'bug_report.sqlite',
);

sub setup_modules {
    require Cwd;
    require File::Basename;
    require Rose::DB::Object::Loader;
    my $dir = $_[0] // Cwd::cwd();
    my $class = __PACKAGE__;
    Rose::DB::Object::Loader->new(
        db => new $class,
        class_prefix => $class
    )->make_modules(
        module_dir    => $dir,
        with_managers => 1,
    );
}
1;

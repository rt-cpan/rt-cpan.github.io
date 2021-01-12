#!/usr/bin/perl -w

# This is a test of the verification of the arguments to
# WriteMakefile.

BEGIN {
    if( $ENV{PERL_CORE} ) {
        chdir 't' if -d 't';
        @INC = ('../lib', 'lib');
    }
    else {
        unshift @INC, 't/lib';
    }
}

use strict;
use Test::More tests => 8;

use TieOut;
use MakeMaker::Test::Utils;
use MakeMaker::Test::Setup::BFD;

use ExtUtils::MakeMaker;

chdir 't';

perl_lib();

ok( setup_recurs(), 'setup' );
END {
    ok( chdir File::Spec->updir );
    ok( teardown_recurs(), 'teardown' );
}

ok( chdir 'Big-Dummy', "chdir'd to Big-Dummy" ) ||
  diag("chdir failed: $!");

{
    ok( my $stdout = tie *STDOUT, 'TieOut' );
    my $warnings = '';
    local $SIG{__WARN__} = sub {
        $warnings .= join '', @_;
    };

    eval {
      WriteMakefile(
        NAME            => 'Big::Dummy',
        MIN_PERL_VERSION       => 5,
      );
    };
    is $warnings, '';
    is $@, '','MIN_PERL_VERSION=5';

    $warnings = '';
    eval {
      WriteMakefile(
        NAME            => 'Big::Dummy',
        MIN_PERL_VERSION       => 999999,
      );
    };
    is $@, "This distribution won't work without a higher version of Perl.\n",
    'MIN_PERL_VERSION=999999';

}

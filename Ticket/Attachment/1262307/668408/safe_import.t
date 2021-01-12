#!perl

use Test::More;

use strict;
use warnings;
use Test::Fatal;

use Import::Into;
use Safe;


{
    package I;
    use Exporter 'import';
    our @EXPORT = qw[ i ii ];

    sub i  { return 'I' }
    sub ii { return 'II' }
    sub iii { return 'III' }
}

# Safe compartment
my $cpt = Safe->new( 'AA' );

subtest 'define in Safe package via eval' => sub {

  SKIP: {

        is( exception { eval 'package AA; sub aa { q[AA] } ; 1;' or die $@ },
            undef, 'eval' )
          or skip 'bad eval', 2;

        ok( $cpt->reval( 'exists $::{aa}' ), "exists in symbol table" )
          or skip 'bad exists', 1;

        is( $cpt->reval( 'aa()' ), 'AA', 'evaluate' );
    }
};

subtest 'I->import::into Safe package' => sub {
  SKIP: {
        is( exception { I->import::into( 'AA', 'i' ) }, undef, 'import::into' )
          or skip "failed import", 2;

        ok( $cpt->reval( 'exists $::{i}' ), "exists in symbol table" )
          or skip 'bad exists', 1;

        is( $cpt->reval( 'i()' ), 'I', 'evaluate sub' );
    }
};

subtest 'I->import in Safe package via eval' => sub {

  SKIP: {

        is( exception { eval "package AA; I->import( 'ii' ); 1;" or die $@ },
            undef, 'eval' )
          or skip 'bad eval', 2;

        ok( $cpt->reval( 'exists $::{ii}' ), "exists in symbol table" )
          or skip 'bad exists', 1;

        is( $cpt->reval( 'ii()' ), 'II', 'evaluate sub' );
    }
};

subtest 'Manipulate Safe Symbol Table directly' => sub {

  SKIP: {

        is( exception { *{AA::iii} = \&I::iii },
            undef, 'eval' )
          or skip 'bad eval', 2;

        ok( $cpt->reval( 'exists $::{iii}' ), "exists in symbol table" )
          or skip 'bad exists', 1;

        is( $cpt->reval( 'iii()' ), 'III', 'evaluate sub' );
    }
};

subtest 'I->import::into normal package' => sub {
  SKIP: {
        is( exception { I->import::into( 'BB', 'i' ) }, undef, 'import::into' )
          or skip "failed import", 2;

        ok( exists $BB::{i}, "exists in symbol table" )
          or skip 'bad exists', 1;

        is( BB::i->(), 'I', 'evaluate sub' );
    }
};


subtest 'I->import in normal package via eval' => sub {

  SKIP: {

        is( exception { eval "package BB; I->import( 'ii' ); 1;" or die $@ },
            undef, 'eval' )
          or skip 'bad eval', 2;

        ok( exists $BB::{ii}, "exists in symbol table" )
          or skip 'bad exists', 1;

        is( BB::ii->(), 'II', 'evaluate sub' );
    }
};

done_testing;

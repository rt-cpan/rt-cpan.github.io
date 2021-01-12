#!/usr/bin/perl

use strict;
use Convert::Binary::C;
use Data::Dumper;
use Tie::Hash::Indexed;

##
## test C code
##

my $testCode = <<'EOF';

struct S1
{
    int count;
    int array[];
};

struct S2
{
    struct S1 foo;
    int bar;
};

EOF

##
## create converter, parse code
## 

my $c = new Convert::Binary::C;
$c->OrderMembers(1);

$c->parse( $testCode );
$c->tag( 'S1.array', Dimension => 'count' );

##
## test unpacking
##

my $binString = pack( "I*", 1, 2, 3  );

{
    my @unpacked;
    eval {
	@unpacked = $c->unpack( "struct S2", $binString );
    };
    if ( $@ ) {
	print STDERR "exception: $@\n";
    }
    print "array mode yields:\n" . Dumper( @unpacked );
}

{
    my $unpacked;
    eval {
	$unpacked = $c->unpack( "struct S2", $binString );
    };
    if ( $@ ) {
	print STDERR "exception: $@\n";
    }
    print "string mode yields:\n" . Dumper( $unpacked );
}


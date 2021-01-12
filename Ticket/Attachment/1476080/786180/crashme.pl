use strict;
use warnings;

{

    package Foo;
    use Moose;
    use MooseX::Params::Validate;

    sub validate {
        my $self = shift;
        warn "  validating";
        my ($events) =
          pos_validated_list( \@_, { isa => 'ArrayRef[ArrayRef]' } );
        return;
    }
}

sub get_content {
    my ( $col_cnt, $row_cnt ) = @_;

    my @content;

    for ( 1 .. $row_cnt ) {
        push @content, [ map { "value for column $_" } 1 .. $col_cnt ];
    }

    return \@content;
}

my $row_cnt = 1;

while ( $row_cnt < 100_000 ) {
    
    warn "trying $row_cnt rows\n";

    my $content = get_content( 10, $row_cnt );

    my $foo = Foo->new;
    $foo->validate($content);

    $row_cnt *= 2;
}

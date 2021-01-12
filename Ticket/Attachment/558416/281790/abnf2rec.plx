#!/usr/bin/perl -w

use Parse::ABNF;

use strict;

my $rules = Parse::ABNF->new->parse(join "", <>);

# Not handled are..
# A /= B
my %ABNF2Rec = (
    Rule        => sub {
        my $rule = shift;

        my $name = fix_name($rule);
        return sprintf "%-20s %s\n", "$name:", value($rule);
    },

    Choice      => sub {
        my $rule = shift;
        return join " | ", value($rule);
    },

    Group       => sub {
        my $rule = shift;
        return sprintf "(%s)", join " ", value($rule);
    },

    Reference => sub {
        my $rule = shift;
        return fix_name($rule);
    },

    Repetition => sub {
        my $rule = shift;

        my($min, $max) = map { defined $_ ? $_ : '' } $rule->{min}, $rule->{max};
        return sprintf "%s(%s..%s)", value($rule), $min, $max;
    },

    Literal => sub {
        my $rule = shift;

        return sprintf qq['%s'], $rule->{value};
    },

    ProseValue => sub {
        my $rule = shift;

        return value($rule);
    },

    String => sub {
        my $rule = shift;

        return sprintf q["%s"], join "", to_hexchars($rule->{type}, $rule->{value});
    },

    Range => sub {
        my $rule = shift;

        return sprintf q{/[%s-%s]/}, to_hexchars($rule->{type}, [$rule->{min}, $rule->{max}]);
    }
);

sub to_hexchars {
    my($type, $values) = @_;

    my $converter = $type eq 'hex'          ? sub { hex $_[0] }         :
                    $type eq 'binary'       ? sub { oct "0b$_[0]" }     :
                    $type eq 'decimal'      ? sub { $_[0] }             :
                                              die "Unknown type: $type" ;

    return map { sprintf '\x%02X', $converter->($_) } @$values;
}

sub value {
    my $rule = shift;
    my @values = ref $rule->{value} eq 'ARRAY' ? @{$rule->{value}} : $rule->{value};

    return map { ref $_ ? convert($_) : $_ } @values;
}

sub convert {
    my $rule = shift;

    return $ABNF2Rec{$rule->{class}}->($rule);
}

# RecDescent only allows /[A-Za-z]\w*/ as rule names.
sub fix_name {
    my $rule = shift;
    my $name = $rule->{name};
    $name =~ s{[^A-Za-z\w*]}{_}g;
    return $name;
}

print join '', map { convert($_) } @$rules;




use XML::Bare qw/forcearray/;
use Data::Dumper;

example_1();
example_2();
example_3();

sub example_1 {
    my ( $ob, $xml ) = XML::Bare->simple( text => "
        <xml>
            <person>
                <age>25</age>
            </person>
        </xml>
    " );
    XMLSimpleForceArray( $xml, nodenames => [ qw/person/ ] );
    print Dumper( $xml );
}

sub example_2 {
    my ( $ob, $xml ) = XML::Bare->simple( text => "
        <xml>
            <person>
                <age>25</age>
            </person>
            <do_not_touch>
                <person>
                    <name>Bob</name>
                </person>
            </do_not_touch>
        </xml>
    " );
    XMLSimpleForceArray( $xml, dotpaths => [ qw/xml.person/ ] );
    print Dumper( $xml );
}
sub example_3 {
    my ( $ob, $xml ) = XML::Bare->simple( text => "
        <a c=3>
            <b>2</b>
        </a>
    " );
    XMLSimpleForceArray( $xml, forceall => 1 );
    print Dumper( $xml );
}

sub XMLSimpleForceArray {
    my $xml = shift;
    my $ops = { @_ };
    if( $ops->{'nodenames'} ) {
        my $nodenames = $ops->{'nodenames'};
        my $namehash = {};
        for my $nodename ( @$nodenames ) {
            $namehash->{ $nodename } = 1;
        }
        XSFA_recurse( $xml, $namehash );
    }
    
    if( $ops->{'dotpaths'} ) {
        my $arrpaths = [];
        my $dotpaths = $ops->{'dotpaths'};
        for my $dotpath ( @$dotpaths ) {
            my @arr = split( '\.', $dotpath );
            push( @$arrpaths, \@arr );
        }
        $ops->{'arraypaths'} = $arrpaths;
        delete $ops->{'dotpaths'};
    }
    
    if( $ops->{'arraypaths'} ) {
        my $nodepaths = $ops->{'arraypaths'};
        my $pathhash = {};
        for my $nodepath ( @$nodepaths ) {
            my $pathtext = join( '--', @$nodepath );
            $pathhash->{ $pathtext } = 1;
        }
        XSFA_path_recurse( $xml, '', $pathhash );
    }
    
    if( $ops->{'forceall'} ) {
        XSFA_all_recurse( $xml );
    }
}

sub XSFA_all_recurse {
    my ( $xml ) = @_;
    my $ref = ref( $xml );
    return if( !$ref );
    if( $ref eq 'ARRAY' ) {
        for my $item ( @$xml ) {
            XSFA_all_recurse( $xml );
        }
    }                             
    elsif( $ref eq 'HASH' ) {
        for my $key ( keys %$xml ) {
            my $val = $xml->{ $key };
            $xml->{ $key } = [ $val ];
            XSFA_all_recurse( $val );
        }
    }
    else { die "Error"; }
}

sub XSFA_path_recurse {
    my ( $xml, $path, $pathhash ) = @_;
    my $ref = ref( $xml );
    return if( !$ref );
    if( $ref eq 'ARRAY' ) {
        for my $item ( @$xml ) {
            XSFA_path_recurse( $item, $path, $pathhash );
        }
    }
    elsif( $ref eq 'HASH' ) {
        for my $key ( keys %$xml ) {
            my $val = $xml->{ $key };
            my $p1 = $path ? "$path--$key" : $key;
            if( $pathhash->{ $p1 } ) {
                $xml->{ $key } = [ $val ];
            }
            XSFA_path_recurse( $val, $p1, $pathhash );
        }
    }
    else { die "Error"; }
}

sub XSFA_recurse {
    my ( $xml, $namehash ) = @_;
    my $ref = ref( $xml );
    return if( !$ref );
    if( $ref eq 'ARRAY' ) {
        for my $item ( @$xml ) {
            XSFA_recurse( $item, $namehash );
        }
    }
    elsif( $ref eq 'HASH' ) {
        for my $key ( keys %$xml ) {
            my $val = $xml->{ $key };
            if( $namehash->{ $key } ) {
                $xml->{ $key } = [ $val ];
            }
            XSFA_recurse( $val, $namehash );
        }
    }
    else { die "Error"; }
}
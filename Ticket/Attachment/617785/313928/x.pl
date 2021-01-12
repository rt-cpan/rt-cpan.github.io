use strict;
use warnings;


sub foo {
    my $file = shift();

    require IO::Uncompress::Bunzip2;
    my $fh = IO::Uncompress::Bunzip2->new( $file )
        or die( "Error opening '$file' with IO::Uncompress::Bunzip2" );
    
    my $str;
    my $buff;
    $str .= $buff while $fh->read( $buff, 4096 ) > 0;
    $fh->close();
    
    return $str;
};

warn foo( shift() );

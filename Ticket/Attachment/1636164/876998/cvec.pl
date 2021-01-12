use Image::Libpuzzle; 
use Text::Levenshtein qw(distance);

sub signature_as_char_string1 { return(join('',map($_+2,unpack("c*", $_[0])))); }

my($p1,$p2) = (Image::Libpuzzle->new,Image::Libpuzzle->new);
my($str1,$str2) = (
  signature_as_char_string1($p1->fill_cvec_from_file($ARGV[0])),
  signature_as_char_string1($p2->fill_cvec_from_file($ARGV[1]))
);

printf("%.2d%% \t$ARGV[0] vs $ARGV[1]\n",(length($str1)-distance($str1,$str2))*100/length($str1));


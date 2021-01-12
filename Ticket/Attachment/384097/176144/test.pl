use lib "./perl5/site_perl/5.8.0";

use IO::Uncompress::AnyUncompress; # handle gzip/bzip2/zip/lzf compressed input files

my $fn = 'test.gz';
my $in;
my $line;



### Does not detect packed format:
$in = new IO::Uncompress::AnyUncompress $fn;
if (!defined($in)) {
  die "Fatal: Failed to load file: $IO::Uncompress::AnyUncompress::AnyUncompressError\n";
}
while($line = <$in>) {
  print $line;
}


exit 0;


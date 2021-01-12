#!/usr/pkg/bin/perl

use Digest::SHA1 qw(sha1_hex);
use MPEG::Audio::Frame;

my $sha1 = Digest::SHA1->new();
open IN, "<", $ARGV[0] || die("Can't open input!");

my $h;
while (1) {
	my $n = read IN, $h, 10;
	unless ($n==10 && $h =~ /^ID3/) {
		seek(IN, -$n, 1);
		last;
	};
	print "found id3 tag ";
	my @szb = unpack("C4", substr($h, 6, 4));
	my $len = ((((($szb[0] << 7) | $szb[1]) << 7) | $szb[2]) << 7) | $szb[3];	# 7-bit ints, sigh
	print "len $len\n";
	seek (IN, $len, 1);
};

# print "starting parse at " . tell(IN) . "\n";

tie *MP3, 'MPEG::Audio::Frame', *IN;
while (<MP3>) {
	$sha1->add($_);
	# print "off " . $_->offset . " length " . $_->length . " " . sha1_hex($_->asbin()) . "\n";

}
print "SHA1-" . $sha1->hexdigest() . "\n";

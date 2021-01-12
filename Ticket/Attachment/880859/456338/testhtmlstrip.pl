use encoding 'utf8';

use Encode;
use HTML::Strip;
my $htmlstrip = HTML::Strip->new();

my $match = {};
$text = 's&sup2;';

$text = $htmlstrip->parse($text);
print "not encoded: " . $text . "\n";
print "encoded: " . encode_utf8($text) . "\n";

print "STRIPPED TEXT: " . $text . "\n";

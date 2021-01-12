use strict;
use warnings;

use Carp::Always;
use DateTime;
use XML::Compile::Schema;
use XML::Compile::Util 'pack_type';
use XML::LibXML;

my $now = DateTime->now(time_zone => 'UTC');

my $data = {
    interface_name => {
        transaction_id => 'unique_id_here',
        Userid => '1234',
        UtcDateAndTime => {
            DayOfWeek => $now->day_name,
            DayOfMonth => sprintf('%02d', $now->day_of_month),
            Month => $now->month_abbr,
            Year => $now->year,
            Hour => sprintf('%02d', $now->hour),
            Minute => sprintf('%02d', $now->minute),
            Second => sprintf('%02d', $now->second),
        },
    },
};

# this should be moved to the module_share dir
my $schema = XML::Compile::Schema->new('complextype.xsd');

my $doc = XML::LibXML::Document->new('1.0', 'UTF-8');

my $write = $schema->compile(
    WRITER => pack_type('', 'interface_name'),
);

my $xml = $write->($doc,
# this only works if our XSD isn't insane:
# - no mixed=true for simple types
# - no complex types for the simple types
    $data->{interface_name},
);

$doc->setDocumentElement($xml);

print "XML GENERATED:\n";
print $doc->toString(1);


use Mac::PropertyList qw(:all);
my $filename = 'CR17413.plist';
my $data  = parse_plist_file( $filename );
use Data::Dumper;
print Dumper($data);

use v5.10;

use DateTime::TimeZone::Tzfile;
use DateTime;

$zone = DateTime::TimeZone::Tzfile->new(
    filename => "/usr/share/zoneinfo/America/Chicago",
);
$dt = DateTime->new(
    year => 3000, month => 8, day => 1,
    time_zone => 'America/Chicago',
);

$dt_tzfile = DateTime->new(
    year => 3000, month => 8, day => 1,
    time_zone => $zone,
);

say "DateTime::TimeZone";
say $dt;
say $dt->is_dst;

say "DateTime::TimeZone::Tzfile";
say $dt_tzfile;
say $dt_tzfile->is_dst;

__END__
DateTime::TimeZone
3000-08-01T00:00:00
1
DateTime::TimeZone::Tzfile
3000-08-01T00:00:00


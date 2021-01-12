use Geo::Ellipsoid;

$geo = Geo::Ellipsoid->new(
	ellipsoid=>'WGS84',
	units=>'degrees',
	distance_units => 'kilometer',
);

my @origin = ( 48.849954, 2.333179 ); # paris 
my $range = 300;

print<<EOF;
<?xml version="1.0"?>
<gpx version="1.0" creator="Geo::Ellipsoid" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.topografix.com/GPX/1/0" xsi:schemaLocation="http://www.topografix.com/GPX/1/0 http://www.topografix.com/GPX/1/0/gpx.xsd">
  <trk>
    <name>Track</name>
    <trkseg>
EOF

for($bearing=0; $bearing<=360; $bearing +=10 ) {
	my ($lat,$lon) = $geo->at( @origin, $range, $bearing );
	#$lon = $lon - 360 if $lon > 180;
	printf("\t\t<trkpt lat=\"%s\" lon=\"%s\"></trkpt>\n", $lat, $lon);
}

print<<EOF;
    </trkseg>
  </trk>
</gpx>
EOF

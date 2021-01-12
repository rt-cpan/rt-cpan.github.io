#!/usr/bin/perl

use DateTime();
use DateTime::Event::Sunrise();

# Script to test DateTime::Event::Sunrise() results in a particular
# time range.

if (@ARGV == 0) {
    @ARGV = (1212537601, 1, 1, '46.74575,65.2488');
} else {
    die "Usage: $0 epochSeconds incSeconds count lat,long\n"
	if @ARGV != 4;
}

my $t = $ARGV[0];
my $inc = $ARGV[1];
my $count = $ARGV[2];
my ($latitude, $longitude) = split(',', $ARGV[3]);

my $dt = DateTime->from_epoch(epoch => $t);

my $sunRisePrevTime;
my $sunRiseNextTime;
my $sunSetPrevTime;
my $sunSetNextTime;

my @errors = ();

my $sunrise = DateTime::Event::Sunrise->sunrise(
	longitude => -$longitude,
	latitude => $latitude,
	iteration => '1',
    );
my $sunset = DateTime::Event::Sunrise->sunset(
	longitude => -$longitude,
	latitude => $latitude,
	iteration => '1',
    );

# Error examples:
#
#   for lat/long: 46.74575,65.2488
#     sunSetPrevTime(1212538107) > dt(1212537601)
#     Jun  3 21:38:27 2008	 > Jun  3 21:30:00 2008
#     repeat by: srTest.pl 1212537601 1 1 46.74575,65.2488
#   for lat/long: 64.74575,220.2488
#     sunRiseNextTime(1212509861) < dt(1212536601)
#     Jun  3 13:47:41 2008        < Jun  3 21:13:21 2008
#     repeat by: srTest.pl 1212536601 1 1 64.74575,220.2488
#
# 
print "inc=$inc, count=$count, lat=$latitude, long=$longitude\n";
for (my $i = 0; $i < $count; ++$i) {
    $sunRisePrevTime = $sunrise->current($dt)->epoch();
    $sunRiseNextTime = $sunrise->next($dt)->epoch();
    $sunSetPrevTime = $sunset->previous($dt)->epoch();
    $sunSetNextTime = $sunset->next($dt)->epoch();

    @errors = ();
    if ($sunRisePrevTime >= $sunRiseNextTime) {
	push(@errors, "sunRisePrevTime >= sunRiseNextTime");
    }
    if ($sunSetPrevTime >= $sunSetNextTime) {
	push(@errors, "sunSetPrevTime >= sunSetNextTime");
    }
    if ($sunRisePrevTime > $t) {
	push(@errors, "sunRisePrevTime > t");
    }
    if ($sunSetPrevTime > $t) {
	push(@errors, "sunSetPrevTime > t");
    }
    if ($sunRiseNextTime < $t) {
	push(@errors, "sunRiseNextTime < t");
    }
    if ($sunSetNextTime < $t) {
	push(@errors, "sunSetNextTime < t");
    }

    if (@errors || $i % (60 * 60) == 0) {
	if (@errors) {
	    print "Error:\n\t", join("\n\t", @errors), "\n";
	}
	print "time = $t : " . localtime($t) . "\n";
	print "sunRisePrevTime = $sunRisePrevTime : " . localtime($sunRisePrevTime)
	    . "\n";
	print "sunRiseNextTime = $sunRiseNextTime : " . localtime($sunRiseNextTime)
	    . "\n";
	print "sunSetPrevTime  = $sunSetPrevTime : " . localtime($sunSetPrevTime)
	    . "\n";
	$| = 1;
	print "sunSetNextTime  = $sunSetNextTime : " . localtime($sunSetNextTime)
	    . "\n";
	$| = 0;
    }
    $dt->add('seconds' => $inc);
    $t += $inc;
}

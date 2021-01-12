#!/usr/bin/perl -w



use lib ("/root");

use Date::Holidays::Generic;

my $daysoff = {
	'2007' => {
		'1' => {
			'1' => 'Ano Nuevo',
			'6' => 'Reyes',
		},
		'2' => {
			'14' => 'San Valentin',
                },
		'3' => {
			'12' => 'Putitas day',
                },
		'4' => {
			'22' => 'Patitos days',
                },
	},
};

my $holidays = Date::Holidays::Generic->new();

$holidays->load_holidays($daysoff);

print "Nos vamos :-) ..... \n" if ($holidays->is_holiday(year => '2007', month => '1', day => '5'));

exit;

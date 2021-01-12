use Test;
use lib "lib";
BEGIN { plan tests => 41 };
use Parse::Syslog;
ok(1); # If we made it this far, we're ok.

#########################

my $parser = Parse::Syslog->new("t/syslog-ng", year=>2006);
open(PARSED, "<t/syslog-ng-parsed") or die "can't open t/syslog-ng-parsed: $!\n";
while(my $sl = $parser->next) {
	my $is = '';
	$is .= "time    : ".(localtime($sl->{timestamp}))."\n";
	$is .= "host    : $sl->{host}\n";
	$is .= "program : $sl->{program}\n";
	$is .= "pid     : ".(defined $sl->{pid} ? $sl->{pid} : 'undef')."\n";
	$is .= "text    : $sl->{text}\n";
	$is .= "facility: $sl->{facility}\n";
	$is .= "level   : $sl->{level}\n";
	$is .= "\n";
	print "$is";

	my $shouldbe = '';
	$shouldbe .= <PARSED>;
	$shouldbe .= <PARSED>;
	$shouldbe .= <PARSED>;
	$shouldbe .= <PARSED>;
	$shouldbe .= <PARSED>;
	$shouldbe .= <PARSED>;
	$shouldbe .= <PARSED>;
	$shouldbe .= <PARSED>;

	ok($is, $shouldbe);
}

# vim: set filetype=perl:

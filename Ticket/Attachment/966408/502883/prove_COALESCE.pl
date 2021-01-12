#!/usr/bin/perl -w
# prove_COALESCE.pl

use strict;
use warnings;

use DBI;

my $dbh_voip_code = DBI->connect(
    "DBI:CSV:",
    undef, undef,
    {
        f_dir        => '.',
        f_ext        => ".csv/r",
        csv_eol      => "\n",
        csv_sep_char => ',',
        RaiseError   => 1,
        PrintError   => 1,
    }
) or die "Cannot connect: " . $DBI::errstr;

$dbh_voip_code->{csv_tables}->{'newest.csv'} = {
    file      => 'newest.csv',
};

my $sth_voip_code = $dbh_voip_code->prepare(
    qq|
        CREATE TABLE newest AS 
		SELECT dialplan_canonical_number AS country_code, 
		       COALESCE(exchange_mobileoperator, dialplan_canonical_chargeband) AS country, 
		       exchange_day AS rate_peak, 
			   exchange_evening AS rate_offpeak,
			   NULL AS rate_connfee,
			   exchange_weekend AS rate_weekend
		FROM newer.csv
      |
);
$sth_voip_code->execute or die "Cannot execute: " . $sth_voip_code->errstr();

DBI->trace(1);

$sth_voip_code->finish;

$dbh_voip_code->disconnect;


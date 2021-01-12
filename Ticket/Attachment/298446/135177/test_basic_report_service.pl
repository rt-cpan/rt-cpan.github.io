#!/usr/local/bin/perl

use strict; use warnings;

use Data::Dumper;
use Yahoo::Marketing::BasicReportRequest;
use Yahoo::Marketing::BasicReportService;
use SOAP::Lite +trace => 'debug';

my $report_service = Yahoo::Marketing::BasicReportService->new->parse_config( section => 'sandbox' );
my $account_id     = $report_service->account;

sub get_report {
    my %data = @_;

    my $request = Yahoo::Marketing::BasicReportRequest->new;

    foreach my $key (keys %data) {
        $request->$key($data{$key});
    }

    return $report_service->addReportRequestForAccountID(
        accountID => $account_id, reportRequest => $request
    );
}



my $start_date = DateTime->now;
   $start_date->subtract( days => 7 );
my $end_date   = DateTime->now;

my $report_id = get_report(
    startDate  => $start_date,
    endDate    => $end_date,
    reportType => 'KeywordSummary',
    reportName => 'Some Keyword Report',
);

print "\n\nGot report ID: $report_id\n";

#! /usr/bin/perl
use strict;
use warnings;

require MIME::Entity;

my $top=MIME::Entity->build(
	"Type"=>"multipart/mixed",
	"From"=>'lace@jankratochvil.net',
	"To"=>'lace@jankratochvil.net',
	"Subject"=>"test0",
);
$top->attach(
	"Data"=>"plain",
	"Type"=>"text/plain",
	);
$top->print();
#exit;
$top->smtpsend();

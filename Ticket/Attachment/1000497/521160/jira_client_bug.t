#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;
use Test::More tests => 10;
use Blackjack::Config;
use Blackjack::Utils::File qw/blackjack_base_dir/;
use JIRA::Client;
use Data::Dumper::Concise;

sub load_config {

	my $config = Blackjack::Config->new();
	my $blackjack_base_dir = blackjack_base_dir();

	$config->base_dir( $blackjack_base_dir );
	$config->setup();

	my $conf = $config->config();

	return $conf;
}

our $TYPES = {
	1 => "Bug",
	2 => "New Feature",
	3 => "Task",
	4 => "Improvement",
	6 => "Epic",
	7 => "Story",
	8 => "Technical task",
};

my $conf = &load_config();

my $jira_url = $conf->{jira_url} || $conf->{jira_hostname};
my $jira_user = $conf->{jira_username};
my $jira_passwd = $conf->{jira_password};

my $client = JIRA::Client->new( $jira_url, $jira_user, $jira_passwd );
isa_ok $client, 'JIRA::Client', 'instantiated JIRA::Client';

my %attrs = (
	project     => 'TESTPROJECT', 
	type        => 'Story',
	summary     => 'TEST Ticket from Unit test',
	assignee    => 'dbaber',
	description => 'Test ticket to illustrate bug in JIRA::Client where the ticket type is not updated.',
);

my $issue = $client->create_issue( \%attrs );

#say STDERR "######DEBUG> issue = " . Dumper( $issue );

isa_ok $issue, 'RemoteIssue', 'instantiated RemoteIssue';
foreach my $attr ( keys %attrs ) {
	is $issue->{$attr}, $attrs{$attr}, "... issue $attr is '$attrs{$attr}'";
}

my %update_attrs = (
	type        => 'Bug',
	summary     => $attrs{summary} . "- UPDATED",
	description => "UDATED - " . $attrs{description},
);

$issue = $client->update_issue( $issue, \%update_attrs );

#say STDERR "######DEBUG> issue = " . Dumper( $issue );

foreach my $attr ( keys %update_attrs ) {
	is $issue->{$attr}, $update_attrs{$attr}, "... issue $attr after update is '$update_attrs{$attr}'";
}

#!/usr/bin/perl -w

use strict;
use HTML::TokeParser;
use Getopt::Long;
#use WWW::Mechanize;
use WWW::Scripter;
my $browser = new WWW::Scripter;
#my $browser = WWW::Mechanize->new();
$browser->use_plugin('Ajax');

my %optctl;
$optctl{'debug'} = 0;     #defaults
$optctl{'showpage'} = 0;
GetOptions(\%optctl,
	'cloud=s',
	'user=s',
	'pass=s',
	'debug'
	);

die "usage: $0 -cloud cloud -u username"
  unless $optctl{'cloud'} and $optctl{'user'};

my $Zadmin = "https://admin.$optctl{'cloud'}/za/"; # - login
my $ZAserverpage = "https://admin.$optctl{'cloud'}/za/srvsummary.do?act=skel"; #this is where the server data lives!

$browser->get($Zadmin); #get the webpage view
if ($optctl{'debug'}) {
	print "Getting: $Zadmin\n";
	my $html = $browser->content();
	print STDERR "$html\n";
}

#Get user password if not provided already
if (!$optctl{'password'}) {
	print "Password for $optctl{'user'}: ";
	$optctl{'password'} = <STDIN>;
	chomp $optctl{'password'};
}

$browser->submit_form(  #Fill out the form
  form_name => 'LoginActionForm', #LoginActionForm
  fields => { 'loginName' => $optctl{'user'}, 'password' => $optctl{'password'} }
);

if ($optctl{'debug'}) {
	my $html = $browser->content();
	print STDERR "$html\n";
	if ($html =~ m/\b(srvsummary.+)\s/) {
		print "match: $1\n";
	}
}


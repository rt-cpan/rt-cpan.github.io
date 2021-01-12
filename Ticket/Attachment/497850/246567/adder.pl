#!/usr/local/bin/perl
use WWW::Myspace;

use WWW::Myspace::FriendAdder;

# see WWW::Myspace docs for more info on user/pass usage
my $myspace = WWW::Myspace->new();

my $adder = WWW::Myspace::FriendAdder->new( $myspace );

# or pass some startup parameters
my %startup_params = (
	exclude_my_friends  => 1,
	max_count           => 10,
	interactive	    => 1,
	last_login	    => 60,
	profile_type	    => 'personal'
           );

my $adder = WWW::Myspace::FriendAdder->new(
	$myspace,
	\%startup_params,
	);

# Magica
my @friend_ids = $myspace->friends_from_profile('163004369');

$adder->send_friend_requests( @friend_ids);


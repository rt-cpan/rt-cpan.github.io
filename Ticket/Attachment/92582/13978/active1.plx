#!/usr/bin/perl -w
use strict;
use POE qw(Component::JobQueue);

use vars qw($count);

POE::Component::JobQueue->spawn(
	Alias => 'active',
	WorkerLimit => 10,
	Worker => \&active_worker,
	Active => {
#		PollInterval => 3
	}
);

sub active_worker {
	my $meta_postback = shift;

	print 'active_worker', $/;

	$count++;
	return if $count > 2;

	POE::Session->create(
		inline_states => {
			_start => sub {
				$_[KERNEL]->yield('loop');
			},
			loop => sub {
				print 'looping... SID: ', $_[SESSION]->ID, $/;
				$_[HEAP]->{count}++;
				$_[KERNEL]->delay('loop', 2) if $_[HEAP]->{count} < 5;
			}
		}
	);

	return;
}

$poe_kernel->run;


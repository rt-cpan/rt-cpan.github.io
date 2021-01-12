use strict;
use warnings;

use Test::More;
use Future;

subtest '->then($code)' => sub {
	my $f = Future->new->set_label('leaf');
	my $then = $f->then(sub { Future->fail("should not be called") })->set_label('leaf->then');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($then->is_ready, '->then is ready');
	ok($then->is_cancelled, '->then is cancelled when dependent is cancelled');
};

subtest '->then($code, $code)' => sub {
	my $f = Future->new->set_label('leaf');
	my $then = $f->then(sub { Future->fail("should not be called") }, sub { Future->fail("also should not be called") })->set_label('leaf->then(CV,CV)');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($then->is_ready, '->then is ready');
	ok($then->is_cancelled, '->then is cancelled when dependent is cancelled');
};

subtest '->then_with_f($code)' => sub {
	my $f = Future->new->set_label('leaf');
	my $then_with_f = $f->then_with_f(sub { Future->fail("should not be called") })->set_label('leaf->then_with_f');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($then_with_f->is_ready, '->then_with_f is ready');
	ok($then_with_f->is_cancelled, '->then_with_f is cancelled when dependent is cancelled');
};

subtest '->then_done($code)' => sub {
	my $f = Future->new->set_label('leaf');
	my $then_done = $f->then_done("should not be called")->set_label('leaf->then_done');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($then_done->is_ready, '->then_done is ready');
	ok($then_done->is_cancelled, '->then_done is cancelled when dependent is cancelled');
};

subtest '->then_fail($code)' => sub {
	my $f = Future->new->set_label('leaf');
	my $then_fail = $f->then_fail("should not be called")->set_label('leaf->then_fail');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($then_fail->is_ready, '->then_fail is ready');
	ok($then_fail->is_cancelled, '->then_fail is cancelled when dependent is cancelled');
};

subtest '->else' => sub {
	my $f = Future->new->set_label('leaf');
	my $else = $f->else(sub { Future->fail("should not be called") })->set_label('leaf->else');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($else->is_ready, '->else is ready');
	ok($else->is_cancelled, '->else is cancelled when dependent is cancelled');
};

subtest '->else_with_f' => sub {
	my $f = Future->new->set_label('leaf');
	my $else_with_f = $f->else_with_f(sub { Future->fail("should not be called") })->set_label('leaf->else_with_f');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($else_with_f->is_ready, '->else_with_f is ready');
	ok($else_with_f->is_cancelled, '->else_with_f is cancelled when dependent is cancelled');
};

subtest '->transform' => sub {
	my $f = Future->new->set_label('leaf');
	my $transform = $f->transform(
		done => sub { Future->fail("should not be called") },
		fail => sub { Future->fail("also should not be called") }
	)->set_label('leaf->transform');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($transform->is_ready, '->transform is ready');
	ok($transform->is_cancelled, '->transform is cancelled when dependent is cancelled');
};

subtest '->without_cancel($code, $code)' => sub {
	my $f = Future->new->set_label('leaf');
	my $without_cancel = $f->without_cancel->set_label('leaf->without_cancel');
	$f->cancel;
	ok($f->is_ready, 'leaf is ready');
	ok($without_cancel->is_ready, '->without_cancel is ready');
	ok($without_cancel->is_cancelled, '->without_cancel is cancelled when dependent is cancelled');
};

subtest '->followed_by($code)' => sub {
	{
		my $f = Future->new->set_label('leaf');
		my $followed_by = $f->followed_by(sub { Future->fail("should not be called") })->set_label('leaf->followed_by');
		$f->cancel;
		ok($f->is_ready, 'leaf is ready');
		ok($followed_by->is_ready, '->followed_by is ready');
		ok($followed_by->failure, '->followed_by executed code which returned Future->fail');
	}
	{
		my $f = Future->new->set_label('leaf');
		my $followed_by = $f->followed_by(sub { Future->done("this is fine") })->set_label('leaf->followed_by');
		$f->cancel;
		ok($f->is_ready, 'leaf is ready');
		ok($followed_by->is_ready, '->followed_by is ready');
		ok($followed_by->is_done, '->followed_by executed code which returned Future->done');
	}
};

done_testing;


#!perl

use strict;
use warnings;
use Test::More;

use forks;
use forks::shared;

my $var1 :shared;

my $thr = threads->new({'context' => 'list'}, sub { fork_eval(); });
$thr->join();

my $thr2 = threads->new({'context' => 'list'}, sub { fork_eval_lock(); });
$thr2->join();

exit;

sub fork_eval {
    ok(1, "This test reached");
    my $error_message = "ERROR_MESSAGE_HERE";
    eval {
        die($error_message);
    };
    like($@, qr/^$error_message/, "Error message received");
    done_testing();
}

sub fork_eval_lock {
    ok(1, "This test reached");
    my $error_message = "ERROR_MESSAGE_HERE";
    eval {
        lock $var1;
        $var1 = 'fork';
        unlock $var1;
        die($error_message);
    };
    like($@, qr/^$error_message/, "Error message received but this test never reached.");
    done_testing();
}
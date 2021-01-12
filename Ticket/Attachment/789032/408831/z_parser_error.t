#!perl

use strict;
no warnings;
use Test::More;
use AnyEvent::XMPP::Connection;

unless($ENV{NET_XMPP2_TEST}) {
    plan skip_all => 'Define NET_XMPP2_TEST to jid:password to test this';
    exit 0;
}
plan tests => 3;
my ( $jid ) = split /:/, $ENV{NET_XMPP2_TEST};

my $conn = AnyEvent::XMPP::Connection->new(
    jid => $jid,
    password => '',
);

my $seen_warn = 0;
my $seen_stream_ready = 0;
my $seen_sasl_error = 0;

$SIG{__WARN__} = sub {
    $seen_warn = 1;
};

my $cond = AnyEvent->condvar;

$conn->reg_cb(
    stream_ready => sub {
        $seen_stream_ready = 1;
        $conn->disconnect;
    },
    sasl_error => sub {
        $seen_sasl_error = 1;
    },
    disconnect => sub {
        $cond->broadcast;
    },
);

$conn->connect;

$cond->wait;

ok(! $seen_stream_ready, 'auth should fail');
ok(! $seen_warn, 'no warnings should be emitted');
ok($seen_sasl_error, 'I should see a SASL error');

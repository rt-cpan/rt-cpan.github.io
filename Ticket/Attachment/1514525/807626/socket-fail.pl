#!/usr/bin/env perl

use strict;
use warnings;

use LWP::UserAgent;
use HTTP::Daemon;
use HTTP::Request;
use HTTP::Response;
use HTTP::Status;

my ($port, $is_client) = @ARGV;
my $host = 'localhost';

if ($is_client) {
    my $UA = LWP::UserAgent->new;
    my $req = HTTP::Request->new(HEAD => "http://$host:$port");
    print ">>> Sending HEAD request\n";
    my $res = $UA->request($req);
    print ">>> Headers from HEAD request:\n\t";
    printf "%d %s\n\t", $res->code, $res->message;
    print $res->headers_as_string("\n\t"), "\n";
    sleep 1;
    printf ">>> Creating POST request to %s\n", $req->uri;
    $req = HTTP::Request->new(POST => "http://$host:$port");
    print ">>> Sending POST request\n";
    $res = $UA->request($req);
    print ">>> Full message from POST request:\n\t";
    print $res->as_string("\n\t"), "\n";
} else {
    my $server = HTTP::Daemon->new(
        ReuseAddr => 1,
        LocalHost => $host,
        LocalPort => $port,
        Listen    => 5
    );

    die "Failed to create server object\n" if (! $server);

    $server->timeout(1);
    while (1) {
        my $conn = $server->accept;
        printf "<<< Accept: %s\n", ($conn || '(none)');
        next if (! $conn);

        my $req;
        while ($conn and $req = $conn->get_request('headers only')) {
            my $res = HTTP::Response->new;
            $res->code(RC_OK);
            $res->message('OK');
            $res->header(Accept => 'text/xml');
            $res->content_type('text/xml');

            if ($req->method eq 'HEAD') {
                print "<<< Sending HEAD response\n";
                $conn->send_response($res);
            } elsif ($req->method eq 'POST') {
                print "<<< Sending POST response\n";
                $res->content('Success');
                $conn->send_response($res);
            }
        }

        my $eval_return = eval {
            local $SIG{PIPE} = sub { die "<<< server_loop: Caught SIGPIPE\n"; };
            $conn->close;
            1;
        };
        if ((! $eval_return) && $@)
        {
            warn "<<< Cannot close connection: $@\n";
        }

        undef $conn;
    }
}

exit;

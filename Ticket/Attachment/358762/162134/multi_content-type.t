#!perl

#------------------------------
# Emanuele Zeppieri - Sep 2007
#------------------------------

use strict;
use warnings;

use lib 'lib';

our $PORT;

BEGIN {
    $PORT = $ENV{TWMC_TEST_PORT} || 7357;
    $ENV{CATALYST_SERVER} = "http://localhost:$PORT"
}

package ExternalCatty;

use Catalyst qw/-Debug -Engine=HTTP/;

our $VERSION = '0.01';

__PACKAGE__->config( name => 'ExternalCatty' );
__PACKAGE__->setup;

sub default : Private {
    my ($self, $c) = @_;
    $c->response->content_type('text/html; charset=utf-8');
    $c->response->output( html('Root', 'Hello, test!') )
}

sub html {
    my ($title, $body) = @_;
    return qq[
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>$title</title>
</head>
<body>$body</body>
</html>
];
}

# The Cat HTTP server background option is useless here :-(
# Thus we have to provide our own background method.
sub background {
    my $self  = shift;
    my $child = fork;
    die "Can't fork Cat HTTP server: $!" unless defined $child;
    return $child if $child;

    if ( $^O !~ /MSWin32/ ) {
        require POSIX;
        POSIX::setsid() or die "Can't start a new session: $!";
    }
    
    $self->run($PORT)
}

# Back in main.
package main;

use Test::More tests => 5;
use Test::Exception;

BEGIN {
    diag(
        "###################################################################\n",
        "Starting an external Catalyst HTTP server on port $PORT\n",
        "To change the port, please set the TWMC_TEST_PORT env variable.\n",
        "(The server will be automatically shut-down right after the tests).\n",
        "###################################################################\n"
    )
}

# Let's catch interrupts to force the END block execution.
$SIG{INT} = sub { warn "INT:$$"; exit };
my $pid = ExternalCatty->background;

use Test::WWW::Mechanize::Catalyst 'ExternalCatty';
my $m = Test::WWW::Mechanize::Catalyst->new;

lives_ok
    { $m->get_ok('/', 'Get a multi Content-Type response') }
    'Survive to a multi Content-Type sting';
is( $m->ct, 'text/html', 'Multi Content-Type Content-Type');
$m->title_is('Root', 'Multi Content-Type title');
$m->content_contains('Hello, test!', 'Multi Content-Type body');

END { kill 9, $pid }

1;

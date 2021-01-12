#!/usr/bin/perl

use strict;
use warnings;
use YAML;
use Test::More;

use FindBin qw( $RealBin );
use lib "$RealBin/../../lib";
use SDE::Log

plan( 'tests' => 21 );

my $dispatcher = SDE::Log->dispatcher();

$dispatcher->add( LogTester->new(
                                'name'      => 'debug',
                                'min_level' => 'debug',
                                'max_level' => 'info',
                                )
                );

$dispatcher->add( LogTester->new(
                                'name'      => 'runtime',
                                'min_level' => 'warning',
                                'max_level' => 'critical',
                                )
                );

isa_ok( $dispatcher, 'Log::Dispatch', 'Expect a Log::Dispatch object' );

ok(   $dispatcher->would_log( 'debug'     ), 'debug     should not be logged'  );
ok(   $dispatcher->would_log( 'info'      ), 'info      should not be logged'  );
ok( ! $dispatcher->would_log( 'notice'    ), 'notice    should not be logged'  );
ok(   $dispatcher->would_log( 'warning'   ), 'warning   should be logged'      );
ok(   $dispatcher->would_log( 'error'     ), 'error     should be logged'      );
ok(   $dispatcher->would_log( 'critical'  ), 'critical  should be logged'      );
ok( ! $dispatcher->would_log( 'alert'     ), 'alert     should not be logged'  );
ok( ! $dispatcher->would_log( 'emergency' ), 'emergency should not be logged'  );

$dispatcher->log( 'level' => 'debug',     'message' => 'debug message'     );
$dispatcher->log( 'level' => 'info',      'message' => 'info message'      );
$dispatcher->log( 'level' => 'notice',    'message' => 'notice message'    );
$dispatcher->log( 'level' => 'warning',   'message' => 'warning message'   );
$dispatcher->log( 'level' => 'error',     'message' => 'error message'     );
$dispatcher->log( 'level' => 'critical',  'message' => 'critical message'  );
$dispatcher->log( 'level' => 'alert',     'message' => 'alert message'     );
$dispatcher->log( 'level' => 'emergency', 'message' => 'emergency message' );

my @debug_messages   = $dispatcher->output( 'debug' )->messages();

is( $#debug_messages, 1, 'two debugging messages' );
is( $debug_messages[0]{'level'},    'debug',            'first debug message should have the level: debug' );
is( $debug_messages[0]{'message'},  'debug message',    'first debug message should have been a debug message' );
is( $debug_messages[1]{'level'},    'info',             'second debug message should have the level: info' );
is( $debug_messages[1]{'message'},  'info message',     'second debug message should have been an info message' );

my @runtime_messages = $dispatcher->output( 'runtime' )->messages();

is( $#runtime_messages, 2, 'three runtime messages' );
is( $runtime_messages[0]{'level'},    'warning',           'first runtime message should have the level: debug' );
is( $runtime_messages[0]{'message'},  'warning message',   'first runtime message should have been a debug message' );
is( $runtime_messages[1]{'level'},    'error',             'second runtime message should have the level: error' );
is( $runtime_messages[1]{'message'},  'error message',     'second runtime message should have been an error message' );
is( $runtime_messages[2]{'level'},    'critical',          'third runtime message should have the level: critical' );
is( $runtime_messages[2]{'message'},  'critical message',  'third runtime message should have been a critical message' );

exit( 0 );

package LogTester;

use YAML;
use Log::Dispatch::Output;
use base qw( Log::Dispatch::Output );

sub new
    {
        my $class = shift;
        my $self  = bless {}, $class;
        $self->_basic_init( @_ );
        $self->{'messages'} = [];
        return $self;
    }

sub log
{
    my $self    = shift;
    my $message = { @_ };

    push( @{$self->{'messages'}}, $message );
}

sub messages
{
    my $self = shift;
    return @{$self->{'messages'}};
}

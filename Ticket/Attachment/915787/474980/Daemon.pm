package Exp::Daemon;

use warnings;
use strict;
use Moose;

with 'MooseX::Daemonize';
with 'MooseX::Log::Log4perl';


after start => sub {
        my ($self) = @_;
        return unless $self->is_daemon;
        $self->log->error("Log 1");
        $self->log->error("Log 2");
        $self->log->error("Log 3");
        while (not -e '/tmp/stopit') {
                sleep 5;
        }
};

sub run
{
        my ($self) = @_;
        my ($command) = @{$self->extra_argv};
        defined $command || die "No command specified";

        $self->status  if $command eq 'status';
        $self->restart if $command eq 'restart';
        $self->stop    if $command eq 'stop';
#        $self->start    if $command eq 'start';
        if ($command eq 'start') {
                use Log::Log4perl;
                my $string = '
log4perl.rootLogger = ALL, file
log4perl.appender.file = Log::Log4perl::Appender::File
log4Perl.appender.file.filename = /tmp/exp_daemon_logfile
log4perl.appender.file.layout = PatternLayout
log4perl.appender.file.layout.ConversionPattern = %d %p %c - %m in %F{2} (%L)%n
';
                Log::Log4perl->init(\$string);
                $self->log->info("Started daemon");
                $self->start;
        }
}

1; # End of Exp::Daemon

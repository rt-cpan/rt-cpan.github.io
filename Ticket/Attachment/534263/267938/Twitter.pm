#!/usr/bin/env perl
package Log::Dispatch::Twitter;
use strict;
use warnings;
use base 'Log::Dispatch::Output';

sub new {
    my $class = shift;
    my $self = bless {}, $class;

    $self->_basic_init(@_);
    $self->_init(@_);

    return $self;
}

sub _init {
    my $self = shift;
    my %args = @_;

    $self->{username} = $args{username};
    $self->{password} = $args{password};
}

sub log_message {
    my $self = shift;
    my %args = @_;

    my $message = $args{message};

    # we could truncate here, but better to let Net::Twitter, or even Twitter
    # itself, do it. we don't want to have to release a new version to support
    # 145 character log messages. :)

    $self->_post_message($message);
}

sub _post_message {
    my $self    = shift;
    my $message = shift;

    my $twitter = Net::Twitter->new(
        username  => $self->{username},
        password  => $self->{password},
    );

    $twitter->update($message);
}

1;

__END__

=head1 NAME

Log::Dispatch::Twitter - Log messages via Twitter

=head1 SYNOPSIS

    use Log::Dispatch;
    use Log::Dispatch::Twitter;

    my $logger = Log::Dispatch->new;

    $logger->add(Log::Dispatch::Twitter->new(
        username  => "foo",
        password  => "bar",
        min_level => "debug",
        name      => "twitter",
    ));

    $logger->log(
        level   => 'error',
        message => 'We applied the cortical electrodes but were unable to get a neural reaction from either patient.',
    );

=head1 DESCRIPTION

Twitter is a presence tracking site. Why not track your program's presence?

=cut


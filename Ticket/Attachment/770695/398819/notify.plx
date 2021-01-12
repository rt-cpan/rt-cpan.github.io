#!perl

use strict;
use warnings;

use EV                        ();
use AnyEvent                  ();
use AnyEvent::Filesys::Notify ();
use Cwd                       ();
use Devel::Cycle              ();

my $notify = AnyEvent::Filesys::Notify->new(
                 dirs   => [ Cwd::getcwd() ],
                 filter => sub { 1 },
                 cb     => sub { },
             );

Devel::Cycle::find_cycle($notify);

undef $notify;

EV::loop;

__END__

Cycle (1):

	$Class::MOP::Class::__ANON__::SERIAL::1::A->{'_fs_monitor'} => \%Linux::Inotify2::B
	    $Linux::Inotify2::B->{'w'} => \%C
	                     $C->{'1'} => \%Linux::Inotify2::Watch::D
	$Linux::Inotify2::Watch::D->{'cb'} => \&E
	             $E variable $self => \$F
	                           $$F => \%Class::MOP::Class::__ANON__::SERIAL::1::A


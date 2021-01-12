#!/usr/bin/perl

use Gtk3 '-init';

#use Gtk2 '-init';

sub call_perl
{
        my($a, $b) = @_ ;

        my $hello = Gtk3::MessageDialog->new (undef, 'modal', 'info', 'ok', "Hello world!");
        $hello->set ('secondary-text' => 'This is an example dialog.');
        $hello->run;
        $hello->destroy;

#        my $hello = Gtk2::MessageDialog->new (undef, 'modal', 'info', 'ok', "Hello world!");
#        $hello->set ('secondary-text' => 'This is an example dialog.');
#        $hello->run;
#        $hello->destroy;

        return $a*$b;
}

call_perl();


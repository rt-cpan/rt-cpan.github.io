#!perl

use warnings;
use strict;

use Tk;
use POE;

use POE::Wheel::FollowTail;

my $logdateien = [
	'/var/log/system.log',
	'/var/log/kernel.log',
	'/var/log/windowserver.log',
];


POE::Session->create(
	inline_states => {
		_start    => \&ui_start,
		ev_count  => \&ui_count,
		ev_clear  => \&ui_clear,
		got_line  => \&updateLog_line,
		got_error => \&updateLog_error,
	},
	args => \@{$logdateien},
);

POE::Kernel->run();
exit 0;

sub ui_start {
	my ($kernel, $session, $heap) = @_[KERNEL, SESSION, HEAP];
	die "could not create a main Tk window" unless defined $poe_main_window;
	$poe_main_window->configure(-width => 1280, -height => 480,);
	$poe_main_window->packPropagate(0);
	$poe_main_window->update();

	my $menuitems = [
		[
			Cascade    => "~Datei",
			-menuitems => [
				[Button    => "~Neu",     -command => \&new],
				[Separator => ""],
				[Button    => "~Öffnen", -command => \&open],
				[Button    => "~Sichern", -command => \&save],
			],
		],
	];

	my $menu = $poe_main_window->Menu(-menuitems => $menuitems);
	$poe_main_window->configure(-menu => $menu);

	require Tk::NoteBook;
	$heap->{notebook} = $poe_main_window->NoteBook();
	foreach my $logdatei (@{$logdateien}) {
		$heap->{notebookSeiten}{$logdatei}{seite} =
			$heap->{notebook}->add($logdatei, -label => $logdatei,);
		$heap->{notebookSeiten}{$logdatei}{scr_txt} =
			$heap->{notebookSeiten}{$logdatei}{seite}->Scrolled(

			Text => -scrollbars => 'se',
			)->pack(-expand => 1, -fill => 'both',);

		$heap->{notebookSeiten}{$logdatei}{btn_frame} =
			$heap->{notebookSeiten}{$logdatei}{seite}->Frame();
		$heap->{notebookSeiten}{$logdatei}{clear_btn} =
			$heap->{notebookSeiten}{$logdatei}{btn_frame}->Button(
			-text    => 'Anzeige leeren',
			-command => sub {
				$heap->{notebookSeiten}{$logdatei}{scr_txt}->Subwidget('scrolled')
					->delete(" 0.0", "end");

			},
			)->pack(-side => 'left',);
		$heap->{notebookSeiten}{$logdatei}{btn_frame}->pack(-side => 'left',);
	}
	$heap->{notebook}->pack(-expand => 1, -fill => 'both',);

	foreach (@{$logdateien}) {
		$heap->{wheel}->{$_} = POE::Wheel::FollowTail->new(
			Filename   => $_,
			InputEvent => 'got_line',
			ErrorEvent => 'got_error',
			SeekBack   => 1024,
		);
	}
	$heap->{first} = 0;

	$kernel->yield("ev_count");
}


sub ui_count { $_[HEAP]->{counter}++; $_[KERNEL]->yield("ev_count"); }

sub ui_clear { $_[HEAP]->{counter} = 0; }

sub updateLog_line {
	my ($kernel, $session, $heap) = @_[KERNEL, SESSION, HEAP];
	my $eingabe = $_[ARG0];
	my @eingaben = split m/\\r, /, $eingabe;
	foreach my $eing (@eingaben) {
		$heap->{notebookSeiten}{$logdateien->[($_[ARG1] - 1)]}{scr_txt}
			->insert("end", "normal: $eing\n")
			if $heap->{first}++;
	}
}

sub updateLog_error { warn "$_[ARG0]\n"; }



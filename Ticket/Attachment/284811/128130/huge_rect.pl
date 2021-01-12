#! /usr/bin/perl -w

use strict;
use Gtk2 -init;
use Gnome2::Canvas;

my $win = Gtk2::Window->new;
my $canvas = Gnome2::Canvas->new;
$canvas->set_center_scroll_region (0);
Gnome2::Canvas::Item->new ($canvas->root,
					'Gnome2::Canvas::Rect',
					x1 => 90.0,
					y1 => 40.0,
					x2 => 33000.0, # that triggers a bug, rectangle is broken!
					y2 => 100.0,
					fill_color => "mediumseagreen",
					outline_color => "black",
					width_units => 4.0);
#$canvas->set_size_request (600, 450);
$canvas->set_scroll_region (0, 0, 600000, 6000);
$win->add ($canvas);
$canvas->show;
$win->show_all;
Gtk2->main;

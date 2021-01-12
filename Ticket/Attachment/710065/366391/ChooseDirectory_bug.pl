#!/usr/bin/perl
use strict;
use Tk;

my $target_dir = 'C:/My Documents/';

my $mw = MainWindow->new;
$mw->title("cooseDirectory bug");

my $directory_frame =
  $mw->Frame()->pack(-side => 'bottom', -expand => 1, -fill => 'x');

# This is the target directory display area
my $dir_name_display = $directory_frame->Label(
  -textvariable => \$target_dir,
  -width        => 50,
  -borderwidth  => 2,
  -background   => 'white',
  -foreground   => 'black',
  -relief       => 'sunken',
  -anchor       => 'w'
)->pack(-side => 'left', -padx => 5);

# and here is the button that will let the user to pick a directory

my $pick_target_dir = $directory_frame->Button(
  -text    => 'Pick',
  -width   => 10,
  -command => \&do_pick_dir
)->pack(-side => 'right', -padx => 10);

MainLoop;


sub do_pick_dir
{
  $target_dir = $pick_target_dir->chooseDirectory(
   -initialdir => $target_dir,
   -title => 'chooseDirectory bug');
}
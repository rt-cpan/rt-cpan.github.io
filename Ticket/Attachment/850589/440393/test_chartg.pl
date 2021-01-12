#!/usr/bin/perl -w
use strict;
use GD::Graph::lines;

my $data1 = '50,30,40,150,60,70,80,120,180,90,20,210';
my $data2 = '400,545,450,600,750,400,1200,800,1000,500,900,1100';
my @x_axis_data = qw(00:00 01:00 02:00 03:00
                     04:00 05:00 06:00 07:00
                     08:00 09:00 10:00 11:00
                     12:00 13:00 14:00 15:00
                     16:00 17:00 18:00 19:00
                     20:00 21:00 22:00 23:00
                     23:59 );
my @y1_axis_data = split(/,/, $data1);
my @y2_axis_data = split(/,/, $data2);
my @data = ( \@x_axis_data, \@y1_axis_data, \@y2_axis_data );
   
my $graph = GD::Graph::lines->new(240, 175);
$graph->set(
      title => 'Test 2 Axes',
      transparent => 0,
      dclrs => [ qw(red blue) ],
      # bgclr => 'white',
      line_width => 2,
      two_axes => 1,
      x_label_skip => 4,
      y1_min_value => 0,
      y1_max_value => 250,
      y2_min_value => 400,
      y2_max_value => 1200,
      tick_length => -4
 ) or die $graph->error;
$graph->set_legend(split(/,/, 'Line1,Line2'));

my $gd = $graph->plot(\@data) or die $graph->error;

open(IMAGE,">test_chart2.png") or die "Cannot open output file\n";
binmode(IMAGE);
print IMAGE $gd->png;
close(IMAGE);

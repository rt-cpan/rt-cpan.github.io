#!/usr/bin/perl -w
use strict;
    use warnings;
    use List::Util qw(min max);
    use GD::Graph::candlesticks;
    my @msft;  

    @msft = (     #  open       high       low        close
        ["2007/12/18", "34.6400", "35.0000", "34.2100", "34.7400"],
        ["2007/12/19", "34.6900", "35.1400", "34.3800", "34.7900"],
        ["2007/12/20", "35.2900", "35.7900", "35.0800", "35.5200"],
        ["2007/12/21", "35.9000", "36.0600", "35.7500", "36.0600"],
        ["2007/12/24", "36.1300", "36.7200", "36.0500", "36.5800"],
);
    my @all_points = map {@$_[1 .. 4]} @msft;
    my $min_point  = min(@all_points);
    my $max_point  = max(@all_points);

    my $graph = GD::Graph::candlesticks->new(800, 400);
       $graph->set( 
            x_labels_vertical => 1,
            x_label           => 'Trade Date',
            y_label           => 'NASDAQ:MSFT',
            title             => "Example OHLC",
            transparent       => 0,
            candlestick_width => 7,
            dclrs             => [qw(blue)],
            y_min_value       => $min_point-0.2,
            y_max_value       => $max_point+0.2,
            y_number_format   => '%0.2f',

        ) or warn $graph->error;

    my $data_candlesticks = [
        [ map {$_->[0]} @msft ],       # date
        [ map {[@$_[1 .. 4]]} @msft ], # candlesticks
    ];

    my $gd = $graph->plot($data_candlesticks) or die $graph->error;
    open my $dump, ">candlesticks_example.png" or die $!;
    print $dump $gd->png;
    close $dump;


my $data = [
          [ '64.461449', '64.508786', '64.51149', '64.569944', '64.578382',
            '64.578913', '64.584895', '64.584985', '64.600026', '64.600194',
            '64.601665', '64.601819', '64.602641', '64.603273', '64.603603',
            '64.607842', '64.608743', '64.610841', '64.616036', '64.616613',
            '64.619833', '64.620098', '64.620855', '64.624728', '64.638441',
            '64.656637', '64.677041', '64.686937', '64.687098', '64.693452',
            '64.709906', '64.709993', '64.719505', '64.722992', '64.727427',
            '64.727582', '64.735608', '64.739782', '64.740569', '64.749582',
            '64.763465', '64.800002', '64.80745', '64.812322', '64.826185',
            '64.834202', '64.870214', '64.874562', '64.88797', '64.88806',
            '64.932722'
          ],
          [
            '1.515211', '0.784142', '1.261263', '1.224015', '0.812913',
            '1.60206', '1.582631', '1.610128', '1.665112', '1.171239',
            '0.383217', '0.592917', '0.30103', '0.884607', '0.933656',
            '1.302836', '0.0', '1.81012', '2.924359', '2.912772',
            '2.380211', '2.407816', '2.456228', '2.239716', '2.973601',
            '2.711998', '3.718967', '3.910095', '3.876149', '2.865534',
            '2.592197', '2.453874', '1.003604', '1.031408', '1.555296',
            '1.910713', '1.574995', '1.66197', '1.919514', '1.609239',
            '2.320146', '1.899912', '2.146903', '2.494692', '1.502882',
            '0.0', '0.0', '0.0', '0.544068', '0.574031', '0.500602'
          ]
        ];

use GD::Graph::linespoints;
#my $graph = GD::Graph::linespoints->new(200, 100);
my $graph = JJlinespoints->new(200, 100); # this line gives fix, previous line shows bug
$graph->set(
               x_tick_number=>'auto',
               dclrs=>[qw(blue)],
               y_number_format => "%0.1f",
               marker_size => 2,
               zero_axis => 1,
           );
my $gd = $graph->plot($data) or die $graph->error;
my $png = $gd->png or die $!;
print $png;

package JJlinespoints;  
use base qw(GD::Graph::linespoints);
#
# Figure out the maximum values for the vertical exes, and calculate
# a more or less sensible number for the tops.
#
sub set_max_min
{
    my $self = shift;

    # XXX fix to calculate min and max for each data set
    # independently, and store in an array. Then, based on use_axis,
    # pick the minimust and maximust for each axis, and use those.

    # First, calculate some decent values
    if ( $self->{two_axes} ) 
    {
        my $min_range_1 = defined($self->{min_range_1})
                ? $self->{min_range_1}
                : $self->{min_range};
        my $min_range_2 = defined($self->{min_range_2})
                ? $self->{min_range_2}
                : $self->{min_range};
	my(@y_min, @y_max);
	for my $nd (1 .. $self->{_data}->num_sets)
	{
	    my $axis = $self->{use_axis}->[$nd - 1];
	    my($y_min, $y_max) = $self->{_data}->get_min_max_y($nd);
	    if (!defined $y_min[$axis] || $y_min[$axis] > $y_min)
	    {
		$y_min[$axis] = $y_min;
	    }
	    if (!defined $y_max[$axis] || $y_max[$axis] < $y_max)
	    {
		$y_max[$axis] = $y_max;
	    }
	}

        (
	    $self->{y_min}[1], $self->{y_max}[1],
	    $self->{y_min}[2], $self->{y_max}[2],
	    $self->{y_tick_number}
        ) = _best_dual_ends(
                $self->_correct_y_min_max($y_min[1], $y_max[1]),
		    $min_range_1,
                $self->_correct_y_min_max($y_min[2], $y_max[2]),
		    $min_range_2,
                $self->{y_tick_number}
        );
    } 
    else 
    {
        my ($y_min, $y_max);
        if ($self->{cumulate})
        {
            my $data_set = $self->{_data}->copy();
            $data_set->cumulate;
            ($y_min, $y_max) = $data_set->get_min_max_y($data_set->num_sets);
        }
        else
        {
            ($y_min, $y_max) = $self->{_data}->get_min_max_y_all;
        }
	($y_min, $y_max) = $self->_correct_y_min_max($y_min, $y_max);
        ($self->{y_min}[1], $self->{y_max}[1], $self->{y_tick_number}) =
            GD::Graph::axestype::_best_ends($y_min, $y_max, @$self{'y_tick_number','y_min_range'});
    }

    if (defined($self->{x_tick_number}))
    {
        if (defined($self->{x_min_value}) && defined($self->{x_max_value}))
        {
            $self->{true_x_min} = $self->{x_min_value};
            $self->{true_x_max} = $self->{x_max_value};
        }
        else
        {
            ($self->{true_x_min}, $self->{true_x_max}) = 
                $self->{_data}->get_min_max_x;
            ($self->{x_min}, $self->{x_max}, $self->{x_tick_number}) =
                GD::Graph::axestype::_best_ends($self->{true_x_min}, $self->{true_x_max},
                        @$self{'x_tick_number','x_min_range'});
        }
    }

    # Overwrite these with any user supplied ones
    $self->{y_min}[1] = $self->{y_min_value}  if defined $self->{y_min_value};
    $self->{y_min}[2] = $self->{y_min_value}  if defined $self->{y_min_value};

    $self->{y_max}[1] = $self->{y_max_value}  if defined $self->{y_max_value};
    $self->{y_max}[2] = $self->{y_max_value}  if defined $self->{y_max_value};

    $self->{y_min}[1] = $self->{y1_min_value} if defined $self->{y1_min_value};
    $self->{y_max}[1] = $self->{y1_max_value} if defined $self->{y1_max_value};

    $self->{y_min}[2] = $self->{y2_min_value} if defined $self->{y2_min_value};
    $self->{y_max}[2] = $self->{y2_max_value} if defined $self->{y2_max_value};

    $self->{x_min}    = $self->{x_min_value}  if defined $self->{x_min_value};
    $self->{x_max}    = $self->{x_max_value}  if defined $self->{x_max_value};

    if ($self->{two_axes})
    {
        # If we have two axes, we need to make sure that the zero is at
        # the same spot.
        # And we need to change the number of ticks on the axes

        my $l_range = $self->{y_max}[1] - $self->{y_min}[1];
        my $r_range = $self->{y_max}[2] - $self->{y_min}[2];

        my $l_top = $self->{y_max}[1]/$l_range;
        my $r_top = $self->{y_max}[2]/$r_range;
        my $l_bot = $self->{y_min}[1]/$l_range;
        my $r_bot = $self->{y_min}[2]/$r_range;

        if ($l_top > $r_top)
        {
            $self->{y_max}[2] = $l_top * $r_range;
            $self->{y_min}[1] = $r_bot * $l_range;
            $self->{y_tick_number} *= 1 + abs $r_bot - $l_bot;
        }
        else
        {
            $self->{y_max}[1] = $r_top * $l_range;
            $self->{y_min}[2] = $l_bot * $r_range;
            $self->{y_tick_number} *= 1 + abs $r_top - $l_top;
        }
    }

    # Check to see if we have sensible values
    if ($self->{two_axes}) 
    {
        for my $i (1 .. $self->{_data}->num_sets)
        {
            my ($min, $max) = $self->{_data}->get_min_max_y($i);
            return $self->_set_error("Minimum for y" . $i . " too large")
                if $self->{y_min}[$self->{use_axis}[$i-1]] > $min;
            return $self->_set_error("Maximum for y" . $i . " too small")
                if $self->{y_max}[$self->{use_axis}[$i-1]] < $max;
        }
    } 
    return $self;
}


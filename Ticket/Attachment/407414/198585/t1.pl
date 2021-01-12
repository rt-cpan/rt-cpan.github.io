    use DateTime;
    use Date::Tie;
    use Test::More 'no_plan';

    for my $year ( 1980 .. 2030 ) {
    for my $month ( 1,12 ) {
    for my $day ( 1..31 ) {
        
    $dt = DateTime->new( 
                    year   => $year,
                    month  => $month,
                    day    => $day,
                );
    my ($week_year, $week_number) = $dt->week;
    #print $dt, "\n";
    #print "$week_number\n";

    tie my %date, 'Date::Tie', year => $year, month => $month, day => $day;
    #print $date{week},"\n";
    ok( $date{week} == $week_number, "at $year-$month-$day $date{week} == $week_number" );
    ok( $date{weekyear} == $week_year, "at $year-$month-$day $date{weekyear} == $week_year" );
    
    }
    }
    }

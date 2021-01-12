#!/usr/bin/perl

use strict 'refs';
use strict 'vars';
use strict 'subs';


use Text::Column qw(format_array_table);
use Data::Dumper; 


my  @header = ("Id", 'Column2', 'Column3');
my  @format  = ( 3     ,  15,        10);

my @values = ();

# row 1 normal row
push @values, [1, "Short Text", "c3" ];

# row 2 text does not fit into column2
push @values, [2, "This description is longer than the width of the column. Text will not be trunkated", "c3" ];

# row 3 some values undefined
push @values, [3, "Test with undefined column 3", undef ];

printf("%s\n", format_array_table(\@values, \@format, \@header));





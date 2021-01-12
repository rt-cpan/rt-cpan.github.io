#!/usr/local/bin/perl -w
#
# build a .csv file with each cell containing the row/column label.
#

my $toprow=10;
my $topcol=1000;

for ($row=0;$row<$toprow;$row++)
{
    my $new_row=$row+1;
    for ($col=0;$col<$topcol;$col++)
    {
        my $newcol=$col+1;
        my $col_str = '';

        while ( $newcol ) {
            # Set remainder from 1 .. 26
            my $remainder = $newcol % 26 || 26;
            # Convert the $remainder to a character. C-ishly.
            my $col_letter = chr( ord( 'A' ) + $remainder - 1 );
            # Accumulate the column letters, right to left.
            $col_str = $col_letter . $col_str;
            # Get the next order of magnitude.
            $newcol = int( ( $newcol - 1 ) / 26 );
        }
        print "${col_str}$new_row,";
    }
    print "\n";
}

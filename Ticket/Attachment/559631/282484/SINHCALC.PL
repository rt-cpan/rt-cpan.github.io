#!/usr/local/bin/perl
#------------------------------------------------------------------------------
# PERL SCRIPT     : sinhcalc.pl
# VERSION         : 1.00.0
# AUTHOR          : Ron Grunwald
# EMAIL           : rongrw@yahoo.com.au
# DATE WRITTEN    : Jan 14, 2009
#------------------------------------------------------------------------------
MainFunction: {
   
   use strict;
   use warnings;
   use constant { MAIN_NAME       => q{sinhcalc.pl},
                  BOOL_T          => 1,
                  BOOL_F          => 0,
                  ERR_FLAG        => -1
                };
   use feature  ":5.10";
   use Inline BC => 'DATA',
              PRINT_INFO => 1;

   my ($n, $r);
   for ($n = 1; $n < 6.0; $n += 0.5) {
      $r = bc_sinh( $n );
      say (" N = $n SINH = $r");
   }
}

__DATA__
__BC__

/* Define the BC function sinh(u) */
  define bc_sinh (u) {
    scale = 12
    t = (e(u) - e(-u)) * 0.5
    return ( t )
  }

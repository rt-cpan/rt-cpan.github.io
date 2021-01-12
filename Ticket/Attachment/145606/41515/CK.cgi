#! /usr/bin/perl -w

# this is an example script of how you would use coderefs to define
# your CGI::Ajax functions.
#
# NB The CGI::Ajax object must come AFTER the coderefs are declared.

use strict;
use CGI::Ajax;
use CGI;

my $q = new CGI;




my $K2C = sub {
  my $K = shift;
  $K = "" if not defined $K; # make sure there's def
  my $C = $K - 273.15;
  return $C;
};
my $C2K = sub {
  my $C = shift;
  $C = "" if not defined $C; # make sure there's def
  my $K = $C + 273.15;

  return $K;
  
};

my $pjx = CGI::Ajax->new( 'K2C' => $K2C, 'C2K' =>$C2K);

my $Show_Form = sub {
  my $html = "";
  $html .= <<EOT;
<HTML>
  <HEAD><title>Thermal properties of Copper: Cu</title>
</HEAD>
<BODY>
  Temperature =

  <input type="text" name="Centi" id="Centi" size="10"
    onkeyup="C2K( ['Centi'], ['Kelvin']);return true;" value="0"> [C]
&nbsp;&nbsp;&nbsp;

  <input type="text" name="Kelvin" id="Kelvin" size="10"
    onkeyup="K2C( ['Kelvin'], ['Centi']); return true;" value="273.15"> [K] <br>
</BODY>
</HTML>
EOT

  return $html;
};

#$pjx->DEBUG(1);   # turn on debugging
#$pjx->JSDEBUG(1);

print $pjx->build_html($q,$Show_Form); # this outputs the html for the page

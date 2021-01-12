#!/usr/bin/perl
#####################################################################
# START OF CODE
#####################################################################

print "Content-type: text/html\n\n";

##########################################
use Business::FedEx::DirectConnect;
#########################################

print "<p>START<p>";

#########################################
$t = Business::FedEx::DirectConnect->new
#########################################
(
 uri=>'https://gateway.fedex.com:443/GatewayDC'
 ,acc => 'XXXXX7695' #FedEx Account Number
 ,meter => 'XXX4823' #FedEx Meter Number (This is given after you subscribe to FedEx)
 ,referer => 'Integrated Midi Systems Inc.' # Name or Company
 ,Debug => 1
);



#########################################
$t->set_data
#########################################
(
 2017
 ,8   => "NY"
  ,9   => "11733"
 ,10  => "210887695"
  ,16  => "NY"
  ,17  => "11542"
 ,23  => "1"
  ,50  => "US"
 ,68  => "USD"
 ,75  => "LBS"
 ,116  => "1"
  ,117  => "US"
 ,440 => "Y"
 ,498  => "7404823"
 ,1266  => "Y"
 ,1273 => "01"
 ,1274 => "03"
 ,1401 => "4.0"
 ,1415 => "349.00"
	,2399 	=> '4'	# IF THIS LINE IS INCLUDED THIS PROGRAM FAILES WITH ERRORS OR DIAGNOSTICS AVAILABE, IF I REMOVE THIS ONE LINE IT RUNS FINE
 ,3025 => "FDXE"
) or $MyError = $t->errstr();


#########################################
$t->transaction() or $MyError = $t->errstr();
#########################################


if ($MyError)
{
 print "<p>error = " . $MyError;
}

print '<p>FREIGHT1= ' . $t->lookup('1419');

print '<p>FINISH';

#####################################################################
# END OF CODE
#####################################################################




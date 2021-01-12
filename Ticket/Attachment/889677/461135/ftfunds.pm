#!/usr/bin/perl -w

#  ftfunds.pm
#
#  Obtains quotes for UK Unit Trusts from http://funds.ft.com/ - please 
#  refer to the end of this file for further information.
#
#  author: Martin Sadler (martinsadler@users.sourceforge.net)
#  
#  Version 0.1 Initial version - 06 Sep 2010
#
#  Version 0.2 Better look-up  - 19 Sep 2010
#
#  Version 0.3 name changed to "ftfunds" (all lower case) and tidy-up - 31 Jan 2011
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#    02111-1307, USA
#


package Finance::Quote::ftfunds;
require 5.005;

use strict;
use warnings;

# URLs
use vars qw($VERSION $FTFUNDS_LOOK_UP $FTFUNDS_MAIN_URL);

use LWP::UserAgent;
use HTTP::Request::Common;

$VERSION = '1.17';

$FTFUNDS_MAIN_URL   =   "http://funds.ft.com";
$FTFUNDS_LOOK_UP    =   "http://funds.ft.com/ListedFundFactsheet.aspx?mid=";

                        # this will work with MEXID codes only ("mid" = "MEXID").

# FIXME - Add code to use ISIN or SEDOL in addition to MEXID - javascript cookies??!!

sub methods { return (ftfunds => \&ftfunds_fund, 
		      			ukfunds => \&ftfunds_fund); }

{
    my @labels = qw/name currency last date time price nav source iso_date method net p_change success errormsg/;
                    
    sub labels { return (ftfunds => \@labels,
			 				ukfunds => \@labels); }
}

#
# =======================================================================

sub ftfunds_fund  {
    my $quoter = shift;
    my @symbols = @_;

    return unless @symbols;

    my %fundquote;

    my $ua = $quoter->user_agent;

    foreach (@symbols) 
    {
	    my $code = $_;
	    
	    my $code_type = "** Invalid **";
	    if ($code =~ m/^[a-zA-Z]{2}[a-zA-Z0-9]{9}\d(.*)/ && !$1) { $code_type = "ISIN";  }
	    elsif ($code =~ m/^[a-zA-Z0-9]{6}\d(.*)/ && !$1 )        { $code_type = "SEDOL"; }
	    elsif ($code =~ m/^[a-zA-Z]{4,6}(.*)/ && !$1)            { $code_type = "MEXID"; }

# current version can only use MEXID - report an error and exit if any other type

        if ($code_type ne "MEXID")
        {
		    $fundquote {$code,"success"} = 0;	
		    $fundquote {$code,"errormsg"} = "Error - invalid symbol";
		    next; 
        }
                    
	    $fundquote {$code,"success"} = 1; # ever the optimist....
	    $fundquote {$code,"errormsg"} = "Success";

# perform the look-up - if not found, return with error

        my $webdoc  = $ua->get($FTFUNDS_LOOK_UP.$code);
        if (!$webdoc->is_success)
        {
	        # serious error, report it and give up
		    $fundquote {$code,"success"} = 0;	
		    $fundquote {$code,"errormsg"} = 
		        "Error - failed to retrieve fund data : HTTP status = ".$webdoc->status_line;
		    next; 
	    }
	    $fundquote {$code, "symbol"} = $code;
	    $fundquote {$code, "source"} = $FTFUNDS_MAIN_URL;
  
# Find name by simple regexp

        my $name;
		if ($webdoc->content =~ 
        m[<span id="ctl00_ContentWell_lblFundName" class="FundNameHeader">(.*)</span>] ) 
        { 
            $name = $1 ; 
        }
		if (!defined($name)) {
			# not a serious error - don't report it ....
#			$fundquote {$code,"success"} = 0;	
			# ... but set a useful message ....
			$fundquote {$code,"errormsg"} = "Warning - failed to find fund name";
			$name = "*** UNKNOWN ***";
			# ... and continue
		}		
		$fundquote {$code, "name"} = $name;	# set name

# Find currency

		my $currency;
		if ($webdoc->content =~ 
		m[<span id="ctl00_ContentWell_ListPriceInformation_lbllatestPriceCurrency" class="greyText">(...)</span>]  ) 
        {
            $currency = $1; 
        }
		if (!defined($currency)) {
	    	# serious error, report it and give up
			$fundquote {$code,"success"} = 0;	
			$fundquote {$code,"errormsg"} = "Error - failed to find a currency";
			next;
		}

		# defer setting currency until we've retrieved price and net...

# Find latest price

		my $price;
		if ($webdoc->content =~ 
		m[<span id="ctl00_ContentWell_ListPriceInformation_lblLatestPrice">(.*)</span>] ) 
        {
            $price = $1 ; 
        }
		if (!defined($price)) {
	    	# serious error, report it and give up
			$fundquote {$code,"success"} = 0;	
			$fundquote {$code,"errormsg"} = "Error - failed to find a price";
			next;
		}		

		# defer setting price until we've retrieved net...

# Find net change

		my $net;
		if ($webdoc->content =~ 
		m[<span id="ctl00_ContentWell_ListPriceInformation_lblLastTradeChange" class="(|posi|nega|)tiveDecimal">(.*)</span>] ) 
        {
            $net = $2 ;     # allow for alternates in match string
        } 
		if (!defined($net)) {
			# not a serious error - don't report it ....
#			$fundquote {$code,"success"} = 0;	
			# ... but set a useful message ....
			$fundquote {$code,"errormsg"} = "Warning - failed to find a net change.";
			$net = "-0.00";					# ???? is this OK ????
			# ... and continue
		}		

		# defer setting net until we've checked for GBX currency

# deal with GBX pricing of UK unit trusts
		
		if ($currency eq "GBX") 
		{ 
			$currency = "GBP" ; 
			$price = $price / 100 ;
            $net   = $net   / 100 ;
		}	
		
		# now set prices, net change and currency
		
		$fundquote {$code, "price"} = $price;
		$fundquote {$code, "last"} = $price;
		$fundquote {$code, "nav"} = $price;
        $fundquote {$code, "net"} = $net;
		$fundquote {$code, "currency"} = $currency;

# Find %-change

		my $pchange;
		if ($webdoc->content =~ 
		m[<span id="ctl00_ContentWell_ListPriceInformation_lblLastTradePercentageChange" class="(|posi|nega|)tiveDecimal">(.*)%</span>] ) 
        {
            $pchange = $2 ;     # allow for alternates in match string
        } 
		if (!defined($pchange)) {
			# not a serious error - don't report it ....
#			$fundquote {$code,"success"} = 0;	
			# ... but set a useful message ....
			$fundquote {$code,"errormsg"} = "Warning - failed to find a %-change";
			$pchange = "-0.00";					# ???? is this OK ????
			# ... and continue
		}		

		$fundquote {$code, "p_change"} = $pchange;	# set %-change

# Find time

		my $time;
		if ($webdoc->content =~ m[<span id="ctl00_ContentWell_TabContainer1_tabSummary_lblSummaryTabFundManagementPricingTimeValue">(.*)</span>] ) 
        {
            if ($1 =~ m[(\d\d:\d\d)] )  # strip any trailing text (Timezone, etc.)
            { 
                $time = $1; 
            }
        }
		if (!defined($time)) {
			# not a serious error - don't report it ....
#			$fundquote {$code,"success"} = 0;	
			# ... but set a useful message ....
			$fundquote {$code,"errormsg"} = "Warning - failed to find a time";
			$time = "12:00";    # set to Midday if no time supplied ???
                                # gnucash insists on having a valid-format
			# ... and continue
		}
		
		$fundquote {$code, "time"} = $time; # set time

# Find date

		my $date;
        my $date_string='';
		if ($webdoc->content =~ 
		m[<span id="ctl00_ContentWell_ListPriceInformation_lblLatestPriceDate">(.*)</span>] ) 
        {
        	$date = $1 ;
        }
		if (!defined($date)) {
			# not a serious error - don't report it ....
#			$fundquote {$code,"success"} = 0;	
			# ... but set a useful message ....
			$fundquote {$code,"errormsg"} = "Warning - failed to find a date";
			# use today's date
            $quoter->store_date(\%fundquote, $code, {today => 1});
			# ... and continue
		}
		else
		{
		    $quoter->store_date(\%fundquote, $code, {eurodate => $date});
		}

		$fundquote {$code, "method"} = "ftfunds";   # set method

	}

	return wantarray ? %fundquote : \%fundquote;
}

1;

=head1 NAME

Finance::Quote::ftfunds - Obtain UK Unit Trust quotes from FT.com (Financial Times).

=head1 SYNOPSIS

    $q = Finance::Quote->new;

    %info = Finance::Quote->fetch("ftfunds","<mexid> ...");  # Only query FT.com using MEXIDs
    %info = Finance::Quote->fetch("ukfunds","<isin>|<sedol>|<mexid>..."); # Failover to other sources 

=head1 DESCRIPTION

This module fetches information from the Financial Times Funds service,
http://funds.ft.com. There are over 47,000 UK Unit Trusts and OEICs quoted, 
as well as many Offshore Funds and Exhange Traded Funds (ETFs). It converts 
any funds quoted in GBX (pence) to GBP, dividing the price by 100 in the 
process.

Funds are identified by their MEXID code, a 4-6 letter code. Although the 
web site also allows searching by SEDOL or ISIN codes, this version of 
Finance::Quote::ftfunds only implements MEXID lookup. To determine the MEXID
for funds of interest to you, visit the funds.ft.com site and use the flexible 
search facilities to identify the funds of interest. The factsheet display for 
any given fund displays the MEXID, SEDOL and ISIN along with other useful information.

This module is loaded by default on a Finance::Quote object. It's 
also possible to load it explicity by placing "ftfunds" in the argument
list to Finance::Quote->new().

Information obtained by this module may be covered by funds.ft.com 
terms and conditions See http://funds.ft.com/ and http://ft.com for details.

=head2 Stocks And Indices

This module provides both the "ftfunds" and "ukfunds" fetch methods for 
fetching UK and Offshore Unit Trusts and OEICs prices and other information 
from funds.ft.com. Please use the "ukfunds" fetch method if you wish to have 
failover with future sources for UK and Offshore Unit Trusts and OEICs - the 
author has plans to develop Finance::Quote modules for the London Stock Exchange 
and Morningstar unit trust services. Using the "ftfunds" method will guarantee 
that your information only comes from the funds.ft.com website.

=head1 LABELS RETURNED

The following labels may be returned by Finance::Quote::ftfunds :

    name, currency, last, date, time, price, nav, source, method, 
    iso_date, net, p_change, success, errormsg.


=head1 SEE ALSO

Financial Times websites, http://ft.com and http://funds.ft.com


=head1 AUTHOR

Martin Sadler, E<lt>martinsadler@users.sourceforge.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Martin Sadler

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut

__END__


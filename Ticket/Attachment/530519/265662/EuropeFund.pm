#!/usr/bin/perl -w
#
#    Copyright (C) 1998, Dj Padzensky <djpadz@padz.net>
#    Copyright (C) 1998, 1999 Linas Vepstas <linas@linas.org>
#    Copyright (C) 2000, Yannick LE NY <y-le-ny@ifrance.com>
#    Copyright (C) 2000, Paul Fenwick <pjf@cpan.org>
#    Copyright (C) 2000, Brent Neal <brentn@users.sourceforge.net>
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
# This code derived from Padzensky's work on package Finance::YahooQuote,
# but extends its capabilites to encompas a greater number of data sources.
#
# This code was developed as part of GnuCash <http://www.gnucash.org/>

package Finance::Quote::Yahoo::EuropeFund;
require 5.005;

use strict;
use HTTP::Request::Common;
use LWP::UserAgent;
use Finance::Quote::Yahoo::Base qw/yahoo_request base_yahoo_labels/;

use vars qw($VERSION $YAHOO_EUROPE_URL);

$VERSION = '1.15';

# URLs of where to obtain information.

$YAHOO_EUROPE_URL = ("http://uk.finance.yahoo.com/d/quotes.csv");

# Based on Yahoo_europe module, changes to enable retrieval for funds
# identified by ISIN-based symbols (ISIN + currency code).
# Yahoo Europe broke date and time. sending d1 is a no-op, sending t1
# returns Time followed by Date (2 fields returned for 1 sent). 
#
# Time code placed last so the 2 fields returned don't screw up field counting.

our @YH_EUROPE_FUNDS_FIELDS = qw/symbol name last net p_change volume bid ask
                           close open day_range year_range eps pe div div_yield
                           cap avg_vol currency time date/;
                           
our @YH_EUROPE_FUNDS_FIELD_ENCODING = qw/s n l1 c1 p2 v b a p o m w e r d y j1 a2 c4 t1 d1/;

sub methods {return (europe_funds => \&yahoo_europe_funds,yahoo_europe_funds => \&yahoo_europe_funds)};

{
	my @labels = (base_yahoo_labels(),"currency","method");

	sub labels { return (europe_funds => \@labels, yahoo_europe_funds => \@labels); }
}

# =======================================================================
# yahoo_europe_funds gets quotes for European mutual funds from Yahoo.
sub yahoo_europe_funds
{
	my $quoter = shift;
	my @symbols = @_;
	return unless @symbols;	# Nothing if no symbols.

        # localise the Base.FIELDS and Base.FIELS_ENCODING arrays. Perl restores the arrays at
        # the end of this sub.
        local @Finance::Quote::Yahoo::Base::FIELDS = @YH_EUROPE_FUNDS_FIELDS ;
        local @Finance::Quote::Yahoo::Base::FIELD_ENCODING = @YH_EUROPE_FUNDS_FIELD_ENCODING ;

	# This does all the hard work.
	my %info = yahoo_request($quoter,$YAHOO_EUROPE_URL,\@symbols);

	foreach my $symbol (@symbols) {
		next unless $info{$symbol,"success"};
		$info{$symbol,"method"} = "yahoo_europe_funds";
		# Yahoo doesn't return an exchange for fund quotes
		# so logic in Base.pm that catches and changes pence quotes to pounds
		# will not work. Change pence to pounds here instead.
		if ($info{$symbol,"currency"} eq "GBP") {
		  foreach my $field ($quoter->default_currency_fields) {
			  next unless ($info{$symbol,$field});
			  $info{$symbol,$field} =
			  $quoter->scale_field($info{$symbol,$field},0.01);
			  }
			}
	}

	return %info if wantarray;
	return \%info;
}

1;

=head1 NAME

Finance::Quote::Yahoo::EuropeFund - Fetch mutual fund quotes from Yahoo Europe

=head1 SYNOPSIS

    use Finance::Quote;
    $q = Finance::Quote->new;

    %info = $q->fetch("europe_funds","GB0001036531GBP"); # Failover to other methods ok.
    %info = $q->fetch("yahoo_europe_funds","GB0001036531GBP"); # Use this module only.

=head1 DESCRIPTION

This module fetches information from Yahoo Europe.  Symbols should be
provided in the format ISIN+currency code (e.g. GB0001036531GBP)

This module provides both the "europe_funds" and "yahoo_europe_funds" methods.

This module is loaded by default by Finance::Quote, but can be loaded
explicitly by specifying the parameter "Yahoo::EuropeFund" to
Finance::Quote->new().

Information obtained by this module may be covered by Yahoo's terms
and conditions.  See http://finance.uk.yahoo.com/ for more details.

=head1 LABELS RETURNED

This module returns all the standard labels (where available) provided
by Yahoo.  See Finance::Quote::Yahoo::Base for a list of these.  The
currency label is also returned.

Note however that div_date and ex_div have been removed by yahoo
europe site

=head1 SEE ALSO

Yahoo Europe, http://finance.uk.yahoo.com/

Finance::Quote::Yahoo::Base

=cut

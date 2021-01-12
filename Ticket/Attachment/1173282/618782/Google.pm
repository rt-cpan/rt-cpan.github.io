#
# Copyright (C) 2013, Christopher Hill <ch6574@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# $Id: Google.pm 74 2013-01-23 12:53:15Z hillc $
#

package Finance::Quote::Google;
require 5.006;

use strict;
use warnings;
use base 'Exporter';
use HTTP::Request::Common;
use URI::Escape;
use XML::LibXML;

our @EXPORT_OK = qw(google methods labels);
our $VERSION   = 1.00;

# Google URL
our $GOOGLE_URL = ('http://www.google.com/ig/api?stock=');

sub methods { return ( google => \&google ); }
sub labels  { return ( google => [qw/symbol date nav/] ); }

sub google
{
    my $quoter  = shift;
    my @symbols = @_;

    # Nothing to do if no symbols.
    return unless @symbols;

    my ( $ua, $response, %info, $dom, $node, $symbol, $date, $time );

    $ua = $quoter->user_agent;

    # Escape any special characters into URI format
    @symbols = map { uri_escape $_ } @symbols;

    # Query the server
    $response = $ua->request( GET $GOOGLE_URL. join( "&stock=", @symbols ) );

    # Check response is xml data
    if (    $response->is_success
         && $response->content_type eq 'text/xml' )
    {

        # Parse XML data
        $dom = XML::LibXML->new->parse_string( $response->content );
        for $node ( $dom->findnodes('/xml_api_reply/finance') )
        {

            $symbol = $node->findvalue('symbol/@data');

            $info{ $symbol, 'success' } = 1;
            $info{ $symbol, 'method' }  = 'Google';
            $info{ $symbol, 'symbol' }  = $symbol;
            $info{ $symbol, 'name' } = $node->findvalue('company/@data');
            $info{ $symbol, 'last' } = $node->findvalue('last/@data');
            $info{ $symbol, 'high' } = $node->findvalue('high/@data');
            $info{ $symbol, 'low' }  = $node->findvalue('low/@data');
            $info{ $symbol, 'net' }  = $node->findvalue('change/@data');
            $info{ $symbol, 'p_change' } =
              $node->findvalue('perc_change/@data');
            $info{ $symbol, 'volume' }   = $node->findvalue('volume/@data');
            $info{ $symbol, 'avg_vol' }  = $node->findvalue('avg_volume/@data');
            $info{ $symbol, 'close' }    = $node->findvalue('y_close/@data');
            $info{ $symbol, 'open' }     = $node->findvalue('open/@data');
            $info{ $symbol, 'cap' }      = $node->findvalue('market_cap/@data');
            $info{ $symbol, 'currency' } = $node->findvalue('currency/@data');

            # Timezone is UTC
            $info{ $symbol, 'timezone' } = 'UTC';

            # Date needs converting from 'yyyymmdd' to 'yyyy-mm-dd'
            $date = $node->findvalue('current_date_utc/@data');
            $date =~ s/(\d{4})(\d{2})(\d{2})/$1-$2-$3/;
            $quoter->store_date( \%info, $symbol, { isodate => $date } );

            # Time needs converting from 'hhMMss' to 'hh:mm'
            $time = $node->findvalue('current_time_utc/@data');
            $time =~ s/(\d{2})(\d{2})(\d{2})/$1:$2/;
            $info{ $symbol, 'time' } = $time;
        }
    }
    else
    {
        foreach my $symbol (@symbols)
        {
            $info{ $symbol, 'errormsg' } = 'Search unavailable';
            $info{ $symbol, 'success' }  = 0;
        }
    }

    return wantarray() ? %info : \%info;
}

1;

__END__

=head1 NAME

Finance::Quote::Googlr - Obtain price data from Google Finance.

=head1 VERSION

This documentation describes version 1.00 of Google.pm, January 23, 2013.

=head1 SYNOPSIS

    use Finance::Quote;

    $q = Finance::Quote->new;

    %info = $q->fetch("google", "GOOG");

=head1 DESCRIPTION

This module obtains information from Google Finance via an unpublished API,
L<http://www.google.com/finance/>.

Information returned by this module is governed by Google's
terms and conditions.

=head1 FUND SYMBOLS

Use the symbols you would normally enter into Google Finance's search (ignoring the part before the colon).  For example "INDEXDJX:.DJI" you would enter as ".DJI"

=head1 LABELS RETURNED

The following labels may be returned by Finance::Quote::Google:
symbol, date, currency, last, timezone, avg_vol, cap, close, currency, date, high, isodate, last, low, method, name, net, open, p_change, symbol, time, timezone, volume

=head1 REQUIREMENTS

 Perl 5.006
 URI::Escape
 XML::LibXML
 Exporter.pm (included with Perl)

=head1 ACKNOWLEDGEMENTS

Inspired by other modules already present with Finance::Quote 

=head1 AUTHOR

Christopher Hill

=head1 LICENSE AND COPYRIGHT
 
Copyright (C) 2013, Christopher Hill <ch6574@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

=head1 DISCLAIMER

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

=cut

#!/usr/bin/perl -w

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
# $Id: Google.t 69 2013-01-23 12:45:05Z hillc $
#

use strict;
use Test::More;
use Finance::Quote;

if ( not $ENV{ONLINE_TEST} )
{
    plan skip_all => 'Set $ENV{ONLINE_TEST} to run this test';
}

plan tests => 12;

# Test Google functions.

my $q = Finance::Quote->new();
my @funds = ( "GOOG", ".DJI" );

my %info = $q->google(@funds);
ok(%info);

# Check that the currency, last, and success defined for all of the funds.
foreach my $fund (@funds)
{

    # Both GOOG and .DJI are quoted in USD
    cmp_ok( $info{ $fund, 'currency' }, 'eq', 'USD',    'symbol' );
    cmp_ok( $info{ $fund, 'method' },   'eq', 'Google', 'method' );
    cmp_ok( $info{ $fund, 'last' },     '>',  0,        'last' );
    cmp_ok( $info{ $fund, 'symbol' },   'eq', $fund,    'symbol' );

    ok( $info{ $fund, 'success' }, 'success' );
}

# Check that a bogus symbol returns no-success.
ok( !$info{ "BOGUS", "success" } );

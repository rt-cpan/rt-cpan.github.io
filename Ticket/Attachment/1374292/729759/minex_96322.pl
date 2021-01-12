#!/usr/bin/perl

#
# $Id: minex_96322.pl,v 1.3 2014/06/10 21:56:58 gdg Exp $
#

#
# Minimal example demonstrating the "bizarre copy" fault observed under 
# perl 5.20.0, as reported in rt.cpan.org ticket #96322:
#
#    https://rt.cpan.org/Public/Bug/Display.html?id=96322
#
# To use:
#
#   * Set up TWS parms as appropriate
#   * Set (or not) variable $enable_fault. Comments prior explain what is 
#     seen on my system in each case, for perl 5.18.2 and 5.20.0.
#

use strict;
use warnings;
use Finance::InteractiveBrokers::SWIG 0.12;
use MyEventHandler;		# Verbatim from the F::IB::SWIG distro

print "PERL version $]\n";	# FSA

#
# Set up TWS connection parms here
#
my $host = 'ga';		# TWS host 
my $port = 7496;		# TWS port #
my $client_id = 12321;		# Arbitrary


#
# Observations on my system:
#
# Using perl 5.20.0:
#
#   * With $enable_fault=1, the following fault is observed consistently when
#     calling eConnect():
#
#       Bizarre copy of UNKNOWN in scalar assignment at [...]/SWIG.pm line 206
#
#
#   * With $enable_fault=0, the "bizarre copy" fault is never seen, but the
#     eConnect() always fails.
#
#
# Using perl 5.18.2:
#
#   * Setting of $enable_fault has no effect (other than obviously not opening
#     the logfile) and the eConnect() is always successful. In other words
#     normal behavior in all respects.
#
my $enable_fault = 1;
if ($enable_fault)
{
    open(LFH, ">somelog.txt") or die "? can't open logfile\n";
    # NOTE: The following print isn't necessary to induce the fault, it's
    # only here to avoid the "used only once" warning on LFH.
    print(LFH "Use LFH so we don't get 'used only once' warning\n");
}

my $ibapi = Finance::InteractiveBrokers::SWIG->new
(
    handler => MyEventHandler->new()
);

if ( ! $ibapi->eConnect($host, $port, $client_id))
{
    die "\neConnect() failed.";
}
print "eConnect() successful\n";

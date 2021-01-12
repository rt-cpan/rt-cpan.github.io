#!/usr/bin/perl -w
use strict;
use OpenOffice::OODoc;
use OpenOffice::OODoc::XPath;
use Data::Dumper;
my $file = shift;
my $ofile = ooFile($file);
my $basic = OpenOffice::OODoc::XPath->new(
    member => 'Basic/script-lc.xml', 
    element => 'library:libraries',
    file => $ofile
    );
my $elem = $basic->getElement('//library:libraries');
# this yields something when using
# our     $VERSION        = 2.223;
# use     XML::Twig       3.22;
#
# but undef when using 
# our     $VERSION        = '2.237';
# use     XML::Twig       3.32;
# have to supply undocumented context parameter
$elem = $basic->getElement('//library:libraries', 0, $basic->{'xpath'});
print "why?\n";
exit(0);

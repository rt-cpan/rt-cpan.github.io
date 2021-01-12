#!/usr/bin/perl
use strict;
use warnings;
use OpenOffice::OODoc;

my %autostyles;
my $document = odfDocument(file => 'test.odt');

### Use 'getStyleAttributes' function to read properties:
print "\n";
foreach my $style ($document->getAutoStyleList) {
    my %attributes = $document->getStyleAttributes($style);
    my $references = $attributes{references};
    my $properties = $attributes{properties};

    my $name = $references->{'style:name'};

    if ($references) {
        print "Attributes of automatic style '$name' has references.\n";
        $autostyles{$name}->{family} = $references->{'style:family'}            || 'none';
        $autostyles{$name}->{parent} = $references->{'style:parent-style-name'} || 'none';
    } else {
        print "Attributes of automatic style '$name' does not have references.\n";
    }

    if ($properties) {
        print "Attributes of automatic style '$name' has properties.\n";
        $autostyles{$name}->{bold}   = (exists $properties->{'fo:font-weight'}
                                           and $properties->{'fo:font-weight'} eq 'bold')   ? 'true' : 'false';
        $autostyles{$name}->{italic} = (exists $properties->{'fo:font-style'}
                                           and $properties->{'fo:font-style'}  eq 'italic') ? 'true' : 'false';
    } else {
        print "Attributes of automatic style '$name' does not have properties.\n";
    }

    print "\n";
}
print_autostyles("Properties via 'getStyleAttributes'");

### Use brute force (Read properties via XML::XPath):
print "\n";
foreach my $style ($document->getAutoStyleList) {
    unless ($style->{att}{'style:family'} eq 'text' or
        $style->{att}{'style:family'} eq 'paragraph') {
        print qq{Automatic style "$style->{att}{'style:name'}" ($style->{att}{'style:family'}) ignored\n};
        next;
    }
    my ($bold, $italic) = (0, 0);
    for (my $p = $style->{first_child}; $p; $p = $p->{next_sibling}) {
        $bold = 1   if exists $p->{att}{'fo:font-weight'} and $p->{att}{'fo:font-weight'} eq 'bold';
        $italic = 1 if exists $p->{att}{'fo:font-style'}  and $p->{att}{'fo:font-style'}  eq 'italic';
    }
    $autostyles{$style->{att}{'style:name'}} = {
        family => $style->{att}{'style:family'}             || 'none',
        parent => $style->{att}{'style:parent-style-name'}  || 'none',
        bold   => $bold     ? 'true' : 'false',
        italic => $italic   ? 'true' : 'false',
    };
}
print_autostyles("Properties via brute force");

### Subroutine to print styles:
sub print_autostyles {
    my $title = shift;
    print '--- ', $title, ' ', '-'x(40 - length $title);
    foreach my $style (sort keys %autostyles) {
        print "\nAutomatic style '$style':\n";
        foreach my $property (sort keys %{$autostyles{$style}}) {
            print "\t$property: $autostyles{$style}->{$property}\n";
        }
    }
    print '-'x45, "\n";
}

__END__
Output of this program:

Attributes of automatic style 'P1' has references.
Attributes of automatic style 'P1' does not have properties.

Attributes of automatic style 'T1' has references.
Attributes of automatic style 'T1' has properties.

--- Properties via 'getStyleAttributes' -----
Automatic style 'P1':
	family: paragraph
	parent: Text_20_body

Automatic style 'T1':
	bold: false
	family: text
	italic: true
	parent: none
---------------------------------------------

--- Properties via brute force --------------
Automatic style 'P1':
	bold: false
	family: paragraph
	italic: true
	parent: Text_20_body

Automatic style 'T1':
	bold: false
	family: text
	italic: true
	parent: none
---------------------------------------------

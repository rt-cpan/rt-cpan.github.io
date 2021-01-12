#!/usr/bin/perl
use warnings;
use strict;

use Geo::OSM::MapFeatures;
use XML::Simple;

my $mf = new Geo::OSM::MapFeatures;
$mf->trace(1);

my $category = 'test';
my $template = <<EOF
<?xml version="1.0" encoding="utf-8"?><api><expandtemplates>
{|
| [[key:access | maxheight]]
| [[Map_Features/Units#Measure|Height]]
| [[Image:Mf_way.png|way]]
| height limit - units other than metres should be explicit
|  
| [[Image:Maxheight.png|35px|center]][[Image:Maxheight photo.JPG|100px|center]] 
|}
|}</expandtemplates></api>
EOF
;
push(@{$mf->{featuretemplates}}, $category);
$mf->{content}{$category} = XMLin($template);
$mf->parse();

foreach my $feature ( $mf->features($category) ){
    print "$feature\n";
}


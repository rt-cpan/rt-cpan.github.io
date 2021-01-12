#!/usr/bin/perl
use strict;
use warnings;

use Text::Table;
my @col_titles = ( "Radius\nkm", "Density\ng/cm^3" );
my $tb = Text::Table->new(
   {  is_sep => 1,
      title  => '| ',
      body   => '| ', },
   {  title       => 'Planet',
      align_title => 'center', },
   (  map {
         (  {  is_sep => 1,
               title  => ' | ',
               body   => ' | ', },
            {  title       => $_,
               align_title => 'center', }, )
         } @col_titles ),
   {  is_sep => 1,
      title  => ' |',
      body   => ' |', }, );

$tb->load(
   [ "Mercury", 2360,  3.7 ],
   [ "Venus",   6110,  5.1 ],
   [ "Earth",   6378,  5.52 ],
   [ "Jupiter", 71030, 1.3 ], );

print $tb->rule( q{-}, q{+} );
print $tb->title();
print $tb->rule( q{-}, q{+} );
print $tb->body();
print $tb->rule( q{-}, q{+} );

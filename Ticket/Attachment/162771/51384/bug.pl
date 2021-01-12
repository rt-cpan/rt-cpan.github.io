#!/usr/bin/perl

use strict;
use warnings;

use XML::Twig;
use YAML;

my $xml="ct-usb-audio-test.xml.bz2";

my $oldval;

eval { my($fh,$parser);
       open($fh, "-|", "bzcat", "$xml"), or die "Can't fork bzcat: $!\n";
       $oldval = {};
       $parser = new XML::Twig
            ( twig_roots => { "title" => sub { $oldval->{title} = $_[1]->text(); shift()->purge(); },
                             "expires" => sub { $oldval->{expiry} = $_[1]->text(); shift()->purge(); },
                             "timestamp" => sub { $oldval->{timestamp} = $_[1]->text(); shift()->purge(); },
                             "keywords" => sub { $oldval->{keywords} = $_[1]->text(); shift()->purge(); },
                             "hardcopy" => sub { $oldval->{hardcopy} = $_[1]->text(); shift()->purge(); },
                             "tag" => sub { push @{$oldval->{tags}}, $_[1]->text(); shift()->purge(); },
                             "file" => sub { $oldval->{indexfile}->{$_[1]->att("name")} = $_[1]->att("index") ?  'y' : 'n'; 
                                             shift()->purge();
                                           },
                            }
            );
       $parser->parse($fh);
  };

if( $@) { die "error parsing: $@"; }

print Dump $oldval;


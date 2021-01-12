#!/usr/bin/perl

use utf8;
use v5.10.0;
use strict;

my $dist = 'POE-Component-Schedule';

my $Changes = do {
    open my $fd, "<:utf8", "Changes";
    local $/ = undef;
    <$fd>;
};

#print $Changes;

my $parser = do {
    use Regexp::Grammars;
    qr{

  \A
  \R*
  <Header>
  <[Release]>+

        (?:
            # Should be at end of input...
          #  \s* \Z
          #|
            # If not, report the fact but don't fail...
            <warning: Expected end-of-input> 
            <warning: (?{ "Extra junk at index $INDEX: $CONTEXT" })>
        )



<token: Header>
  \S \V+ ( \R \V+ )*

<token: Release>
  \R+
  <debug: on>
  <Version> \h+ <Date> (?: <Time> <TimeZone>? )? \h+ <Author_Id> \h+ \( <Author_Name> \) \R
  <[Changes]>+
  <debug: off>

<token: Version>
  \d+\.\d+(_\d+)?

<token: Date>
  \d{4}-\d{2}-\d{2}

<token: Time>
  \d{2}:\d{2}

<token: TimeZone>
  Z | [+-]\d{2}:\d{2}

<token: Author_Id>
  \w+

<token: Author_Name>
  [^)]+

<token: Changes>
  (?:\t|[ ]{8}) (\S\V*) \R
  (?:
    (?:\t[ ]{2}|\h{10}) \h* (\V+) \R
  )*

    }xms;
};

$Changes =~ $parser or die "format invalide !\n";

use YAML 0.71 ();
print YAML::Dump(\%/), "\n";

use Data::Dumper;
print Dumper(\%/), "\n";

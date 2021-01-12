# $Id$
#
# Sergey Chernyshev <sergeyche@cpan.org>
# All rights reserved.
#
# This test is supposed to test if multiple enclosures get parsed into array
# and get rendered into multiple enclosure tags too
#
# See bug #20285
# http://rt.cpan.org/Public/Bug/Display.html?id=20285
#

use strict;
use Test::More (tests => 8);
BEGIN { use_ok("XML::RSS::LibXML") }

my $version = '2.0';
use constant RSS_FEED => qq(<?xml version="1.0"?>
<rss version="2.0"
 xmlns:dc="http://purl.org/dc/elements/1.1/">
 <channel>
  <title>Example 2.0 Channel</title>
  <link>http://example.com/</link>
  <description>To lead by example</description>
   <category>test1</category>
   <category>test2</category>
  <item>
   <title>News for September the Second</title>
   <link>http://example.com/2002/09/02</link>
   <description>other things happened today</description>
   <enclosure url="http://example.com/1.mp3" type="audio/mpeg" length="4096"/>
   <enclosure url="http://example.com/2.mp3" type="audio/mpeg" length="4096"/>
  </item>
 </channel>
</rss>
);

my $xml = XML::RSS::LibXML->new();
isa_ok($xml,"XML::RSS::LibXML");

eval { $xml->parse(RSS_FEED) };
ok(!$@, "Expected to parse RSS feed from string: $@");

is(ref ($xml->{items}[0]->{enclosure}), 'ARRAY', "Multiple enclosures need to be parsed into array");

is($xml->{items}[0]->{enclosure}[0]->{url}, 'http://example.com/1.mp3', "First enclosure is parsed correctly");
is($xml->{items}[0]->{enclosure}[1]->{url}, 'http://example.com/2.mp3', "Second enclosure is parsed correctly");

my $formatted = $xml->as_string();
ok($formatted=~/<enclosure[^>]url="http:\/\/example.com\/1.mp3"/s, "When rendered, must contain first enclosure - not ARRAY(...)");
ok($formatted=~/<enclosure[^>]url="http:\/\/example.com\/2.mp3"/s, "When rendered, must contain second enclosure two");

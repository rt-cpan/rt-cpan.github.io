# $Id$
#
# Sergey Chernyshev <sergeyche@cpan.org>
# All rights reserved.
#
# This test is supposed to test if multiple tags of the same type get parsed into array
# and get rendered into multiple tags too. Example uses <category> tags on both
# channel and item levels
#
# See bug #22750
# http://rt.cpan.org/Public/Bug/Display.html?id=22750
#

use strict;
use Test::More (tests => 13);
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
   <category>test3</category>
   <category>test4</category>
  </item>
 </channel>
</rss>
);

my $xml = XML::RSS::LibXML->new();
isa_ok($xml,"XML::RSS::LibXML");

eval { $xml->parse(RSS_FEED) };
ok(!$@, "Expected to parse RSS feed from string: $@");

is(ref ($xml->{channel}->{category}), 'ARRAY', "Categories on channel level need to be parsed into array");
is($xml->{channel}->{category}[0], 'test1', "First category on channel level is parsed correctly");
is($xml->{channel}->{category}[1], 'test2', "Second category on channel level is parsed correctly");

is(ref ($xml->{items}[0]->{category}), 'ARRAY', "Categories on item level need to be parsed into array");
is($xml->{items}[0]->{category}[0], 'test3', "First category on item level is parsed correctly");
is($xml->{items}[0]->{category}[1], 'test4', "Second category on item level is parsed correctly");

my $formatted = $xml->as_string();
ok($formatted=~/<category>test1<\/category>/s, "When rendered, must contain first category tag on channel level - not ARRAY(...)");
ok($formatted=~/<category>test2<\/category>/s, "When rendered, must contain second category on channel channel");
ok($formatted=~/<category>test3<\/category>/s, "When rendered, must contain first category tag on item level - not ARRAY(...)");
ok($formatted=~/<category>test4<\/category>/s, "When rendered, must contain second category on item level");

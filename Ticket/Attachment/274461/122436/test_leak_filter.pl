use warnings;
use strict;

use POE::Filter::XML::Handler;
use XML::SAX::Expat::Incremental;
use Devel::Leak;
use Devel::Cycle;

my $handler = POE::Filter::XML::Handler->new();
for(0..100)
{
	my $parser = XML::SAX::Expat::Incremental->new('Handler' => $handler);
	$parser->parse_string('');
	eval { $parser->parse_done(); };
	warn Devel::Leak::NoteSV(my $foo);
	find_cycle($parser);
}

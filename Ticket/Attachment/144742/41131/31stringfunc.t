use Test;
use Data::Dumper;
BEGIN { plan tests => 26 }

use XML::XPath;
ok(1);

my $xp = XML::XPath->new(ioref => *DATA);
ok($xp);

my $resultset;

$resultset = $xp->find('concat("1","2","3"');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '123');

$resultset = $xp->find('starts-with("123","1"');
ok($resultset->isa('XML::XPath::Boolean'));
ok($resultset->to_literal(), 'true');

$resultset = $xp->find('starts-with("123","23"');
ok($resultset->isa('XML::XPath::Boolean'));
ok($resultset->to_literal(), 'false');

$resultset = $xp->find('contains("123","1"');
ok($resultset->isa('XML::XPath::Boolean'));
ok($resultset->to_literal(), 'true');

$resultset = $xp->find('contains("123","4"');
ok($resultset->isa('XML::XPath::Boolean'));
ok($resultset->to_literal(), 'false');

$resultset = $xp->find('substring-before("1999/04/01","/")');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '1999');

$resultset = $xp->find('substring-before("1999/04/01","?")');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '');

$resultset = $xp->find('substring-after("1999/04/01","/")');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '04/01');

$resultset = $xp->find('substring-after("1999/04/01","19")');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '99/04/01');

$resultset = $xp->find('substring-after("1999/04/01","2")');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '');

$resultset = $xp->find('substring("12345",2,3)');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '234');

$resultset = $xp->find('substring("12345",2)');
ok($resultset->isa('XML::XPath::Literal'));
ok($resultset, '2345');

__DATA__
<AAA>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <CCC/>
    <CCC/>
    <CCC/>
</AAA>

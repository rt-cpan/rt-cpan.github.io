use Test::More tests => 1;
use WWW::Robot;

my $WEBSITE = 'http://www.example.com/'; # can be anything that allows robots
my $num_invoked_links = 0;

my $robot = WWW::Robot->new(
    NAME    => 'MyRobot',
    VERSION => 0,
    EMAIL   => 'example@example.com',
    DELAY   => 0, # we only follow 1 URL
);

$robot->addHook('follow-url-test', sub { 1 });
$robot->addHook('invoke-on-link', sub { $num_invoked_links++ });
$robot->addHook('continue-test', sub { 0 });

$robot->run($WEBSITE);



my $expected = $num_invoked_links;
$num_invoked_links = 0; # reset it



$robot = WWW::Robot->new(
    NAME    => 'MyRobot',
    VERSION => 0,
    EMAIL   => 'example@example.com',
    DELAY   => 0, # we only follow 1 URL
);

$robot->addHook('follow-url-test', sub { 1 });
$robot->addHook('invoke-on-link', sub { $num_invoked_links++ });
$robot->addHook('continue-test', sub { 0 });

$robot->addHook('add-url-test', sub { 0 }); # should not change $num_invoked_links

$robot->run($WEBSITE);




cmp_ok($num_invoked_links, '==', $expected, 'invoke-on-link hook on ALL links');

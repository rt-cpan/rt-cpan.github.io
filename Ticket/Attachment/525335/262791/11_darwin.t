use strict;
use warnings;

use Test::More;
use File::HomeDir;

$File::HomeDir::IMPLEMENTED_BY eq 'File::HomeDir::Darwin'
    or plan skip_all => "File::HomeDir::Darwin not used under $^O";

plan tests => 2;

SKIP: {
    my $user;
    foreach (0 .. 9) {
	my $temp = sprintf 'fubar%04d', rand(10000);
	getpwnam $temp and next;
	$user = $temp;
	last;
    }
    $user or skip("Unable to find non-existent user", 1);
    $@ = undef;
    my $home = eval {File::HomeDir->users_home($user)};
    $@ and skip("Unable to execute File::HomeDir->users_home('$user')");
    ok (!defined $home, "Home of non-existent user should be undef");
}

SKIP: {
    my $user;
    foreach my $uid (501 .. 540) {
	$uid == $< and next;
	$user = getpwuid $uid or next;
	last;
    }
    $user or skip("Unable to find another user", 1);
    my $me = getpwuid $<;
    defined (my $my_home = eval {File::HomeDir->my_home()})
	or skip ("File::HomeDir->my_home() undefined", 1);
    defined (my $users_home = eval {File::HomeDir->users_home($user)})
	or skip ("File::HomeDir->users_home('$user') undefined", 1);
    $my_home eq $users_home
	and skip ("Users '$me' and '$user' have same home", 1);
    defined (my $my_data = eval {File::HomeDir->my_data()})
	or skip ("File::HomeDir->my_data() undefined", 1);
    defined (my $users_data = eval {File::HomeDir->users_data($user)})
	or skip ("File::HomeDir->users_data('$user') undefined", 1);
    ok ($my_data ne $users_data,
	"Users '$me' and '$user' should have different data");
}


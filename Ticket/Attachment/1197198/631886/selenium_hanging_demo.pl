# ------------------------------------------------------------
# A Selenium Perl client script to demonstrate its start-up
# hanging.
# ------------------------------------------------------------
use strict;
use warnings;
use Time::HiRes qw(sleep);
use Test::WWW::Selenium;
use Test::More "no_plan";
use Test::Exception;

my $selenium_dir        = 'D:/Meir/Dropbox/Data_base/Scripts/Selenium';
my $firefox_profile_dir = 'D:/Meir/Dropbox/Data_base/Scripts/Selenium';
my $selenium_jar_file   = 'selenium-server-standalone-2.28.0.jar';

my $sel;
my $selenium_call_string =
  "start cmd /k java -jar $selenium_dir/$selenium_jar_file ".
  "-firefoxProfileTemplate \"$firefox_profile_dir\"";

system ($selenium_call_string) == 0 or die "system call failed: $?\n";

print "Just fired up the Selenium server\n";

$sel = Test::WWW::Selenium->new(
  host        => "localhost",
  port        => 4444,
  browser     => "*firefox",
  browser_url => "http://www.tase.co.il/"
);

#eval {
#  local $SIG{ALRM} = sub { die "alarm\n" }; # NB: \n required
#  alarm 15;
#  alarm 0;
#};
#if ($@) {
#  die unless $@ eq "alarm\n";   # propagate unexpected errors
#}

#sleep 10;

print "... and now its client\n";

my $url = "http://www.tase.co.il/Eng/general/company/Pages/companyHistoryData.aspx?companyID=000629&subDataType=0&shareID=00629014";

$sel->open_ok($url);
$sel->click_ok("id=history1");
$sel->click_ok("xpath=(//input[\@value='Display Data'])[2]");
$sel->wait_for_page_to_load_ok("60000");
$sel->click_ok("css=td.GreenTextBtn");
$sel->click_ok("link=TSV");
$sel->wait_for_pop_up_ok("_blank", "60000");

END
{
  $sel->shut_down_selenium_server();
}
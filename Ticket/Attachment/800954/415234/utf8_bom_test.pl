#!/usr/bin/perl
use strict;
use encoding "utf8";
use open IO => ":utf8";
use Config::IniFiles;

my $cfg = Config::IniFiles->new(-file => "utf8_bom.ini") or do {
  my $err_message = join("\n", @Config::IniFiles::errors);
  die "$err_message\n";
};

my $cookie_jar = $cfg->val('General', 'cookie_jar');
print "Jar: $cookie_jar\n";

__END__

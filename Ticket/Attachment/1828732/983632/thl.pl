#!perl
use strict;
use warnings;
require Test::HTTP::LocalServer;
package Test::HTTP::LocalServer;
use File::Temp;
use File::Spec;

my $file = __PACKAGE__;
$file =~ s!::!/!g;
$file .= '.pm';
my ($tmpfh,$logfile) = File::Temp::tempfile();
close $tmpfh;
my $server_file = File::Spec->catfile( dirname( $INC{$file} ),'log-server' );
my ($fh,$url_file) = File::Temp::tempfile;
close $fh; # race condition, but oh well
my @opts = ("-f", $url_file);

my @cmd=( $^X, $server_file, '', $logfile, @opts );
warn "[@cmd]";
$ENV{TEST_HTTP_VERBOSE}=1;
#system(@cmd);
my $pid = system(1, @cmd);
sleep 1; # overkill, but good enough for the moment
warn $? if $?;
warn "Launched server as $pid";

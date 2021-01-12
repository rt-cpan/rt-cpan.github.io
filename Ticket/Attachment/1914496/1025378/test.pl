#! /usr/bin/perl

use strict;
use warnings;
use Win32();
use File::Spec();
use Fcntl();

print "DisplayName:" . Win32::GetOSDisplayName() . "\n";
print "OSName:" . Win32::GetOSName() . "\n";
print "OSVersion:" . ( join q[.], Win32::GetOSVersion() ) . "\n";

use strict;
foreach my $path ( split /;/sm, $ENV{Path} ) {
    if ( -e File::Spec->catfile( $path, 'firefox.exe' ) ) {
        print "Found firefox.exe in $path\n";
        my $short_path_name = Win32::GetShortPathName("$path\\firefox.exe");
        print "Which is $short_path_name\n";
        print `$short_path_name -version`;
        print "Checking application.ini\n";
        sysopen my $handle, File::Spec->catfile( $path, 'application.ini' ),
          Fcntl::O_RDONLY();
        while ( my $line = <$handle> ) {
            chomp $line;
            if ( $line =~ /^Version=/smx ) {
                print "INI:$line:\n";
            }
        }
    }
}
print "Trying default firefox in $ENV{ProgramFiles}\n";
my $short_path_name =
  Win32::GetShortPathName("$ENV{ProgramFiles}\\Mozilla Firefox\\firefox.exe");
print "Which is $short_path_name\n";
print `$short_path_name -version`;
print "Checking application.ini\n";
sysopen my $handle, "C:\\Program Files\\Mozilla Firefox\\application.ini",
  Fcntl::O_RDONLY();
while ( my $line = <$handle> ) {
    chomp $line;
    if ( $line =~ /^Version=/smx ) {
        print "INI:$line:\n";
    }
}

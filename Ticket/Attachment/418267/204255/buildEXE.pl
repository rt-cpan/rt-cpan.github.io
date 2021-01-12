#!/perl/bin/perl -w

use strict;

use FindBin;
use pp;

my $version = '1.0.0';
my $script = "$FindBin::Bin/test.pl";
my @libs = qw(
	Cairo/Cairo.dll
	Glib/Glib.dll
	Gtk2/Gtk2.dll
	Gtk2/GladeXML/GladeXML.dll
);

@ARGV = ();

push (@ARGV, '-z');
push (@ARGV, '9');
push (@ARGV, '--gui');
push (@ARGV, '-N');
push (@ARGV, "ProductVersion=$version");
push (@ARGV, '-N');
push (@ARGV, "FileVersion=$version");

for my $file (@libs) {
	for my $dir (@INC) {
		my $lib = "$dir/auto/$file";
		
		if (-f $lib) {
			push (@ARGV, '-l');
			push (@ARGV, $lib);
			last;
		}
	}
}

push (@ARGV, '-o');
push (@ARGV, "$FindBin::Bin/test.exe");
push (@ARGV, "$script");

pp->go();


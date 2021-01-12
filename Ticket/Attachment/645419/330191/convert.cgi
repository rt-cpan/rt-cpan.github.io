#!/usr/bin/perl  -w
use strict;

BEGIN{
	use CGI qw(:standard);
	use Carp qw( cluck );
	$|=1;
	$Carp::Verbose =1;
	#carpout(STDOUT);
	open STDERR, ">&STDOUT" or die "oops" ;
	$SIG{__DIE__} = sub{
	print header('text/html');
	print "<pre style='font-family:Arial;font-size:19px;'>";      
      Carp::cluck;
    };
}


use GD;

my $png = GD::Image->newFromPng(param('pngPath')) or die $!;

my $jpgImg = GD::Image->newTrueColor( $png->width, $png->height);

my $bg = $jpgImg->colorAllocate(80,10,10);

$jpgImg->fill(0,0,$bg);


$jpgImg->copy($png, 0,0,0,0, $png->width, $png->height);


print header('image/jpeg'), $jpgImg->jpeg(80);


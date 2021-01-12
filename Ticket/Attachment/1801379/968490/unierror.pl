#!/usr/bin/perl

use strict;
use warnings;
use utf8;

use PDF::API2;

my $api=PDF::API2->new();

$api->mediabox(595,842);

my $gefont='Helvetica';

my $ge=$api->corefont($gefont,-encode=>'latin1')->tounicodemap;
my $g2=$api->corefont($gefont,-encode=>'uni1');
my $g3=$api->corefont($gefont,-encode=>'uni2');
my $g4=$api->corefont($gefont,-encode=>'uni3');
my $g5=$api->corefont($gefont,-encode=>'uni4');
my $g6=$api->corefont($gefont,-encode=>'uni5');

my $uf=$api->unifont(
    $ge,
    [$g2,[1]],
    [$g3,[2]],
    [$g4,[3]],
    [$g5,[4]],
    [$g6,[5]],
    -encode=>'utf-8',
);

my $page = $api->page;
$page->mediabox(595,842);

my $text=$page->text;

$text->font($uf,20);
$text->transform(-translate=>[300,700]);
$text->text_center('bad ascii only center');
$text->transform(-translate=>[300,680]);
$text->text_center('bad latin1 center otilde:õ (0xd5)');
$text->transform(-translate=>[300,660]);
$text->text_center('latin2 center ohungaruml:ő (0x151)');
$text->transform(-translate=>[300,640]);
$text->text_center('mixed utf-8:õő');

$text->transform(-translate=>[300,600]);
$text->text_right('bad ascii only right');
$text->transform(-translate=>[300,580]);
$text->text_right('bad latin1 right otilde:õ (0xd5)');
$text->transform(-translate=>[300,560]);
$text->text_right('latin2 right ohungaruml:ő (0x151)');
$text->transform(-translate=>[300,540]);
$text->text_right('mixed utf-8:õő');

$api->saveas("unierror.pdf");
$api->end;

__END__


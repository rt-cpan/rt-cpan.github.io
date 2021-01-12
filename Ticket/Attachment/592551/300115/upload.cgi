#!/usr/bin/perl -w

use utf8;
use strict;
use warnings;

use CGI::Simple;
use Encode;
use Data::Dumper;

$CGI::Simple::PARAM_UTF8 = 1;
$CGI::Simple::DISABLE_UPLOADS = 0;
$Data::Dumper::Indent = 1;

my $q = CGI::Simple->new();
$q->charset('utf-8');

print <<EOT;
Content-Type: text/html; charset=utf-8

<html><head><title></title></head><body>

<form method="post" action="upload.cgi" enctype="multipart/form-data">
    <input type="file" name="F">
    <input type="submit" name="submit">
</form

<hr>
EOT

print "<pre>\n", Dumper(
    $q->param('F'),
    $q->upload($q->param('F')),
    $q->upload(encode_utf8($q->param('F'))),
    $q,
    ), "</pre>\n";
print "</body></html>\n";

1;

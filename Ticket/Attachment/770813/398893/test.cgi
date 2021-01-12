#!/usr/bin/perl

use strict;
use warnings;

use CGI qw(:standard :escapeHTML -nosticky);

my $cgi = CGI->new();

my $status = "200 OK";
my $content_type = 'text/html';
print $cgi->header(-type=>$content_type, -charset=>'utf-8', -status=>$status);
print <<"EOF";
<html>
<head>
<meta http-equiv="content-type" content="$content_type; charset=utf-8" />
<title>Test</title>
</head>
<body>
Test body
</body>
</html>
EOF



#!/usr/bin/perl

use CGI 3.12;

use constant LINE => '-' x 74 . "\n";

print(LINE);

$ENV{PATH_INFO}     = '/bar';
$ENV{SCRIPT_NAME}   = '/foo';
$ENV{REQUEST_URI}   = '/foo/%62ar';
$ENV{QUERY_STRING}  = undef;

my $q = CGI->new();

printf("%-20s = %s\n", $_, $ENV{$_}) for qw(PATH_INFO SCRIPT_NAME REQUEST_URI);
print("url(-absolute => 1, -rewrite => 0) = ", $q->url(-absolute => 1, -rewrite => 0), "\n");
print("url(-absolute => 1, -rewrite => 1) = ", $q->url(-absolute => 1, -rewrite => 1), "\n");

print(LINE);

$ENV{PATH_INFO}     = '/bär';
$ENV{REQUEST_URI}   = '/foo/b%C3%A4r';

my $q = CGI->new();

printf("%-20s = %s\n", $_, $ENV{$_}) for qw(PATH_INFO SCRIPT_NAME REQUEST_URI);
print("url(-absolute => 1, -rewrite => 0) = ", $q->url(-absolute => 1, -rewrite => 0), "\n");
print("url(-absolute => 1, -rewrite => 1) = ", $q->url(-absolute => 1, -rewrite => 1), "\n");

print(LINE);

$ENV{PATH_INFO}     = '/bar';
$ENV{REQUEST_URI}   = '/foo/bar';

my $q = CGI->new();

printf("%-20s = %s\n", $_, $ENV{$_}) for qw(PATH_INFO SCRIPT_NAME REQUEST_URI);
print("url(-absolute => 1, -rewrite => 0) = ", $q->url(-absolute => 1, -rewrite => 0), "\n");
print("url(-absolute => 1, -rewrite => 1) = ", $q->url(-absolute => 1, -rewrite => 1), "\n");

print(LINE);

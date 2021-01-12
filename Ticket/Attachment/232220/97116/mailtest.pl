#!/usr/bin/perl -w

use strict;
use Net::SMTP;

my $smtp = Net::SMTP->new('mail.moldtelecom.md',Debug => 1);
if ($smtp->mail('test@test.net')) {
 warn "Message: ".$smtp->message;
# exit;
}

if ($smtp->to('alexchorny@gmail.com')) {
 warn "Message: ".$smtp->message;
}

if ($smtp->data()) {
 warn "Message: ".$smtp->message;
}
if ($smtp->datasend("To: alexchorny\@gmail.com\n")) {
 warn "Message: ".$smtp->message;
}
$smtp->datasend("\n");
$smtp->datasend("A simple test message\n");
$smtp->dataend();

$smtp->quit;

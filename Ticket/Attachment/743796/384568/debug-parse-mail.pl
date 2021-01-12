#!/usr/bin/perl

use utf8;
use Mail::Message;

binmode STDOUT, ":utf8";
$msg = Mail::Message->read(\*STDIN);

my $full = $msg->head->study('to');
print "\$full is a ", ref($full), "\n";

print "nrLines=", $full->nrLines, "\n";
print "Name=", $full->Name, "\n";
print "decodedBody=", $full->decodedBody, "\n";

my @to = $full->addresses;
for my $a (@to) {
	print "\$a is a ", ref($a), "\n";

	print "To Address=", $a->address, "\n";
	print "To Name (encoded)=", $a->name, "\n";
	print "To Phrase (encoded)=", $a->phrase, "\n";
	my $name = Mail::Message::Field::Full->decode($a->name);
	print "To Name=$name\n";
}

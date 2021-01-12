# ABSTRACT: Simple shell to interact with PULO

use strict;
use warnings;
use URI::Encode 'uri_encode';

use Term::ReadLine;
use utf8;
use open ':encoding(utf8)';
use open ':std';
use POSIX qw(locale_h);
use locale;

BEGIN {  
	$ENV{LC_ALL} = "en_US.UTF-8";
	my $old_locale = setlocale(LC_ALL, 'en_US.UTF-8');
}


my $term = Term::ReadLine->new("pulo-shell");
my $line = $term->readline("> ");

		
print {$term->OUT} "IS UTF8\n" if utf8::is_utf8($line);

print {$term->OUT} $line, "\n";

print {$term->OUT} "Encoded: ", uri_encode($line), "\n";
print {$term->OUT} "Should be: ", uri_encode("coração"), "\n";

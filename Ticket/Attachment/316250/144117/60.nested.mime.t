use strict;
use warnings;

use Test::More tests => 2;
use File::Slurp;

BEGIN { unlink("t/test.db"); }

use Email::Store { only => [qw( Mail Attachment )] }, 
    ("dbi:SQLite:dbname=t/test.db", "", "", { sqlite_handle_binary_nulls => 1 } );
Email::Store->setup;
ok(1, "Set up");

my $data = read_file("t/nested-mime");
my $mail = Email::Store::Mail->store($data);
my @att = $mail->attachments;
is (@att, 2, "Has two attachments");

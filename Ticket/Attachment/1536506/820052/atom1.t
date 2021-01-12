
# https://rt.cpan.org/Ticket/Display.html?id=86166

use warnings;
use strict;
use File::Slurp qw(write_file);
use Test::More tests => 3;

my $file   = 'atom1.txt' ;
my $victim = "$file.$$";

write_file($victim, '');
ok(-f $victim, 'have a victim file');

# This must not destroy the victim
$@ = '';
eval { write_file($file, { 'atomic' => 1 }, 'foo') };
like($@, qr/atomic temporary file/, 'die if no filename');

ok(-f $victim, 'victim file still there');

unlink $victim;


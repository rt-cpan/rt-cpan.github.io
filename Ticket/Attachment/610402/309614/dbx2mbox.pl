#! /usr/bin/perl 

#dbx2mbox.pl <dbxfile> <mboxfile>
# convert <dbxfile> to <mboxfile>

$| = 1;

use strict;
use warnings;
use diagnostics;

use Mail::Transport::Dbx;
use Mail::Box::Mbox;
use Mail::Box::Dbx;

chomp (my $dbxfile = shift);
chomp (my $mboxfile = shift);

system ("/bin/rm -f $mboxfile");

-e $dbxfile || die "cannot find dbxfile $dbxfile";

print "opening existing dbxfile $dbxfile\n";
my $from = Mail::Box::Dbx->new(folder => $dbxfile)
    or die "cannot read dbxfile $dbxfile using Mail::Box:Dbx->new:$!";
print "dbxfile $dbxfile is open\n";

print "creating mboxfile $mboxfile\n";
my $to   = Mail::Box::Mbox->new(folder => $mboxfile,
    access => 'rw', create => 1) or die "cannot create new mbox file using Mail::Box::Mbox->new: $!";
print "mboxfile $mboxfile is created\n";

print "copying dbxfile($dbxfile) -> mboxfile($mboxfile)\n";
$from->copyTo($to) || die "from->copyTo($mboxfile) failed:$!";

exit;

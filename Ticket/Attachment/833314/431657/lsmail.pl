#!/usr/bin/env perl
use 5.012;
use Mail::Box::Manager;
use Format::Human::Bytes;

my $mailbox = shift || die "no mailbox";
my $mgr = Mail::Box::Manager->new;

my @open_options = (
    access   => 'r',
    extract  => 'LAZY'
);
my $folder = $mgr->open(folder => $mailbox, @open_options);

my $total_size = 0;
my $total_messages = 0;

$mailbox =~ s[/home/avar][~];

for my $message ($folder->messages) {
    my $subject = $message->head->get('subject') || '';
    my $from = $message->head->get('from')       || '';
    my $to = $message->head->get('to')           || '';
    my $list = $message->head->get('list-id')    || '';
    my $size = $message->size;
    my $size_human = Format::Human::Bytes::base2($size);

    printf "%10d\t%s\tsubject:<%s>\tfrom:<%s>\tto:<%s>\tlist:<%s>\tmailbox:<%s>\n", $size, $size_human, $subject, $from, $to, $list, $mailbox;

    # totals
    $total_size     += $size;
    $total_messages += 1;
}

printf "%10d\t%s\tmessages:<%d>\taverage message size:<%s>\tmailbox:<%s>\n",
    $total_size,
    Format::Human::Bytes::base2($total_size),
    $total_messages,
    Format::Human::Bytes::base2($total_size / ($total_messages||1)),
    $mailbox;

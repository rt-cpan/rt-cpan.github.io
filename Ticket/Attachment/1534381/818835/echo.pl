#!/usr/bin/perl
# $ perl ~/bk/perl/perl5-locale-po/obsolete-multiline-test.pl | msgattrib --set-obsolete
use strict;
use warnings;
use Data::Dumper;

# use lib qw(/home/my/bk/github/cosimo/perl5-locale-po/lib);
use Locale::PO;


my $po_file_in  = shift;    #'ja-JP/00a_preface.po';
my $po_file_out = shift;    #'ja-JP/00a_preface.po';

my $aref = Locale::PO->load_file_asarray($po_file_in);
Locale::PO->save_file_fromarray( $po_file_out, $aref );

exit 0;

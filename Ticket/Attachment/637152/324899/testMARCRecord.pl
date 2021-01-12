#!/usr/bin/perl

use strict;
use warnings;

# Koha modules used
use MARC::File::USMARC;
use MARC::File::XML;
use MARC::Record;
use MARC::Batch;
use MARC::Charset;
use C4::Charset;

use utf8;
use open qw( :std :utf8);
use Encode;


my ( $input_marc_file) = ('');

$|=1;


my $debug=$ENV{DEBUG};

my $batch;
my $fh = IO::File->new($ARGV[0]); # don't let MARC::Batch open the file, as it applies the ':utf8' IO layer
    $batch = MARC::Batch->new( 'USMARC', $fh );
$batch->warnings_off();
$batch->strict_off();
my $i=0;
my $commitnum = $commit ? $commit : 50;

RECORD: while (  ) {
    my $record;
    # get records
    eval { $record = $batch->next() };
    if ( $@ ) {
        print "Bad MARC record: skipped\n";
        next;
    }
    # skip if we get an empty record (that is MARC valid, but will result in AddBiblio failure
    last unless ( $record );
	my $record2=$record->clone;
	warn "Original :", $record->as_formatted;
	$record->insert_fields_ordered(MARC::Field->new('700','','',a=>"Billé",b=>'Louis'));
	warn "Modified :",$record->as_formatted;
    $i++;
}    

#!/usr/bin/perl

$| = 1;

use strict;
use warnings;

use OpenOffice::OODoc;

Read_ods_file('./OO.ods');

sub Read_ods_file {
     my($file) = @_;
     print "Open '$file' ...\n";
     my $doc = odfDocument(file => $file);

     for (my $i=0; $i<$doc->getTableList();$i++) {
          my $tbl = $doc->getTable($i);          
          print "Name of Sheet: ".$doc->tableName($tbl)."\n";
          for (my $row=0; $row<15; $row++) {
               my $found = 0; 
               for (my $col=0; $col<15; $col++) {
                    my $v = $doc->getCellValue($tbl, $row, $col);
                    $v = '' if !defined($v);
                    print "$v;";
                    $found++;
                } # for
                print "\n" if $found;
          } # for
     } # for
} # 

=pod

Output should be:

Open './OO.ods' ...
Name of Sheet: Tabelle1
Auto;Auto;1;;;;;;;;;;;;;;
Auto;Auto;2;;;;;;;;;;;;;;
Auto;Auto;3;;;;;;;;;;;;;;
Auto;Auto;4;;;;;;;;;;;;;;
Auto;Auto;5;;;;;;;;;;;;;;
Auto;Auto;6;;;;;;;;;;;;;;
Auto;Auto;7;;;;;;;;;;;;;;
Auto;Auto;8;;;;;;;;;;;;;;
Auto;Auto;9;;;;;;;;;;;;;;
Auto;Auto;10;;;;;;;;;;;;;;
Auto;Auto;11;;;;;;;;;;;;;;
Auto;Auto;12;;;;;;;;;;;;;;
Auto;Auto;13;;;;;;;;;;;;;;
Auto;Auto;14;;;;;;;;;;;;;;
Auto;Auto;15;;;;;;;;;;;;;;

But scripts output is:

Open './OO.ods' ...
Name of Sheet: Tabelle1
Auto;1;;;;;;;;;;;;;;
Auto;2;;;;;;;;;;;;;;
Auto;3;;;;;;;;;;;;;;
Auto;4;;;;;;;;;;;;;;
Auto;5;;;;;;;;;;;;;;
Auto;6;;;;;;;;;;;;;;
Auto;7;;;;;;;;;;;;;;
Auto;8;;;;;;;;;;;;;;
Auto;9;;;;;;;;;;;;;;
Auto;10;;;;;;;;;;;;;;
Auto;11;;;;;;;;;;;;;;
Auto;12;;;;;;;;;;;;;;
Auto;13;;;;;;;;;;;;;;
Auto;14;;;;;;;;;;;;;;
Auto;15;;;;;;;;;;;;;;

This is wrong!

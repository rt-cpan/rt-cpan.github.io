sub process_xlsx {
   $filename_proc = $_;
   msgprint( "filename_proc = $filename_proc\n","debug");
   my $excel = Spreadsheet::XLSX -> new ($filename_proc);

   foreach my $sheet (@{$excel -> {Worksheet}}) {
      msgprint("Came inside sheet\n","medium");
      $sheetName = $sheet->{Name};
      push @sheetnames_array, $sheetName;
      msgprint("#Worksheet $sheet: $sheetName \n","medium");
      msgprint("Sheet Name = $sheetName\n","medium");
      if(!(defined @sheet_to_process)) { $enable_sheet_process=1; }
      else {
        $enable_sheet_process=0;
        foreach $sheet_to_chk (@sheet_to_process) {
             msgprint("sheet_to_chk = $sheet_to_chk; sheet = $sheetName\n","high");
            if($sheetName =~ $sheet_to_chk) { $enable_sheet_process=1;}
        }
      }
      if($enable_sheet_process == 1) {
         print "This sheet will be converted to CSV\n;";
         msgprint("This sheet will be converted to CSV\n","medium");
         system("rm -rf work/$sheetName.csv");
         open(CSV_OUT, "> work/$sheetName.csv") or die ("ERROR: Could not create a work/$sheetName.csv for writing");
   
          $sheet -> {MaxRow} ||= $sheet -> {MinRow};
   
         foreach my $row ($sheet->{MinRow} .. $sheet->{MaxRow}) {
             $sheet -> {MaxCol} ||= $sheet -> {MinCol};
             foreach my $column ($sheet->{MinCol} .. $sheet->{MaxCol}) {
                 if (defined $sheet->{Cells}[$row][$column] and $sheet->{Cells}[$row][$column] ne "")
                 {
                     $cell_val_proc = $sheet->{Cells}[$row][$column]->Value;
                     $cell_val_proc =~ s/\n//g;
                     $cell_val_proc =~ s/\r//g;
                     $cell_val_proc =~ s/\&amp;/\&/;
                     $cell_val_proc =~ s/\&lt;/\</;
                     $cell_val_proc =~ s/\&gt;/\>/;

                     if(($cell_val_proc =~ /row r/) && ($cell_val_proc =~ /spans/)) {
                     $cell_val = "SPLITCHAR";
                     } else { $cell_val = $cell_val_proc . "SPLITCHAR"; }
                     print CSV_OUT "$cell_val";
                 } else {
                     print CSV_OUT "SPLITCHAR";
                 }
             }
                 print CSV_OUT "\n";
         }
         close(CSV_OUT);
      } #File proc required
   } #Per sheet proc
   
   msgprint("CSV Generation is done\n","high");
}

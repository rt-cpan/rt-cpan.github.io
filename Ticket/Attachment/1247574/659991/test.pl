use Spreadsheet::XLSX;

sub test
{
  my $workbook = Spreadsheet::XLSX->new('report.xlsx');

  for my $worksheet ( $workbook->worksheets() )
  {
    my ($row_min, $row_max) = $worksheet->row_range();
    my ($col_min, $col_max) = $worksheet->col_range();

    for my $row ($row_min .. $row_max) {
      for my $col ($col_min .. $col_max) {
	my $cell  = $worksheet->get_cell($row, $col);

	if (defined $cell && $cell ne "")
        {
	  print $cell->type() . "\t" . $cell->value() . "\n";
	}
      }
    }
  }
}

test();

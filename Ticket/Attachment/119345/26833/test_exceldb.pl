use DBI;
use Spreadsheet::WriteExcel::FromDB;
 	
  open(XLS,">test.xls") or die "cannot create\n";

#  my $dbh = DBI->connect("dbi:Oracle:host=10.80.0.75;sid=RTXV7V;port=1521", "SYSADM/ssv2003", '') || die "Cannot connect to the database: $DBI::errstr\n";
  my $dbh = DBI->connect("dbi:Oracle:host=10.80.0.75;sid=BSCSV7V;port=1521", "SYSADM/valid04", '') || die "Cannot connect to the database: $DBI::errstr\n";

#  my $ss = Spreadsheet::WriteExcel::FromDB->read($dbh,RTX_PART);
  my $ss = Spreadsheet::WriteExcel::FromDB->read($dbh,contract_all);
  #$ss->ignore_columns(qw/foo bar/); 
  # or
  $ss->include_columns(qw/co_id/); 

  $ss->restrict_rows('co_id < 256');

  print XLS $ss->as_xls;
  
  close(XLS);
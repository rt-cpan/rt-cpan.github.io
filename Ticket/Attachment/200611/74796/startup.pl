use Apache2::Status ();
use Apache::DBI ();
$Apache::DBI::DEBUG = 2;

## My Modules
use TEST::Apache::DBI ();

## Init code
our %db_attrs = (
    RaiseError         => 1,
    PrintError         => 0,
    Taint              => 1,
    AutoCommit         => 0,
    LongReadLen        => 50000,
    LongTruncOk        => 1,
    ShowErrorStatement => 1,
    ChopBlanks         => 1,
    FetchHashKeyName   => "NAME_lc",
);

Apache::DBI->connect_on_init("DBI:mysql:database=test", "test", undef, \%db_attrs);

1;

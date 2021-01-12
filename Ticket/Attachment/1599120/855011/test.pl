use DBI ':sql_types';
use File::Copy;
copy('Blank.mdb', 'Test.mdb');

my $MDB = DBI->connect("dbi:ODBC:DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=./Test.mdb");

my $val1 ="\4\0\0\0\4 \1\0\5\0\0\0\0\0\0\0\0\0\0A\0\0\300\@\0\0\300\@\0\0\0A\0\0\0A";
my $val2 ="\4\0\0\0\4 \1\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\300\@\0\0\0A\0\0\0A";
my $val3 ="\3\0\0\0\4 \1\0\4\0\0\0\0\0\0\0\0\0\0A\0\0\300\@\0\0\300\@\0\0\0A",
my $key0 ="DuctLoadFactorInsulationRValue0";
my $key1 ="DuctLoadFactorInsulationRValue1";

$sth = $MDB->prepare("UPDATE System SET $key0=?, $key1=?");
$sth->bind_param(1, undef, SQL_LONGVARBINARY);
$sth->bind_param(2, undef, SQL_LONGVARBINARY);
$sth->execute($val1, $val1);
$sth->execute($val2, $val2);
$sth->execute($val3, $val3);
$sth->execute($val1, $val3);
$sth->execute($val3, $val1);
$MDB->trace(4);
#Dies with any of these
$sth->execute($val1, $val2);
$sth->execute($val2, $val1);
$sth->execute($val2, $val3);
$sth->execute($val3, $val2);

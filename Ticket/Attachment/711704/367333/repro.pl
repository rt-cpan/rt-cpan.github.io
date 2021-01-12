use Data::Dumper;
use strict;
use DBI;
use utf8;
use Encode;
binmode STDOUT, ":utf8";
binmode STDIN, ":utf8";


    my ($host, $port, $database, $user, $password, $rise) = ('localhost','3306','flights','root','itsme');
    my $dsn = "DBI:mysql:host=$host;port=$port;".
              "database=$database;".
              "mysql_compression=1;".
              "mysql_client_found_rows=1;".
              "mysql_auto_reconnect=1;".
              "mysql_enable_utf8=1;";
    my $dbh = DBI->connect(
                            $dsn,
                            $user,
                            $password,
                            {
                              RaiseError => 1,
                            }
                          );                         
    $dbh->do("SET character_set_client     = utf8;");
    $dbh->do("SET character_set_connection = utf8;");
    $dbh->do("SET character_set_results    = utf8;");
    my $query = $dbh->prepare("SELECT * FROM countries");
    $query->execute();
    my $data = $query->fetchall_arrayref();
    foreach my $str (@$data)
    {
      foreach my $val (@$str)
      {
        print ("Value: $val, it is ".(utf8::is_utf8($val)?"":"non-")."utf8 string, and ".(utf8::valid($str)?"":"not")." valid<br>\n");
        Encode::_utf8_on($val);
        print ("Value: $val, it is ".(utf8::is_utf8($val)?"":"non-")."utf8 string, and ".(utf8::valid($str)?"":"not")." valid<br>\n");
      }
    }
    $query->finish();
    $dbh->disconnect();
    return $data;


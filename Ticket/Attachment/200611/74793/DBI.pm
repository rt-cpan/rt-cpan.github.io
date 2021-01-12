package TEST::Apache::DBI;

use strict;
use warnings FATAL => 'all';
use Carp;

use Data::Dumper;
use DBI;

use Apache2::RequestRec ();
use Apache2::RequestIO ();
use Apache2::Const -compile => qw(OK);

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

sub handler {
  my $r = shift;

  my $dbh = eval { DBI->connect('DBI:mysql:database=test', 'test', undef, \%db_attrs) };

  if ($@) {
    $r->print("Connect: $@\n");
  }
  else {
    $r->print("Connected\n");

    my $sth = $dbh->prepare("SELECT * FROM users");
    $sth->execute();
    while (my $hashref = $sth->fetchrow_hashref()) {
        $r->print(Dumper $hashref);  
    }

    eval {
        $dbh->do("INSERT INTO users (username, password) VALUES (?,?)", \%db_attrs, (time(), time()));
    };
    if ($@) {
      $dbh->rollback();
    }
    else {
      $dbh->commit();
    }

    my $rc = $dbh->disconnect();
    unless ($rc) {
      $r->print("RC: $rc\n");
    }
    else {
      $r->print("Disconnected\n");
    }
  }

  return Apache2::Const::OK;
}

#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;
use Encode;

sub main {
    my $dbh = DBI->connect(
        'dbi:Oracle:',
        'usr/pwd@db',
        '',
        { PrintError => 0, AutoCommit => 0, RaiseError => 1, },
        );
    print {*STDERR} 'Connected !', "\n";
    $dbh->do(q(alter session set nls_territory = 'GERMANY'));
    my $sql = <<'END_SQL';
SELECT  ltrim(rtrim(to_char(0, 'L')))
FROM    dual
END_SQL
    my $sth = $dbh->prepare($sql);
    $sth->execute;
    my ($val);
    $sth->bind_columns(\($val));
    while ($sth->fetch) {
        print {*STDERR} 'val=[', $val, '] len=', length($val), "\n";
    }
    if (Encode::is_utf8($val)) {
        print {*STDERR} ' utf8 is on', "\n";
    } else {
        print {*STDERR} ' utf8 is off', "\n";
    }
    $sth->finish;
    $sql = <<'END_SQL';
declare
    l_ret       varchar2(10);
begin
    select  ltrim(rtrim(to_char(0, 'L')))
    into    l_ret
    from    dual;
    --
    :ret := l_ret;
end;
END_SQL
    undef $val;
    $sth = $dbh->prepare($sql);
    $sth->bind_param_inout(':ret', \$val, 100);
    $sth->execute;
    print {*STDERR} 'val=[', $val, '] len=', length($val), "\n";
    if (Encode::is_utf8($val)) {
        print {*STDERR} ' utf8 is on', "\n";
    } else {
        print {*STDERR} ' utf8 is off', "\n";
    }
    $dbh->disconnect;
    return 0;
}

exit main();

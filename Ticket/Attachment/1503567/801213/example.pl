#!/usr/bin/env perl

use Data::Dumper;
use Modern::Perl '2014';
use Net::OpenSSH;
use Net::SFTP::Foreign;
use IO::Pty;

my @hosts = qw/
  2102310yjv10f1000181.company.lom
/;

my %ssh;

for my $host (@hosts) {
  $ssh{$host} = Net::OpenSSH->new($host,
                                  user => 'root',
                                  password => 'secret',
                                  async => 1,
  );

}

for my $host (@hosts) {
   my $status = $ssh{$host}->system("top");
   say $status;
}

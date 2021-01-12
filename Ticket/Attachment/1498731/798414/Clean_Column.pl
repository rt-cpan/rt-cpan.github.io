#!/usr/bin/perl
####################################################################
#   This script is used to clean up unused columns and tables      #
#    From PIDB Database as per  the new schema as well as PST-1178 #
####################################################################

use warnings;
use strict;
use DBIx::Connector;
use warnings;
use strict;


my $getconnection = sub {
my $dbh = undef;
eval {
	$dbh = DBIx::Connector->new(
		'DBI:mysql:PIDB;host=127.0.0.1', 'psmart', 'psmart650',{RaiseError => 1,PrintError=> 0})
		|| die "Connection Error $!";
};
if ($@){
	print "Error Connecting to MYSQL $@ \n";
	return undef;
}
return $dbh;
};

my $runQuery = sub {
	my $query = shift;
	my $sth;
eval {
 	$getconnection->()->run( ping => sub { $sth = $_->prepare($query);$sth->execute; })|| die "cound not execute query";
};
if ($@){
	#print "Error in Executing Query....$sth->err()  \n";
	return undef;
}
return $sth;
};


sub clean_cmd_column {
	my $cmdtable = shift;
	my $sth = $runQuery->("alter table $cmdtable drop column GENDATE, drop column GENTIME");
	if (!$sth){
	print "$cmdtable is latest\n";
	}
	else
	{
	print "$cmdtable has been altered\n";
	}

}



#####################################################
#Main Function to get all  the table list form PIDB #
#                                                   #
#####################################################
my $sth = $runQuery->("show tables");
                        while ( my $row=$sth->fetchrow_array) {
                          if ($row =~ m/CMD_.*/) {
					clean_cmd_column($row);
                           }
			}
$getconnection->()->disconnect_on_destroy();

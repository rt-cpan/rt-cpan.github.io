package DBIx::Class::Schema::Loader::DBI::Pg;

use strict;
use warnings;
use base 'DBIx::Class::Schema::Loader::DBI';
use Carp::Clan qw/^DBIx::Class/;
use Class::C3;

our $VERSION = '0.04004';

=head1 NAME

DBIx::Class::Schema::Loader::DBI::Pg - DBIx::Class::Schema::Loader::DBI
PostgreSQL Implementation.

=head1 SYNOPSIS

  package My::Schema;
  use base qw/DBIx::Class::Schema::Loader/;

  __PACKAGE__->loader_options( debug => 1 );

  1;

=head1 DESCRIPTION

See L<DBIx::Class::Schema::Loader::Base>.

=cut

sub _setup {
	my $self = shift;

	$self->next::method(@_);
	$self->{db_schema} ||= 'public';
	$self->{multi_db_schema} ||= undef;
	$self->{multi_db_schema} = 1 if ( $ENV{PG_AUTOLOAD_MULI_SCHEMA} );
}

sub _tables_list {
	my $self = shift;

	my @tables;
	my $dbh = $self->schema->storage->dbh;
	if ( !defined $self->{multi_db_schema} ) {
		@tables = $dbh->tables( undef, $self->db_schema, '%', '%' );
	}
	else {
		my @t = $dbh->tables( undef, undef, '%', '%' );
		foreach (@t) {
			next if ( $_ =~ /^pg_catalog/ );
			next if ( $_ =~ /^information/ );
			push @tables, $_;
		}
	}

	s/\Q$self->{_quoter}\E//g for @tables;
	if ( !defined $self->{multi_db_schema} ) {
		s/^.*\Q$self->{_namesep}\E// for @tables;
	}

	return @tables;
}

sub _table_columns {
	my ( $self, $table ) = @_;

	my $dbh = $self->schema->storage->dbh;
	if ( !defined $self->{multi_db_schema} ) {
		if ( $self->{db_schema} ) {
			$table = $self->{db_schema} . $self->{_namesep} . $table;
		}
	}

	my $sth =
	  $dbh->prepare(
		$self->schema->storage->sql_maker->select( $table, undef, \'1 = 0' ) );

	$sth->execute;
	my $retval = \@{ $sth->{NAME_lc} };
	$sth->finish;

	$retval;
}

sub _table_pk_info {
	my ( $self, $table ) = @_;
	my @primary;
	my $dbh = $self->schema->storage->dbh;
	if ( !defined $self->{multi_db_schema} ) {
		@primary =
		  map { lc } $dbh->primary_key( '', $self->db_schema, $table );
	}
	else {
		my ( $s, $t ) = split( /\./, $table );
		@primary = map { lc } $dbh->primary_key( '', $s, $t );
	}
	s/\Q$self->{_quoter}\E//g for @primary;

	return \@primary;
}

sub _table_fk_info {
	my ( $self, $table ) = @_;
	my ( $s, $t ) = split( /\./, $table );
	my $dbh = $self->schema->storage->dbh;
	my $sth;
	if ( !defined $self->{multi_db_schema} ) {
		my $sth =
		  $dbh->foreign_key_info( '', '', '', '', $self->db_schema, $table );
	}
	else {
		$sth = $dbh->foreign_key_info( '', '', '', '', $s, $t );
	}
	return [] if !$sth;

	my %rels;

	my $i = 1;
	while ( my $raw_rel = $sth->fetchrow_arrayref ) {
		my $uk_tbl;
		if ( !defined $self->{multi_db_schema} ) {
			$uk_tbl = $raw_rel->[2];
		}
		else {
			$uk_tbl = $raw_rel->[1] . '.' . $raw_rel->[2];
		}
		my $uk_col = lc $raw_rel->[3];
		my $fk_col = lc $raw_rel->[7];
		my $relid  = ( $raw_rel->[11] || ( "__dcsld__" . $i++ ) );
		$uk_tbl =~ s/\Q$self->{_quoter}\E//g;
		$uk_col =~ s/\Q$self->{_quoter}\E//g;
		$fk_col =~ s/\Q$self->{_quoter}\E//g;
		$relid  =~ s/\Q$self->{_quoter}\E//g;
		$rels{$relid}->{tbl} = $uk_tbl;
		$rels{$relid}->{cols}->{$uk_col} = $fk_col;
	}
	$sth->finish;

	my @rels;
	foreach my $relid ( keys %rels ) {
		push(
			@rels,
			{
				remote_columns => [ keys %{ $rels{$relid}->{cols} } ],
				local_columns  => [ values %{ $rels{$relid}->{cols} } ],
				remote_table   => $rels{$relid}->{tbl},
			}
		);
	}

	return \@rels;
}

sub _table_uniq_info {
	my ( $self, $table ) = @_;

	# Use the default support if available
	return $self->next::method($table)
	  if $DBD::Pg::VERSION >= 1.50;

	my @uniqs;
	my $dbh = $self->schema->storage->dbh;

	# Most of the SQL here is mostly based on
	#   Rose::DB::Object::Metadata::Auto::Pg, after some prodding from
	#   John Siracusa to use his superior SQL code :)

	my $attr_sth = $self->{_cache}->{pg_attr_sth} ||= $dbh->prepare(
		q{SELECT attname FROM pg_catalog.pg_attribute
        WHERE attrelid = ? AND attnum = ?}
	);

	my $uniq_sth = $self->{_cache}->{pg_uniq_sth} ||= $dbh->prepare(
		q{SELECT x.indrelid, i.relname, x.indkey
        FROM
          pg_catalog.pg_index x
          JOIN pg_catalog.pg_class c ON c.oid = x.indrelid
          JOIN pg_catalog.pg_class i ON i.oid = x.indexrelid
          JOIN pg_catalog.pg_constraint con ON con.conname = i.relname
          LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
        WHERE
          x.indisunique = 't' AND
          c.relkind     = 'r' AND
          i.relkind     = 'i' AND
          con.contype   = 'u' AND
          n.nspname     = ? AND
          c.relname     = ?}
	);
	if ( !defined $self->{multi_db_schema} ) {
		$uniq_sth->execute( $self->db_schema, $table );
	}
	else {
		my ( $s, $t ) = split( /\./, $table );
		$uniq_sth->execute( $s, $t );
	}
	while ( my $row = $uniq_sth->fetchrow_arrayref ) {
		my ( $tableid, $indexname, $col_nums ) = @$row;
		$col_nums =~ s/^\s+//;
		my @col_nums = split( /\s+/, $col_nums );
		my @col_names;

		foreach (@col_nums) {
			$attr_sth->execute( $tableid, $_ );
			my $name_aref = $attr_sth->fetchrow_arrayref;
			push( @col_names, $name_aref->[0] ) if $name_aref;
		}

		if ( !@col_names ) {
			warn "Failed to parse UNIQUE constraint $indexname on $table";
		}
		else {
			push( @uniqs, [ $indexname => \@col_names ] );
		}
	}

	return \@uniqs;
}

=head1 SEE ALSO

L<DBIx::Class::Schema::Loader>, L<DBIx::Class::Schema::Loader::Base>,
L<DBIx::Class::Schema::Loader::DBI>

=cut

1;

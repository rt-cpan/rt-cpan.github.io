# Shamelessly copied from DBIx::ProcedureCall::Oracle and then support
# for named parameters, boolean and cursors removed.
package DBIx::ProcedureCall::ODBC;

use strict;
use warnings;

use Carp qw(croak);

our $VERSION = '0.10';

our $ORA22905;

sub __run_procedure{
	shift;
	my $dbh = shift;
	my $name = shift;
	my $attr = shift;
	my $params;

	# if there is one more arg and it is a hashref, then we use named parameters
	if (@_ == 1 and ref $_[0] eq 'HASH') {
        croak(__PACKAGE__ . " does not support named parameters");
	}
	# otherwise they are positional parameters
	my $sql = "{call $name";
	if (@_){
        $sql .= '(' . join (',' , map ({ '?'} @_  )) . ')';
	}
	$sql .= '}';
	# prepare
	$sql = $attr->{cached} ? $dbh->prepare_cached($sql)
		: $dbh->prepare($sql);
	# bind
	DBIx::ProcedureCall::__bind_params($sql, 1, \@_);
	# execute
	$sql->execute;
}

sub __run_function{
	shift;
	my $dbh = shift;
	my $name = shift;
	my $attr = shift;
	my $params;

#####	# any fetch implies cursor (unless it is a table function)
#####	if ($attr->{'fetch'}) {
#####        croak(__PACKAGE__ . ' does not support the returning of a cursor');
#####	}
	# if there is one more arg and it is a hashref , then we use with named parameters
	if (@_ == 1 and ref $_[0] eq 'HASH') {
        croak(__PACKAGE__ . " does not support named parameters");
	}
	# otherwise they are positional parameters

	my $sql;

    $sql = "{? = call $name";
    if (@_){
        $sql .= '(' . join (',' , map ({ '?'} @_  )) . ')';
    }
    $sql .= '}';

	# prepare
	$sql = $attr->{cached} ? $dbh->prepare_cached($sql)
		: $dbh->prepare($sql);

	# bind
	my $i = 1;
	my $r;

    $sql->bind_param_inout($i++, \$r, 100);
    DBIx::ProcedureCall::__bind_params($sql, $i, \@_);

	$sql->execute;
	return ($sql, $r);
}


sub __close{
	shift;
	my $sth = shift;
    # there is nothing to close as ODBC does not support returning cursors
    # like DBD::Oracle does
}



1;
__END__


=head1 NAME

DBIx::ProcedureCall::ODBC - ODBC driver for DBIx::ProcedureCall

=head1 DESCRIPTION

This is an internal module used by DBIx::ProcedureCall. You do not need
to access it directly. However, you should read the following
documentation, because it explains how to use DBIx::ProcedureCall
with ODBC databases.

=head2 Procedures and functions

DBIx::ProcedureCall needs to know if you are about to call a function
or a procedure (because the SQL is different).  You have to make sure
you call the wrapper subroutines in the right context (or you can
optionally declare the correct type, see below)

You have to call procedures in void context.

	# works
	dbms_random_initialize($conn, 12345);
	# fails
	print dbms_random_initialize($conn, 12345);

You have to call functions in non-void context.

	# works
	print sysdate($conn);
	# fails
	sysdate($conn);

If you try to call a function as a procedure, you will get
a database error.

If you do not want to rely on this mechanism, you can
declare the correct type using the attributes :procedure
and :function:

	use DBIx::ProcedureCall qw[
		sysdate:function
		dbms_random.initialize:procedure
		];

If you use these attributes, the calling context will be
ignored and the call will be dispatched according to
your declaration.

NOTE: in ODBC there are no functions as such. Everything is a procedure
but some procedures return a value and others do not. You should class
ODBC procedures which return a value as "functions" in DBIx::ProcedureCall
and ODBC procedures which do not return a value as "procedures".

=head2 Returning result sets

This package does not support returning result-sets like DBD::Oracle
does with a reference cursor.

=head2 Named Parameters

This package does not support named parameters.

=head1 SEE ALSO

L<DBIx::ProcedureCall> for information about this module that is not
ODBC-specific.

L<DBD::ODBC>

=head1 AUTHOR

Martin J Evans, E<lt>mjevans@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2011 by Martin J. Evans

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut



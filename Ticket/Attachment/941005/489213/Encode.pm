#========================================================================
#
# LaTeX::Encode
#
# DESCRIPTION
#   Provides a function to encode text that contains characters
#   special to LaTeX.
#
# AUTHOR
#   Andrew Ford <a.ford@ford-mason.co.uk>
#
# COPYRIGHT
#   Copyright (C) 2007 Andrew Ford.   All Rights Reserved.
#
#   This module is free software; you can redistribute it and/or
#   modify it under the same terms as Perl itself.
#
#   $Id: Encode.pm 10 2007-10-03 11:00:21Z andrew $
#========================================================================

package LaTeX::Encode;

use strict;
use warnings;

use Exporter;
use base qw(Exporter);
use LaTeX::Encode::EncodingTable;

our $VERSION = 0.04;
our @EXPORT  = qw(latex_encode);


# Encode text with characters special to LaTeX

sub latex_encode {
    my $text = shift;
    my $options = ref $_[0] ? shift : { @_ };
    my $exceptions   = $options->{except};
    my $iquotes      = $options->{iquotes};
    my $use_textcomp = (!exists($options->{use_textcomp}) || $options->{use_textcomp});
    my $math         = ( exists($options->{math}) && $options->{math} );

    # If a list of exception characters was specified then we replace
    # those characters in the text string with something that is not
    # going to match the encoding regular expression.  The encoding we
    # use is a hex 01 byte followed by four hexadecimal digits

    if ($exceptions) {
        $exceptions =~ s{ \\ }{\\\\}gx;
        $text =~ s{ ([\x{01}$exceptions]) }
                  { sprintf("\x{01}%04x", ord($1)); }gxe;
    }

    # Deal with "intelligent quotes".  This can be done separately
    # from the rest of the encoding as the characters ` and ' are not
    # encoded.

    if ($iquotes) {

        # A single or double quote before a word character, preceded
        # by start of line, whitespace or punctuation gets converted
        # to "`" or "``" respectively.

        $text =~ s{ ( ^ | [\s\p{IsPunct}] )( ['"] ) (?= \w ) }
                  { $2 eq '"' ? "$1``" : "$1`" }mgxe;

        # A double quote preceded by a word or punctuation character
        # and followed by whitespace or end of line gets converted to
        # "''".  (Final single quotes are represented by themselves so
        # we don't need to worry about those.)

        $text =~ s{ (?<= [\w\p{IsPunct}] ) " (?= \s | $ ) }
                  { "''" }mgxe
    }
    
    my $re = $math ? $encoded_char_re_math : $encoded_char_re;
    my %le = $math ? %latex_encoding_math  : %latex_encoding;

    # Replace any characters that need encoding
      $text =~ s{ ($re)([\sa-zA-Z]?)}
                 { my $encoded  = $le{$1};
                   my $nextchar = $2;
                   my $sepchars = "";
                   if ($nextchar and substr($encoded, -1) =~ /[a-zA-Z]/) {
                       $sepchars = ($nextchar =~ /\s/) ? '{}' : ' ';
                   }
                   "$encoded$sepchars$nextchar" }gxe;
               #            $text = join("\n", map{ defined $latex_encoding{$_} ? $latex_encoding{$_} :
               # $_ } split //,$text);
    # If the caller specified exceptions then we need to decode them

    if ($exceptions) {
        $text =~ s{ \x{01} ([0-9a-f]{4}) }{ chr(hex($1)) }gxe;
    }

    return $text;
}

1;

__END__

=head1 NAME

LaTeX::Encode - encode characters for LaTeX formatting

=head1 SYNOPSIS

  use LaTeX::Encode;

  $latex = latex_encode($text, %options);

=head1 VERSION

This manual page describes version 0.04 of the C<LaTeX::Encode> module.


=head1 DESCRIPTION

This module provides a function to encode text that is to be formatted
with LaTeX.  It encodes characters that are special to LaTeX or that
are represented in LaTeX by LaTeX commands.

The special characters are: C<\> (command character), C<{> (open
group), C<}> (end group), C<&> (table column separator), C<#>
(parameter specifier), C<%> (comment character), C<_> (subscript),
C<^> (superscript), C<~> (non-breakable space), C<$> (mathematics mode).

Note that some of the LaTeX commands for characters are defined in the
LaTeX C<textcomp> package.  If your text includes such characters, you
will need to include the following lines in the preamble to your LaTeX
document.

    \usepackage[T1]{fontenc}
    \usepackage{textcomp}

The function is useful for encoding data that is interpolated into
LaTeX document templates, say with C<Template::Plugin::Latex>
(shameless plug!).


=head1 SUBROUTINES/METHODS

=over 4

=item C<latex_encode($text, %options)>

Encodes the specified text such that it is suitable for processing
with LaTeX.  The behaviour of the filter is modified by the options:

=over 4

=item C<except>

Lists the characters that should be excluded from encoding.  By
default no special characters are excluded, but it may be useful to
specify C<except = "\\{}"> to allow the input string to contain LaTeX
commands such as C<"this is \\textbf{bold} text"> (the doubled
backslashes in the strings represent Perl escapes, and will be
evaluated to single backslashes).

=item C<math>

If true, then a math environment is assumed.

=item C<iquotes>

If true then single or double quotes around words will be changed to
LaTeX single or double quotes; double quotes around a phrase will be
converted to "``" and "''" and single quotes to "`" and "'".  This is
sometimes called "intelligent quotes"

=item C<use_textcomp>

By default the C<latex_encode> filter will encode characters with the
encodings provided by the C<textcomp> LaTeX package (for example the
Pounds Sterling symbol is encoded as C<\\textsterling{}>).  Setting
C<use_textcomp = 0> turns off these encodings.  NOT YET IMPLEMENTED

=back

=back


=head1 EXAMPLES

The following snippet shows how data from a database can be encoded
and inserted into a LaTeX table, the source of which is generated with
C<LaTeX::Table>.

    my $sth = $dbh->prepare('select col1, col2, col3 from table where $expr');
    $sth->execute;
    while (my $href = $sth->fetchrow_hashref) {
        my @row;
        foreach my $col (qw(col1 col2 col3)) {
            push(@row, latex_encode($href->{$col}));
        }
        push @data, \@row;
    }

    my $headings = [ [ 'Col1', 'Col2', 'Col3' ] ];

    my $table = LaTeX::Table->new( { caption => 'My caption',
                                     label   => 'table:caption',
                                     type    => 'xtab',
                                     header  => $header,
                                     data    => \@data } );

    my $table_text = $table->generate_string;    

Now C<$table_text> can be interpolated into a LaTeX document template.


=head1 DIAGNOSTICS

None.  You could probably break the C<latex_encode> function by
passing it an array reference as the options, but there are no checks
for that.

=head1 CONFIGURATION AND ENVIRONMENT

Not applicable.


=head1 DEPENDENCIES

The C<HTML::Entities> and C<Pod::LaTeX> modules were used for building
the encoding table in C<LaTeX::Encode::EncodingTable>, but this is not
rebuilt at installation time.  The C<LaTeX::Driver> module is used for
formatting the character encodings reference document.

=head1 INCOMPATIBILITIES

None known.

=head1 BUGS AND LIMITATIONS

Not all LaTeX special characters are included in the encoding tables
(more may be added when I track down the definitions).

The C<use_textcomp> option is not implemented.

=head1 AUTHOR

Andrew Ford E<lt>a.ford@ford-mason.co.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2007 Andrew Ford.  All Rights Reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

This software is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=head1 SEE ALSO

L<Template::Plugin::Latex>

=cut

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# End:
#
# vim: expandtab shiftwidth=4:

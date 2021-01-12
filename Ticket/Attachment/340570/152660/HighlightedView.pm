package SVN::Web::HighlightedView;

use strict;
use warnings;
use Syntax::Highlight::Engine::Kate;

use base 'SVN::Web::action';

our $VERSION = 0.1;

# If a file has a svn:mime-type set to one of the following
# then the respective highlighting scheme is applied.
# Else the type is guessed based on the filename.
my %highlighters = (
    'text/perl'          => 'Perl',
    'text/html'          => 'HTML',
    'application/x-tex'  => 'LaTeX',
);

#S::H::E::K category vs css class mapping
my %ft = (
    Alert           => 'hlvAlert',
    BaseN           => 'hlvBaseN',
    BString         => 'hlvBString',
    Char            => 'hlvChar',
    Comment         => 'hlvComment',
    DataType        => 'hlvDataType',
    DecVal          => 'hlvDecVal',
    Error           => 'hlvError',
    Float           => 'hlvFloat',
    Function        => 'hlvFunction',
    IString         => 'hlvIString',
    Keyword         => 'hlvKeyword',
    Normal          => '',
    Operator        => 'hlvOperator',
    Others          => 'hlvOthers',
    RegionMarker    => 'hlvRegionMarker',
    Reserved        => 'hlvReserved',
    String          => 'hlvString',
    Variable        => 'hlvVariable',
    Warning         => 'hlvWarning',
);
my $hl = new Syntax::Highlight::Engine::Kate(
    format_table => {
        map {
            $_ => ($ft{$_} ? ["<span class=\"$ft{$_}\">","</span>"] : ["",""])
        } keys(%ft)
    },
    substitutions => {
        "<"  => "&lt;",
        ">"  => "&gt;",
        "&"  => "&amp;",
        "\t" => "&nbsp;"x4,# which is the correct value
    },
);

sub _log {
    my($self, $paths, $rev, $author, $date, $msg, $pool) = @_;
    return unless $rev > 0;
    return {
        rev    => $rev,
        author => $author,
        date   => $self->format_svn_timestamp($date),
        msg    => $msg
    };
}

sub cache_key {
    my $self = shift;
    my $path = $self->{path};
    my(undef, undef, $act_rev, $head) = $self->get_revs();
    return "$act_rev:$head:$path";
}

sub run {
    my $self = shift;
    my $ctx  = $self->{repos}{client};
    my $ra   = $self->{repos}{ra};
    my $uri  = $self->{repos}{uri};
    my $path = $self->{path};

    my($exp_rev, $yng_rev, $act_rev, $head) = $self->get_revs();
    my $rev = $act_rev;

    # Get the log for this revision of the file
    $ra->get_log(
        [$path], $rev, $rev, 1, 1, 1,
        sub {
            $self->{REV} = $self->_log(@_)
        }
    );

    # Get the text for this revision of the file
    my($fh, $fc) = (undef, '');
    open($fh, '>', \$fc);
    $ctx->cat($fh, $uri . $path, $rev);
    close($fc);

    my $mime_type;
    my $syntax;
    my $props = $ctx->propget('svn:mime-type', $uri . $path, $rev, 0);
    if(exists $props->{$uri . $path}) {
        $mime_type = $props->{$uri . $path};
        $syntax = $highlighters{$mime_type};
    } else {
        $mime_type = 'text/plain';
    }
    $syntax=$hl->languagePropose($path) unless $syntax;
       
    my $highlighted;
    if ($syntax) {
        $hl->language($syntax);

        #do the highlighting
        my @lines = split "\n",$hl->highlightText($fc);
        #add line numbers
        my $line_number = 1;
        my $max_space = length($#lines) + 1;
        @lines = map { '<span class="LineNumber">'.('&nbsp;' x ($max_space - length($line_number))) . $line_number++ . '</span>&nbsp;' . $_ } @lines;
        $highlighted=join("\n",@lines);
    }
    
    return {
        template => 'highlightedview',
        data     => {
            context      => 'file',
            syntax       => $hl->language(),
            rev          => $act_rev,
            youngest_rev => $yng_rev,
            at_head      => $head,
            mimetype     => $mime_type,
            file         => $fc,
            highlighted  => $highlighted,
            %{$self->{REV}},
        }
    };
}

1;

=head1 NAME

SVN::Web::HighlightedView - SVN::Web action to view a file with syntax highlighting.

=head1 SYNOPSIS

In F<config.yaml>

  actions:
    ...
    hightlightedview:
      class: SVN::Web::HighlightedView
      action_menu:
        show:
          - file
        link_text: (view file with syntax highlighting)
    ...

It is also possible to replace the normal view action

  actions:
    ...
    view:
      class: SVN::Web::HighlightedView
      action_menu:
        show:
          - file
        link_text: (view file)


=head1 DESCRIPTION

Shows a specific revision of a file in the Subversion repository with syntax highlighting.
Includes the commit information for that file.

=head1 OPTIONS

=over 8

=item rev

The revision of the file to show.  Defaults to the repository's
youngest revision.

If this is not an interesting revision for this file, the repository history
is searched to find the youngest interesting revision for this file that is
less than C<rev>.

=back

=head1 TEMPLATE VARIABLES

=over 8

=item at_head

A boolean value, indicating whether the user is currently viewing the
HEAD of the file in the repository.

=item context

Always C<file>.

=item rev

The revision that has been returned.  This is not necessarily the same
as the C<rev> option passed to the action.  If the C<rev> passed to the
action is not interesting (i.e., there were no changes to the file at that
revision) then the file's history is searched backwards to find the next
oldest interesting revision.

=item youngest_rev

The youngest interesting revision of the file.

=item mimetype

The file's MIME type, extracted from the file's C<svn:mime-type>
property.  If this is not set then C<text/plain> is used.

=item file

The contents of the file.

=item author

The revision's author.

=item date

The date the revision was committed, formatted according to
L<SVN::Web/"Time and date formatting">.

=item msg

The revision's commit message.

=back

=head1 EXCEPTIONS

None.

=head1 SEE ALSO

=over 8

=item L<Syntax::Highlight::Engine::Kate>

=back

=head1 COPYRIGHT

Copyright 2003-2004 by Chia-liang Kao C<< <clkao@clkao.org> >>.

Copyright 2005-2007 by Nik Clayton C<< <nik@FreeBSD.org> >>.

Copyright 2007 by Daniel Schröer C<< <daniel@daimla1.de> >>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

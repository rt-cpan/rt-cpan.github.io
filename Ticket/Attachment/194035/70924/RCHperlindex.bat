@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl
#line 15
    eval 'exec perl -S $0 "$@"'
	if 0;
#                              -*- Mode: Perl -*-
# Author          : Ulrich Pfeifer
# Created On      : Mon Jan 22 13:00:41 1996
# Last Modified On: Sun Sep 18 18:47:45 2005
# Language        : Perl
# Update Count    : 316
# Status          : Unknown, Use with caution!
#
# (C) Copyright 1996-2005, Ulrich Pfeifer, all rights reserved.
# This file is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.
#
#
# %SEEN is used to store the absolute pathes to files which have been
#       indexed. Probably this could be replaced by %FN.
#
# %FN   $FN{'last'}    greatest documentid
#       $FN{$did}      a pair of $mtf and $filename where $mtf is the
#                      number of occurances of the most frequent word in
#                      the document with number $did.
#
# %IDF  $IDF{'*all*'}  number of documents (essentially the same as
#                      $FN{'last'})
#       $IDF{$word}    number of documents containing $word
#
# %IF   $IF{$word}     list of pairs ($docid,$tf) where $docid is
#                      the number of a document containing $word $tf
#

#############################################
# RCH hacked it to work on MS Windows
# using insights from perldoc.bat
# 2005-12-20 22:20
use Fcntl;
use less 'time';
use Getopt::Long;
use File::Basename;
use Text::English;
use Config;
#############################################
# RCH hack
require Pod::Text; import Pod::Text;


# NDBM_File as LAST resort
BEGIN { @AnyDBM_File::ISA = qw(DB_File GDBM_File SDBM_File ODBM_File NDBM_File) }
use AnyDBM_File;

$p          = 'w'; # compressed int patch available
$nroff      = '';
$man1direxp = '';
$man3direxp = '';
$IDIR       = '';
$prefix     = '/tmp/.ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZpErLZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZperl';

$pager= $Config{'pager'};
if ($Config{'osname'} eq 'hpux') {
  $pager= "col | $pager";
}
if (exists $ENV{PAGER}) {
  $pager=$ENV{PAGER}
}
$stemmer = \&Text::English::stem;

$opt_index   = '';                # make perl -w happy
$opt_menu    = 1;
$opt_maxhits = 15;

#############################################
# RCH hack
$opt_cbreak  = 0;#RCH edits =1 to =0, which is same as -nocbreak
&GetOptions(
            'index',
            'cbreak!',
            'maxhits=i',
            'menu!',
            'verbose',
            'dict:i',
            'idir=s',
            ) || die "Usage: $0 [-index] [words ...]\n";

if (defined $opt_idir) {
    $IDIR = $opt_idir;          # avoid to many changes below.
}

if (defined $opt_dict) {
    $opt_dict ||= 100;
}

if ($opt_index) {
    &initstop;

    # check whether we can use Pod::Text to extract POD
    my $PodText = 0;
    eval {
      require Pod::Text;
      print "Using Pod::Text\n";
      $PodText = 1;
    };

    tie (%IF,   AnyDBM_File, "$IDIR/index_if",   O_CREAT|O_RDWR, 0644)
        or die "Could not tie $IDIR/index_if: $!\n";
    tie (%IDF,  AnyDBM_File, "$IDIR/index_idf",  O_CREAT|O_RDWR, 0644)
        or die "Could not tie $IDIR/index_idf: $!\n";
    tie (%SEEN, AnyDBM_File, "$IDIR/index_seen", O_CREAT|O_RDWR, 0644)
        or die "Could not tie $IDIR/index_seen: $!\n";
    tie (%FN,   AnyDBM_File, "$IDIR/index_fn",   O_CREAT|O_RDWR, 0644)
        or die "Could not tie $IDIR/index_fn: $!\n";

    require "find.pl";

    unless (@ARGV) {            # breaks compatibility :-(
        my %seen;
        my @perllib = grep(length && -d && !$seen{$_}++,
            @Config{qw(installprivlib installarchlib installsitelib installvendorlib installscript installsitearch)});

        for $dir (@perllib) {
            print "Scanning $dir ... \n";
            if (-l $dir) { # debian symlinks installarchlib but we do not want to follow links in general
               my $target = readlink $dir;
               $dir =~ s:[^/]+$:$target:;
            }
            &find($dir);
        }
    }
    for $name (@ARGV) {
        my $fns = $name;
        $fns =~ s:\Q$prefix/::;
        next if $SEEN{$fns};
        next unless -f $name;
        if ($name !~ /(~|,v)$/) {
            $did = $FN{'last'}++;
            $SEEN{$fns} = &index($name, $fns, $did);
        }
    }
    untie %IF;
    untie %IDF;
    untie %FN;
    untie %SEEN;
} elsif ($opt_dict) {
    tie (%IDF,  AnyDBM_File, "$IDIR/index_idf",  O_RDONLY, 0644)
        or die "Could not tie $IDIR/index_idf: $!\n".
            "Did you run '$0 -index'?\n";
    while (($key,$val) = each %IDF) {
        printf "%-20s %d\n", $key, $val if $val >= $opt_dict;
    }
    untie %IDF;
} else {
    tie (%IF,   AnyDBM_File, "$IDIR/index_if",   O_RDONLY, 0644)
        or die "Could not tie $IDIR/index_if: $!\n".
            "Did you run '$0 -index'?\n";
    tie (%IDF,  AnyDBM_File, "$IDIR/index_idf",   O_RDONLY, 0644)
        or die "Could not tie $IDIR/index_idf: $!\n";
    tie (%FN,   AnyDBM_File, "$IDIR/index_fn",   O_RDONLY, 0644)
        or die "Could not tie $IDIR/index_fn: $!\n";
    &search(@ARGV);
    untie %IF;
    untie %IDF;
    untie %FN;
    untie %SEEN;
}


sub wanted {
    my $fns = $name;

    if ($name eq $man3direxp) {
        $prune = 1;
    }
    $fns =~ s:\Q$prefix/::;
    return if $SEEN{$fns};
    return unless -f $_;
    if ($name =~ /man|bin|\.(pod|pm)$/) {
        if (!/(~|,v)$/) {
            $did = $FN{'last'}++;
            $SEEN{$fns} = &index($name, $fns, $did);
        }
    }
}


sub index {
    my $fn  = shift;
    my $fns = shift;
    my $did = shift;
    my %tf;
    my $maxtf = 0;
    my $pod = ($fns =~ /\.pod|man/);

    if($PodText) {
      my $result;
      my $parser = Pod::Text->new(sentence => 0, width => 78);
      my $tmpfile = "$IDIR/tmppod.txt";
      $parser->parse_from_file($fn, $tmpfile);
      open (IN, "<$tmpfile") || warn "Could not open $fn: $!\n", return (0);
      while ($line = <IN>) {
        for $word (&normalize($result)) {
            next if $stop{$word};
            $tf{$word}++;
        }
      }
      close IN;
      unlink $tmpfile;
    } else {
      # no Pod::Text found
      open(IN, "<$fn") || warn "Could not open $fn: $!\n", return (0);
      while ($line = <IN>) {
          if ($line =~ /^=head/) {
              $pod = 1;
          } elsif ($line =~ /^=cut/){
              $pod = 0;
          } else {
              next unless $pod;
          }
          for $word (&normalize($line)) {
              next if $stop{$word};
              $tf{$word}++;
          }
      }
      close(IN);
    }
    for $tf (values %tf) {
        $maxtf = $tf if $tf > $maxtf;
    }
    for $word (keys %tf) {
        $IDF{$word}++;
        $IF{$word} = '' unless defined $IF{$word}; # perl -w
        $IF{$word} .= pack($p.$p, $did, $tf{$word});
    }
    $FN{$did} = pack($p, $maxtf).$fns;
    print STDERR "$fns\n";
    1;
}


sub normalize {
    my $line = join ' ', @_;
    my @result;

    $line =~ tr/A-Z/a-z/;
    $line =~ tr/a-z0-9_/ /cs;
    for $word (split / /, $line ) {
        $word =~ s/^\d+//;
        next unless length($word) > 2;
        if ($stemmer) {
            push @result, &$stemmer($word);
        } else {
            push @result, $word;
        }
    }
    @result;
}


#############################################
# RCH hack here
sub search {
    my %score;
    my $maxhits = $opt_maxhits;
    my (@unknown, @stop);

    &initstop if $opt_verbose;
    for $word (normalize(@_)) {
        unless ($IF{$word}) {
            if ($stop{$word}) {
                push @stop, $word;
            } else {
                push @unknown, $word;
            }
            next;
        }
        my %post = unpack($p.'*',$IF{$word});
        my $idf = log($FN{'last'}/$IDF{$word});
        for $did (keys %post) {
            my ($maxtf) = unpack($p, $FN{$did});
            $score{$did} = 0 unless defined $score{$did}; # perl -w
            $score{$did} += $post{$did} / $maxtf * $idf;
        }
    }
    if ($opt_verbose) {
        print "Unkown:  @unknown\n" if @unknown;
        print "Ingnore: @stop\n" if @stop;
    }
    if ($opt_menu) {
        my @menu;
        my $answer = '';
        my $no = 0;
        my @s = ('1' .. '9', 'a' .. 'z');
        my %s;

        for $did (sort {$score{$b} <=> $score{$a}} keys %score) {
            my ($mtf, $path) = unpack($p.'a*', $FN{$did});
            my $s = $s[$no];
            push @menu, sprintf "%s %6.3f %s\n", $s, $score{$did}, $path;
            $s{$s} = ++$no;
            last unless --$maxhits;
        }
        &cbreak('on') if $opt_cbreak;
        while (1) {
            print @menu;
            print "\nEnter Number or 'q'> ";
            if ($opt_cbreak) {
                read(TTYIN,$answer,1);
                print "\n";
            } else {
                $answer = <STDIN>;
            }
            last if $answer =~ /^q/i;
            $answer = ($s{substr($answer,0,1)})-1;
            if ($answer >= 0 and $answer <= $#menu) {
                my $selection = $menu[$answer];
                if ($selection =~ m:/man:) {
                    my ($page, $sect) =
                        ($selection =~ m:([^/]*)\.(.{1,3})$:);
                    print STDERR "Running man $sect $page\n";
                    system 'man', $sect, $page;
                } else {
                    my ($path) = ($selection =~ m:(\S+)$:);
		    # RCH 2005-12-15 07:30 ##
		    $path =~ s/^C:\\//;       #
 		    $prefix= 'c:';      #
		    # RCH 2005-12-15 07:30 ##
                    $path = $prefix.'/'.$path;
#############################################
# RCH hack
# This is borrowed from sub printout of perldoc.bat
# perldoc.bat line 337 or so
# overwriting $pager="more /e"
# and $tmp
        # NEW on the HP
        ($pager)= 'C:\Progra~1\Instal~2\Less\less.exe';# <== FOUND IT!
                    #less  -+C +E  recommended in perldoc but doesnt seem to work
                #'c:\windows\notepad.exe'; <== +/- ok
                #'\PROGRA~1\INSTAL~2\List\LIST.COM';#   <== doesnt keep colours
                                                    # and text comes on screen
                #'\PROGRA~1\MULTI-~1.10\MeLite.exe';#   <== failed to get to the directory
                #'\PROGRA~1\INSTAL~2\PocketD\LIST.COM'; <== failed, long file names!!
                #'\fsf\bin\less -+c -e';                <== Hung
        # on the IBM
                #'\fsf\bin\less -+c -e';
                #'\progra~1\v\v.exe';
	         $tmp = "$ENV{TEMP}\\perldoc1.$$";
    		sysopen(OUT, $tmp, O_WRONLY | O_EXCL | O_CREAT, 0600)
    		    or die ("Can't open $tmp: $!");
    		Pod::Text->new()->parse_from_file($path,\*OUT);
    		close OUT   or die "can't close $tmp: $!";
    		system("$pager $tmp");
    		unlink($tmp);
#############################################
                }
            } else {
                my $path = $prefix."/bin/perlindex";
                system "pod2man --official $path | $nroff -man | $pager";
            }
        }
        &cbreak('off') if $opt_cbreak;
    } else {
        for $did (sort {$score{$b} <=> $score{$a}} keys %score) {
            printf("%6.3f %s\n", $score{$did},
                   (unpack($p.'a*', $FN{$did}))[1]);
            last unless --$maxhits;
        }
    }
}


sub cbreak {
    my $mode = shift;
    if ($mode eq 'on') {
        open(TTYIN, "</dev/tty") || die "can't read /dev/tty: $!";
        open(TTYOUT, ">/dev/tty") || die "can't write /dev/tty: $!";
        select(TTYOUT);
        $| = 1;
        select(STDOUT);
        $SIG{'QUIT'} = $SIG{'INT'} = 'cbreak';
	system "stty cbreak </dev/tty >/dev/tty 2>&1";
    } else {
	system "stty -cbreak </dev/tty >/dev/tty 2>&1";
    }
}


$stopinited = 0;                # perl -w


sub initstop {
    return if $stopinited++;
    while (<DATA>) {
        next if /^\#/;
        for (normalize($_)) {
          $stop{$_}++;
        }
    }
}

=head1 NAME

perlindex - index and query perl manual pages

=head1 SYNOPSIS

    perlindex -index

    perlindex tell me where the flowers are

=head1 DESCRIPTION

"C<perlindex -index>" generates an AnyDBM_File index which can be
searched with free text queries "C<perlindex> I<a verbose query>".

Each word of the query is searched in the index and a score is
generated for each document containing it. Scores for all words are
added and the documents with the highest score are printed.  All words
are stemed with Porters algorithm (see L<Text::English>) before
indexing and searching happens.

The score is computed as:

    $score{$document} += $tf{$word,$document}/$maxtf{$document}
                         * log ($N/$n{$word});

where

=over 10

=item C<$N>

is the number of documents in the index,

=item C<$n{$word}>

is the number of documents containing the I<word>,

=item C<$tf{$word,$document}>

is the number of occurances of I<word> in the I<document>, and

=item C<$maxtf{$document}>

is the maximum freqency of any word in I<document>.

=back

=head1 OPTIONS

All options may be abreviated.

=over 10

=item B<-maxhits> maxhits

Maximum numer of hits to display. Default is 15.

=item B<-menu>

=item B<-nomenu>

Use the matches as menu for calling C<man>. Default is B<-menu>.q

=item B<-cbreak>

=item B<-nocbreak>

Switch to cbreak in menu mode or dont. B<-cbreak> is the default.

=item B<-verbose>

Generates additional information which query words have been not found
in the database and which words of the query are stopwords.

=back

=head1 EXAMPLE

    perlindex foo bar

    1  3.735 lib/pod/perlbot.pod
    2  2.640 lib/pod/perlsec.pod
    3  2.153 lib/pod/perldata.pod
    4  1.920 lib/Symbol.pm
    5  1.802 lib/pod/perlsub.pod
    6  1.586 lib/Getopt/Long.pm
    7  1.190 lib/File/Path.pm
    8  1.042 lib/pod/perlop.pod
    9  0.857 lib/pod/perlre.pod
    a  0.830 lib/Shell.pm
    b  0.691 lib/strict.pm
    c  0.691 lib/Carp.pm
    d  0.680 lib/pod/perlpod.pod
    e  0.680 lib/File/Find.pm
    f  0.626 lib/pod/perlsyn.pod
    Enter Number or 'q'>

Hitting the keys C<1> to C<f> will display the corresponding manual
page. Hitting C<q> quits. All other keys display this manual page.

=head1 FILES

The index will be generated in your man directory. Strictly speaking in
C<$Config{man1direxp}/..>

    The following files will be generated:

    index_fn           # docid -> (max frequency, filename)
    index_idf          # term  -> number of documents containing term
    index_if           # term  -> (docid, frequency)*
    index_seen         # fn    -> indexed?


=head1 AUTHOR

Ulrich Pfeifer E<lt>F<pfeifer@ls6.informatik.uni-dortmund.de>E<gt>

=cut


__END__
# freeWAIS-sf stopwords
a
about
above
according
across
actually
adj
after
afterwards
again
against
all
almost
alone
along
already
also
although
always
among
amongst
an
and
another
any
anyhow
anyone
anything
anywhere
are
aren't
around
as
at
b
be
became
because
become
becomes
becoming
been
before
beforehand
begin
beginning
behind
being
below
beside
besides
between
beyond
billion
both
but
by
c
can
can't
cannot
caption
co
co.
could
couldn't
d
did
didn't
do
does
doesn't
don't
down
during
e
each
eg
eight
eighty
either
else
elsewhere
end
ending
enough
etc
even
ever
every
everyone
everything
everywhere
except
f
few
fifty
first
five
vfor
former
formerly
forty
found "
four
from
further
g
h
had
has
hasn't
have
haven't
he
he'd
he'll
he's
hence
her
here
here's
hereafter
hereby
herein
hereupon
hers
herself
him
himself
his
how
however
hundred
i
i'd
i'll
i'm
i've
ie
if
in
inc.
indeed
instead
into
is
isn't
it
it's
its
itself
j
k
l
last
later
latter
latterly
least
less
let
let's
like
likely
ltd
m
made
make
makes
many
maybe
me
meantime
meanwhile
might
million
miss
more
moreover
most
mostly
mr
mrs
much
must
my
myself
n
namely
neither
never
nevertheless
next
nine
ninety
no
nobody
none
nonetheless
noone
nor
not
nothing
now
nowhere
o
of
off
often
on
once
one
one's
only
onto
or
other
others
otherwise
our
ours
ourselves
out
over
overall
own
p
per
perhaps
q
r
rather
recent
recently
s
same
seem
seemed
seeming
seems
seven
seventy
several
she
she'd
she'll
she's
should
shouldn't
since
six
sixty
so
some
somehow
someone
something
sometime
sometimes
somewhere
still
stop
such
t
taking
ten
than
that
that'll
that's
that've
the
their
them
themselves
then
thence
there
there'd
there'll
there're
there's
there've
thereafter
thereby
therefore
therein
thereupon
these
they
they'd
they'll
they're
they've
thirty
this
those
though
thousand
three
through
throughout
thru
thus
to
together
too
toward
towards
trillion
twenty
two
u
under
unless
unlike
unlikely
until
up
upon
us
used
using
v
very
via
w
was
wasn't
we
we'd
we'll
we're
we've
well
were
weren't
what
what'll
what's
what've
whatever
when
whence
whenever
where
where's
whereafter
whereas
whereby
wherein
whereupon
wherever
whether
which
while
whither
who
who'd
who'll
who's
whoever
whole
whom
whomever
whose
why
will
with
within
without
won't
would
wouldn't
x
y
yes
yet
you
you'd
you'll
you're
you've
your
yours
yourself
yourselves
z
# occuring in more than 100 files
acc
accent
accents
and
are
bell
can
character
corrections
crt
daisy
dash
date
defined
definitions
description
devices
diablo
dummy
factors
following
font
for
from
fudge
give
have
header
holds
log
logo
low
lpr
mark
name
nroff
out
output
perl
pitch
put
rcsfile
reference
resolution
revision
see
set
simple
smi
some
string
synopsis
system
that
the
this
translation
troff
typewriter
ucb
unbreakable
use
used
user
vroff
wheel
will
with
you


__END__
:endofperl

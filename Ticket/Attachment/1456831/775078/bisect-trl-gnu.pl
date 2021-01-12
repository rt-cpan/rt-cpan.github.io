use Term::ReadLine; # needs Term::ReadLine::Gnu
open(IN,"<&STDIN")   || warn "Cannot open STDIN for read";
open(OUT,">&STDOUT") || warn "Cannot open STDOUT for write";
Term::ReadLine::Gnu::Var::_rl_store_iostream(\*IN, 0);
Term::ReadLine::Gnu::Var::_rl_store_iostream(\*OUT, 1);
# The followings work.
#Term::ReadLine::Gnu::Var::_rl_store_iostream(STDIN, 0);
#Term::ReadLine::Gnu::Var::_rl_store_iostream(STDOUT, 1);

my $instream = Term::ReadLine::Gnu::Var::_rl_fetch_iostream(0);
while (<$instream>) {
	print;
}
my $outstream = Term::ReadLine::Gnu::Var::_rl_fetch_iostream(1);
print $outstream "test\n";

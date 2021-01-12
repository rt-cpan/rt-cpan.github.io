use IPC::Exe 'exe';
use Data::Dumper;

# create generators
my %gen = (
    stdout => 
	[ $^X, '-le', 'print STDOUT $_ for qw(line1 line2 line3); exit 44' ],

    stderr =>
        [ $^X, '-le', 'print STDERR $_ for qw(line4 line5 line6); exit 77' ],
);

my @fh;
my ( $pid, @fh ) = &{ exe +{ stdout => $capture_stdout//0,
			     stderr => $capture_stderr//0 },
		      @{ $gen{$output // 'stdout' } } };

my %res = (
    $capture_stdout ? do { my $fh = shift @fh; ( stdout => [ <$fh> ] ) } : (),
    $capture_stderr ? do { my $fh = shift @fh; ( stderr => [ <$fh> ] ) } : (),
    );
print Dumper \%res if %res;


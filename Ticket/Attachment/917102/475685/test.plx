use Foo;
use Benchmark;

my $obj = Foo->new;
timethese(shift, {
    with_sub    => sub {
        $obj->with_sub(23);
        my $x = $obj->with_sub;
    },
    with_qsub   => sub {
        $obj->with_qsub(23);
        my $x = $obj->with_qsub;
    },
});
1;


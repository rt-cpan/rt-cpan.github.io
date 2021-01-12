use strict;
use warnings;
use Try::Tiny;
use Test::More;

$_ = "true";
try {
    1;
}
catch {
    fail("this should not be called");
}
finally {
    is $_, undef, "\$_ should not be set in the finally block";
};

done_testing;

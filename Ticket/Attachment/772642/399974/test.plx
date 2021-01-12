use strict;
use warnings;

use threads;
use threads::shared;
use Test::More;

my @modules = qw(Digest::SHA::PurePerl Digest::SHA1 Digest::SHA Digest::MD5);

for my $module (@modules) {
    note "******* Trying $module *******";
    require_ok $module;

    # Illustrating it works fine without threads
    {
        my $obj  = $module->new;
        $obj->add("foo");

        # This is equivalent to the thread cloning the object.
        my $tdigest = do {
            my $obj2 = $obj->clone;
            $obj2->add("bar");
            $obj2->clone->hexdigest;
        };

        isnt $obj->clone->hexdigest, $tdigest, "object unaffected by clone";

        $obj->add("bar");
        is $obj->clone->hexdigest, $tdigest;
    }

    # Illustrating the unrelated behavior of an unshared object
    {
        my $obj = $module->new;
        $obj->add("foo");
        my $tdigest = threads->create(sub { $obj->add("bar"); $obj->hexdigest })->join;

        isnt $obj->clone->hexdigest, $tdigest, "unshared object unaffected by the thread";

        $obj->add("bar");
        is $obj->clone->hexdigest, $tdigest;
    }

    # Illustrating the shared behavior
    TODO: {
        local $TODO = "make shared_clone work for bonus points";

        ok eval {
            my $obj = shared_clone( $module->new );
            $obj->add("foo");
            my $tdigest = threads->create(sub { $obj->add("bar"); $obj->clone->hexdigest })->join;

            is $obj->clone->hexdigest, $tdigest, "shared object affected by the thread";
        }, "shared_clone didn't blow up";
    }
}


done_testing;

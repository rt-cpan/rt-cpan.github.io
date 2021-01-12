# see call.c
use strict;
use warnings;

sub test_use_fail {
    warn __FILE__, ": ", __LINE__, "\n";
    eval "use NonExistent;";
    warn " \$@ is <$@>\n";
}

sub test_eval_begin_die {
    warn __FILE__, ": ", __LINE__, "\n";
    eval "BEGIN { die 'compile time die' }";
    warn " \$@ is <$@>\n";
}

sub test_eval_syntax {
    warn __FILE__, ": ", __LINE__, "\n";
    eval "/syntax";
    warn " \$@ is <$@>\n";
}

# the following are all ok

sub test_eval_begin_eval_die {
    warn __FILE__, ": ", __LINE__, "\n";
    eval "BEGIN { eval { die 'compile time die' } }";
    warn " \$@ is <$@>\n";
}

sub test_eval_end_die {
    warn __FILE__, ": ", __LINE__, "\n";
    eval "END { die 'end time die' }";
    warn " \$@ is <$@>\n";
}

sub test_eval_die {
    warn __FILE__, ": ", __LINE__, "\n";
    eval "die 'run time die'";
    warn " \$@ is <$@>\n";
}

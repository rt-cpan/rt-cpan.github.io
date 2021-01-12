#!/bin/bash
if [ -f Makefile ]; then
    make clean
fi
perl Makefile.PL TT_XS_ENABLE=y TT_XS_DEFAULT=y TT_ACCEPT=y TT_QUIET=y
make
prove -b evalusecrash.t

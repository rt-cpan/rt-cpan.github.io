#!/bin/sh -x
git clean -dxf
build=/home/tony/perl/bisect
if [ -d $build  ] ; then rm -rf $build ; fi
./Configure -Dprefix=$build -Dmyhostname=k83 -Dinstallusrbinperl=n -Uversiononly -Dusedevel -des -Ui_db -Uuseithreads -Uuselongdouble -DDEBUGGING=-g || exit 125
make -j6 || exit 125
#TEST_JOBS=4 make -j8 test_harness || exit 125
make -j8 install || exit 125
export PATH=$build/bin:$PATH
perl -V
#cpan DBD::SQLite || exit 125
cpan Term::ReadLine::Gnu || exit 125
[ "`perl ../bisect-trl-gnu.pl </dev/null`" = "test" ] || exit 1
echo Success `git describe`
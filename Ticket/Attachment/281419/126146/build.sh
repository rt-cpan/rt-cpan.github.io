#!/usr/bin/bash

cd /tmp

wget -nd http://public.activestate.com/pub/apc/perl-5.8.x-snap/perl-5.8.x\@29163.tar.bz2

tar -xjf perl-5.8.x\@29163.tar.bz2

cd perl-5.8.x

mkdir logs

./Configure -de -Duse64bitint \
                -Dusethreads  \
                -Uusemymalloc \
                -Dnoextensions='attrs IPC/SysV' \
                -A define:optimize='-O3 -pipe -funit-at-a-time -mtune=pentium4m -march=pentium4 -mfpmath=sse -mieee-fp -mmmx -msse -msse2' \
                -A define:ld=$LOC/bin/ld2 \
                -A append:ccflags=' -DPERL_DONT_CREATE_GVSV' \
        2>&1 | tee logs/conf.log

make 2>&1 | tee logs/make.log

make install


cd /tmp

wget -nd http://search.cpan.org/CPAN/authors/id/J/JP/JPEACOCK/version-0.68.tar.gz

tar -xzf version-0.68.tar.gz

cd version-0.68

/usr/local/bin/perl Makefile.PL

make

make test

# EOF

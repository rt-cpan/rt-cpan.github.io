# Start a clean shell, with no environment, 
# (in any empty directory with write permission)
exec -cl /bin/bash --noprofile

# Simple pmtools
function pmvers {  perl -M$1  -e "print \"\$$1::VERSION\n\"" ; }
pmvers Module::Build
# 0.3603
# I had the same results with v0.38, but don't install it here, due to needing many prereqs

# Bootstrap a new local::lib
ll=http://search.cpan.org/CPAN/authors/id/A/AP/APEIRON/local-lib-1.008004.tar.gz
wget -O - $ll | tar -xzf - 
cd local-lib-*
perl Makefile.PL --bootstrap
make install
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
# Check it
echo $PERL5LIB
cd ..

# Probably don't have Test::More yet, otherwise skip this block
testmore=http://search.cpan.org/CPAN/authors/id/M/MS/MSCHWERN/Test-Simple-0.98.tar.gz
wget -O - $testmore|tar -xzf -
cd Test-Simple-*
perl Makefile.PL
make install
cd ..

# First, Assume we have an old version of the prereq
dp01=http://dl.dropbox.com/u/6526608/Dummy-Prereq-0.01.tar.gz
wget -O - $dp01 | tar -xzf -
cd Dummy-Prereq-0.01
perl Build.PL
./Build test && ./Build install
# Check that it's 0.01
perl -MDummy::Prereq -e 'print "$Dummy::Prereq::VERSION\n"'
cd ..

# Now we want to install Dummy::Module, which depends on v0.02 of Dummy::Prereq
dm=http://dl.dropbox.com/u/6526608/Dummy-Module.tar.gz
wget -O - $dm|tar -xzf -
cd Dummy-Module/
perl Build.PL
# MB correctly identifies that we need v0.02 and only have v0.01

# Notice that the ./Build script contains our additions (here from local::lib) to $PERL5LIB 
# grep '@INC' -A 4 Build
#  unshift @INC,
#    (
#     '/home/bq_cdavis/perl5/lib/perl5/i386-linux-thread-multi',
#     '/home/bq_cdavis/perl5/lib/perl5'
#    );
cd ..

# Here, CPAN.pm would go fetch (the latest) Dummy::Prereq and build and test it
dp02=http://dl.dropbox.com/u/6526608/Dummy-Prereq-0.02.tar.gz
wget -O - $dp02| tar -xzf -
cd Dummy-Prereq-0.02
perl Build.PL
./Build test
# Note that CPAN does not install this (yet), because Dummy::Module has to be tested first
# Since the tests pass, CPAN.pm *prepends* $PWD/blib/lib and $PWD/blib/arch to $PERL5LIB :
export PERL5LIB=$PWD/blib/lib:$PWD/blib/arch:$PERL5LIB
# Check it
echo $PERL5LIB
# Which gives:
# /home/bq_cdavis/tmp/Dummy-Prereq-0.02/blib/lib:/home/bq_cdavis/tmp/Dummy-Prereq-0.02/blib/arch:/home/bq_cdavis/perl5/lib/perl5/i386-linux-thread-multi:/home/bq_cdavis/perl5/lib/perl5
# Now CPAN.pm goes back (now that all deps have passed tests), to test Dummy::Module
cd ..

# Now CPAN.pm can test Dummy::Module, because all the prereqs passed and they've been prepended to $PERL5LIB
cd Dummy-Module
./Build test --verbose
# Which dies, because Dummy::Prereq is still version 0.01
# This is because the ./Build script also *prepends* the original $PERL5LIB to the $PERL5LIB set by CPAN.pm
# Since version 0.01 was installed in one of those directories, MB picks that up, and Dummy-Module fails


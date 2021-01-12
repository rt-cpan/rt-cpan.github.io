# maybe: docker pull debian:stretch
# docker build -t perl-test . && docker run perl-test
FROM debian:stretch

RUN apt-get -y update
RUN apt-get -y --no-install-recommends install perl make gcc

# Upgrade to latest CPAN.pm AND do first-time configuration
#RUN cpan ANDK/CPAN-2.20-TRIAL.tar.gz
RUN cpan ANDK/CPAN-2.21-TRIAL.tar.gz

# Check if recommends_policy is on by default
RUN grep '.recommends_policy. => q\[1\]' /root/.cpan/CPAN/MyConfig.pm

# XXX why is this necessary --- otherwise "No tested distributions found" is reported? another bug!
RUN apt-get -y --no-install-recommends install libyaml-perl

# Test a random module with optional prereqs
CMD perl -MCPAN -e 'CPAN::Shell->expand("Module", "MCE")->test; print "Call now is_tested:\n"; CPAN::Shell->is_tested; print "Call now install_tested:\n"; CPAN::Shell->install_tested'

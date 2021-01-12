# docker build -t perl-test . && docker run perl-test
FROM ubuntu:xenial
RUN apt-get -y update
RUN apt-get -y install perl-modules
RUN apt-get -y install make
RUN apt-get -y install libfribidi-dev
RUN apt-get -y install gcc

CMD cpan -t KAMENSKY/Text-Bidi-2.14.tar.gz

# docker build -t perl-test . && docker run -it perl-test
FROM debian:10

RUN apt-get -y update
RUN apt-get -y --no-install-recommends install perl make gcc cpanminus
RUN apt-get -y --no-install-recommends install libc6-dev
RUN apt-get -y --no-install-recommends install libexpat1-dev libssl-dev zlib1g-dev
RUN apt-get -y --no-install-recommends install openssl libwww-perl
RUN cpanm https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-1.00.tar.gz
RUN cpanm XML::SAX::Expat
RUN cpanm XML::SAX
RUN cpanm WWW::Dict::Leo::Org
ENV LC_ALL C.UTF-8
CMD leo must

FROM ubuntu:16.04

MAINTAINER Eugen Konkov <kes-kes@yandex.ru>

ENV  DEBIAN_FRONTEND noninteractive

RUN  locale-gen en_US.UTF-8  &&  dpkg-reconfigure locales

RUN  apt-get update
RUN  apt-get install -y apt-utils
RUN  apt-get upgrade -y
RUN  apt-get install -y sudo openssh-server
RUN  service ssh start

RUN  apt-get -y install mc

RUN  apt-get -y install cpanminus

RUN  apt-get -y install memcached

#RUN  apt-get -y install postgresql

#RUN  apt-get -y install mysql-server

RUN  apt-get -y install apache2

RUN  apt-get -y install libapache2-mod-perl2-dev

RUN  apt-get -y install libapache2-mod-apreq2

RUN  apt-get -y install libapache2-request-perl

RUN  apt-get -y install apache2-dev

RUN  apt-get -y install libapreq2-dev



RUN  apt-get -y install libssh2-1-dev libssl-dev

RUN  apt-get -y install libxml2-dev

RUN  apt-get -y install perlmagick

RUN  apt-get -y install libmagic-dev

RUN  apt-get -y install postgresql-server-dev-9.5

RUN  apt-get -y install libgd-perl

RUN  apt-get -y install libmysqlclient-dev

RUN  mkdir -p /home/site/local

ENV  PERL_MB_OPT="--install_base '/home/site/local'"
ENV  PERL_MM_OPT=INSTALL_BASE=/home/site/local
ENV  PERL5LIB=/home/site/local/lib/perl5

ENV  PERL_MM_USE_DEFAULT=1

RUN  cpan Data::OptList
RUN  cpan YAML inc::latest Text::Xslate Config::Any Config::Tiny Net::SSH2 \
  LWP::UserAgent Mail::Address Net::IDN::Encode Data::UUID Email::Address \
  Email::Valid JSON::XS Convert::Color Hash::Merge RPC::XML Number::Nary \
  Log::Log4perl JSON Date::Calc DBI DBD::Pg IPC::Run3 Data::GUID \
  Text::Xslate::Bridge::TT2Like Digest::SHA1 Text::Markdown TheSchwartz \
  Gearman::Client Data::Dump OAuth::Simple String::Random Digest::HMAC_MD5 \
  Net::DNS Image::Info PDF::API2 PDF::Table PDF::TextBlock Email::Simple \
  Net::IMAP::Client File::LibMagic File::Which File::BOM HTML::Valid \
  HTML::Mason Etsy::StatsD Cache::Memcached Locale::gettext_xs MIME::Lite \
  Locale::PO DBD::mysql MIME::EncWords LWPx::ParanoidAgent Text::CSV


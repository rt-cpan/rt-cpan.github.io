# vim: ft=Dockerfile
FROM docker.io/alpine:3.6 as netdisco-builder-image

ARG COMMITTISH=HEAD

RUN apk add --no-cache \
      ca-certificates \
      curl \
      g++ \
      gcc \
      git \
      libc6-compat \
      make \
      net-snmp-perl \
      openssl-dev \
      perl-crypt-rijndael \
      perl-dbd-pg \
      perl-dev \
      perl-io-socket-ssl \
      perl-ldap \
      postgresql-client \
      wget && \
    apk fix --no-cache perl perl-dev

WORKDIR /tmp
RUN curl -sL -o /tmp/cpanm https://cpanmin.us/ && \
  chmod +x /tmp/cpanm

WORKDIR /home/netdisco
RUN PERL5LIB='.' /tmp/cpanm -v Authen::TacacsPlus 

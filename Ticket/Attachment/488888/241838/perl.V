Summary of my perl5 (revision 5 version 8 subversion 8) configuration:
  Platform:
    osname=linux, osvers=2.6.15.7, archname=x86_64-linux-gnu-thread-multi
    uname='linux yellow 2.6.15.7 #1 smp sun sep 23 13:51:52 utc 2007 x86_64 gnulinux '
    config_args='-Dusethreads -Duselargefiles -Dccflags=-DDEBIAN -Dcccdlflags=-fPIC -Darchname=x86_64-linux-gnu -Dprefix=/usr -Dprivlib=/usr/share/perl/5.8 -Darchlib=/usr/lib/perl/5.8 -Dvendorprefix=/usr -Dvendorlib=/usr/share/perl5 -Dvendorarch=/usr/lib/perl5 -Dsiteprefix=/usr/local -Dsitelib=/usr/local/share/perl/5.8.8 -Dsitearch=/usr/local/lib/perl/5.8.8 -Dman1dir=/usr/share/man/man1 -Dman3dir=/usr/share/man/man3 -Dsiteman1dir=/usr/local/man/man1 -Dsiteman3dir=/usr/local/man/man3 -Dman1ext=1 -Dman3ext=3perl -Dpager=/usr/bin/sensible-pager -Uafs -Ud_csh -Ud_ualarm -Uusesfio -Uusenm -Duseshrplib -Dlibperl=libperl.so.5.8.8 -Dd_dosuid -des'
    hint=recommended, useposix=true, d_sigaction=define
    usethreads=define use5005threads=undef useithreads=define usemultiplicity=define
    useperlio=define d_sfio=undef uselargefiles=define usesocks=undef
    use64bitint=define use64bitall=define uselongdouble=undef
    usemymalloc=n, bincompat5005=undef
  Compiler:
    cc='cc', ccflags ='-D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS -DDEBIAN -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64',
    optimize='-O2',
    cppflags='-D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS -DDEBIAN -fno-strict-aliasing -pipe -I/usr/local/include'
    ccversion='', gccversion='4.2.3 20071123 (prerelease) (Ubuntu 4.2.2-3ubuntu4)', gccosandvers=''
    intsize=4, longsize=8, ptrsize=8, doublesize=8, byteorder=12345678
    d_longlong=define, longlongsize=8, d_longdbl=define, longdblsize=16
    ivtype='long', ivsize=8, nvtype='double', nvsize=8, Off_t='off_t', lseeksize=8
    alignbytes=8, prototype=define
  Linker and Libraries:
    ld='cc', ldflags =' -L/usr/local/lib'
    libpth=/usr/local/lib /lib /usr/lib
    libs=-lgdbm -lgdbm_compat -ldb -ldl -lm -lpthread -lc -lcrypt
    perllibs=-ldl -lm -lpthread -lc -lcrypt
    libc=/lib/libc-2.6.1.so, so=so, useshrplib=true, libperl=libperl.so.5.8.8
    gnulibc_version='2.6.1'
  Dynamic Linking:
    dlsrc=dl_dlopen.xs, dlext=so, d_dlsymun=undef, ccdlflags='-Wl,-E'
    cccdlflags='-fPIC', lddlflags='-shared -L/usr/local/lib'


Characteristics of this binary (from libperl): 
  Compile-time options: MULTIPLICITY PERL_IMPLICIT_CONTEXT
                        PERL_MALLOC_WRAP THREADS_HAVE_PIDS USE_64_BIT_ALL
                        USE_64_BIT_INT USE_ITHREADS USE_LARGE_FILES
                        USE_PERLIO USE_REENTRANT_API
  Built under linux
  Compiled at Nov 27 2007 10:56:40
  %ENV:
    PERL5LIB="/usr/home/dan/unified/lib:/usr/home/dan/unified/var/lib:/usr/home/unified/lib:/usr/home/unified/var/lib"
    PERLCRITIC="/etc/perlcriticrc"
  @INC:
    /usr/home/dan/unified/lib
    /usr/home/dan/unified/var/lib
    /usr/home/unified/lib
    /usr/home/unified/var/lib
    /etc/perl
    /usr/local/lib/perl/5.8.8
    /usr/local/share/perl/5.8.8
    /usr/lib/perl5
    /usr/share/perl5
    /usr/lib/perl/5.8
    /usr/share/perl/5.8
    /usr/local/lib/site_perl
    .

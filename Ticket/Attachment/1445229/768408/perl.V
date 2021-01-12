Summary of my perl5 (revision 5 version 21 subversion 7) configuration:
   
  Platform:
    osname=darwin, osvers=14.0.0, archname=darwin-2level
    uname='darwin walrus.local 14.0.0 darwin kernel version 14.0.0: fri sep 19 00:26:44 pdt 2014; root:xnu-2782.1.97~2release_x86_64 x86_64 '
    config_args='-Dprefix=/Users/rjbs/.plenv/versions/21.7 -de -Dusedevel -A'eval:scriptdir=/Users/rjbs/.plenv/versions/21.7/bin''
    hint=recommended, useposix=true, d_sigaction=define
    useithreads=undef, usemultiplicity=undef
    use64bitint=define, use64bitall=define, uselongdouble=undef
    usemymalloc=n, bincompat5005=undef
  Compiler:
    cc='cc', ccflags ='-fno-common -DPERL_DARWIN -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -I/opt/local/include',
    optimize='-O3',
    cppflags='-fno-common -DPERL_DARWIN -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -I/opt/local/include'
    ccversion='', gccversion='4.2.1 Compatible Apple LLVM 6.0 (clang-600.0.56)', gccosandvers=''
    intsize=4, longsize=8, ptrsize=8, doublesize=8, byteorder=12345678, doublekind=3
    d_longlong=define, longlongsize=8, d_longdbl=define, longdblsize=16, longdblkind=3
    ivtype='long', ivsize=8, nvtype='double', nvsize=8, Off_t='off_t', lseeksize=8
    alignbytes=8, prototype=define
  Linker and Libraries:
    ld='env MACOSX_DEPLOYMENT_TARGET=10.3 cc', ldflags =' -fstack-protector -L/usr/local/lib -L/opt/local/lib'
    libpth=/usr/local/lib /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/6.0/lib /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib /usr/lib /opt/local/lib
    libs=-lgdbm -ldbm -ldl -lm -lutil -lc -lpthread
    perllibs=-ldl -lm -lutil -lc -lpthread
    libc=, so=dylib, useshrplib=false, libperl=libperl.a
    gnulibc_version=''
  Dynamic Linking:
    dlsrc=dl_dlopen.xs, dlext=bundle, d_dlsymun=undef, ccdlflags=' '
    cccdlflags=' ', lddlflags=' -bundle -undefined dynamic_lookup -L/usr/local/lib -L/opt/local/lib -fstack-protector'


Characteristics of this binary (from libperl): 
  Compile-time options: HAS_TIMES PERLIO_LAYERS PERL_DONT_CREATE_GVSV
                        PERL_HASH_FUNC_ONE_AT_A_TIME_HARD PERL_MALLOC_WRAP
                        PERL_NEW_COPY_ON_WRITE PERL_PRESERVE_IVUV
                        PERL_USE_DEVEL USE_64_BIT_ALL USE_64_BIT_INT
                        USE_LARGE_FILES USE_LOCALE USE_LOCALE_COLLATE
                        USE_LOCALE_CTYPE USE_LOCALE_NUMERIC USE_LOCALE_TIME
                        USE_PERLIO USE_PERL_ATOF
  Built under darwin
  Compiled at Dec 21 2014 21:53:20
  %ENV:
    PERL_AUTOINSTALL="--skipdeps"
    PERL_MAILERS="sendmail:/Users/rjbs/bin/sendmail"
  @INC:
    /Users/rjbs/.plenv/versions/21.7/lib/perl5/site_perl/5.21.7/darwin-2level
    /Users/rjbs/.plenv/versions/21.7/lib/perl5/site_perl/5.21.7
    /Users/rjbs/.plenv/versions/21.7/lib/perl5/5.21.7/darwin-2level
    /Users/rjbs/.plenv/versions/21.7/lib/perl5/5.21.7
    .

# This Makefile is for the Imager extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.6302 (Revision: 66302) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Perl extension for Generating 24 bit Images]
#     AUTHOR => [q[Tony Cook <tonyc@cpan.org>, Arnar M. Hrafnkelsson]]
#     BUILD_REQUIRES => {  }
#     CONFIGURE_REQUIRES => {  }
#     DEFINE => q[-DOS_freebsd ]
#     INC => q[  -I/usr/local/include/freetype2 -I/usr/local/include/freetype1/freetype]
#     LIBS => q[ -lm   -L/usr/local/lib -L/usr/lib -lttf]
#     META_MERGE => { resources=>{ repository=>q[git://git.imager.perl.org/imager.git], homepage=>q[http://imager.perl.org/], bugtracker=>q[http://rt.cpan.org/NoAuth/Bugs.html?Dist=Imager] }, no_index=>{ directory=>[q[PNG], q[GIF], q[TIFF], q[JPEG], q[W32], q[FT2], q[T1]] }, dynamic_config=>q[1], recommends=>{ Parse::RecDescent=>q[0] }, license=>q[perl] }
#     NAME => q[Imager]
#     OBJECT => q[Imager.o context.o draw.o polygon.o image.o io.o iolayer.o log.o gaussian.o conv.o pnm.o raw.o feat.o combine.o filters.o dynaload.o stackmach.o datatypes.o regmach.o trans2.o quant.o error.o convert.o map.o tags.o palimg.o maskimg.o img8.o img16.o rotate.o bmp.o tga.o color.o fills.o imgdouble.o limits.o hlines.o imext.o scale.o rubthru.o render.o paste.o compose.o flip.o perlio.o mutexpthr.o  fontft1.o]
#     PM => { imio.h=>q[$(INST_LIBDIR)/Imager/include/imio.h], lib/Imager/Engines.pod=>q[$(INST_LIBDIR)/Imager/Engines.pod], lib/Imager/Font/FreeType2.pm=>q[$(INST_LIBDIR)/Imager/Font/FreeType2.pm], lib/Imager/Font/Image.pm=>q[$(INST_LIBDIR)/Imager/Font/Image.pm], typemap=>q[$(INST_LIBDIR)/Imager/typemap], lib/Imager/Color/Table.pm=>q[$(INST_LIBDIR)/Imager/Color/Table.pm], lib/Imager/Font/Wrap.pm=>q[$(INST_LIBDIR)/Imager/Font/Wrap.pm], lib/Imager/Fountain.pm=>q[$(INST_LIBDIR)/Imager/Fountain.pm], lib/Imager/Tutorial.pod=>q[$(INST_LIBDIR)/Imager/Tutorial.pod], lib/Imager/Threads.pod=>q[$(INST_LIBDIR)/Imager/Threads.pod], rendert.h=>q[$(INST_LIBDIR)/Imager/include/rendert.h], lib/Imager/APIRef.pod=>q[$(INST_LIBDIR)/Imager/APIRef.pod], lib/Imager/Draw.pod=>q[$(INST_LIBDIR)/Imager/Draw.pod], imextpltypes.h=>q[$(INST_LIBDIR)/Imager/include/imextpltypes.h], imperl.h=>q[$(INST_LIBDIR)/Imager/include/imperl.h], Imager.pm=>q[$(INST_LIBDIR)/Imager.pm], lib/Imager/Color/Float.pm=>q[$(INST_LIBDIR)/Imager/Color/Float.pm], lib/Imager/ImageTypes.pod=>q[$(INST_LIBDIR)/Imager/ImageTypes.pod], lib/Imager/Filters.pod=>q[$(INST_LIBDIR)/Imager/Filters.pod], lib/Imager/API.pod=>q[$(INST_LIBDIR)/Imager/API.pod], log.h=>q[$(INST_LIBDIR)/Imager/include/log.h], lib/Imager/Install.pod=>q[$(INST_LIBDIR)/Imager/Install.pod], imext.h=>q[$(INST_LIBDIR)/Imager/include/imext.h], lib/Imager/Cookbook.pod=>q[$(INST_LIBDIR)/Imager/Cookbook.pod], lib/Imager/regmach.pod=>q[$(INST_LIBDIR)/Imager/regmach.pod], imperlio.h=>q[$(INST_LIBDIR)/Imager/include/imperlio.h], plug.h=>q[$(INST_LIBDIR)/Imager/include/plug.h], ppport.h=>q[$(INST_LIBDIR)/Imager/include/ppport.h], imextpl.h=>q[$(INST_LIBDIR)/Imager/include/imextpl.h], lib/Imager/Expr.pm=>q[$(INST_LIBDIR)/Imager/Expr.pm], lib/Imager/Security.pod=>q[$(INST_LIBDIR)/Imager/Security.pod], iolayer.h=>q[$(INST_LIBDIR)/Imager/include/iolayer.h], ext.h=>q[$(INST_LIBDIR)/Imager/include/ext.h], lib/Imager/IO.pod=>q[$(INST_LIBDIR)/Imager/IO.pod], lib/Imager/interface.pod=>q[$(INST_LIBDIR)/Imager/interface.pod], lib/Imager/Color.pm=>q[$(INST_LIBDIR)/Imager/Color.pm], lib/Imager/Matrix2d.pm=>q[$(INST_LIBDIR)/Imager/Matrix2d.pm], imconfig.h=>q[$(INST_LIBDIR)/Imager/include/imconfig.h], lib/Imager/Handy.pod=>q[$(INST_LIBDIR)/Imager/Handy.pod], lib/Imager/Probe.pm=>q[$(INST_LIBDIR)/Imager/Probe.pm], feat.h=>q[$(INST_LIBDIR)/Imager/include/feat.h], dynaload.h=>q[$(INST_LIBDIR)/Imager/include/dynaload.h], lib/Imager/Files.pod=>q[$(INST_LIBDIR)/Imager/Files.pod], stackmach.h=>q[$(INST_LIBDIR)/Imager/include/stackmach.h], lib/Imager/Fill.pm=>q[$(INST_LIBDIR)/Imager/Fill.pm], imageri.h=>q[$(INST_LIBDIR)/Imager/include/imageri.h], lib/Imager/Font/Test.pm=>q[$(INST_LIBDIR)/Imager/Font/Test.pm], imexttypes.h=>q[$(INST_LIBDIR)/Imager/include/imexttypes.h], lib/Imager/Regops.pm=>q[$(INST_LIBDIR)/Imager/Regops.pm], lib/Imager/Font/Type1.pm=>q[$(INST_LIBDIR)/Imager/Font/Type1.pm], lib/Imager/Transform.pm=>q[$(INST_LIBDIR)/Imager/Transform.pm], lib/Imager/Expr/Assem.pm=>q[$(INST_LIBDIR)/Imager/Expr/Assem.pm], lib/Imager/Test.pm=>q[$(INST_LIBDIR)/Imager/Test.pm], draw.h=>q[$(INST_LIBDIR)/Imager/include/draw.h], lib/Imager/Inline.pod=>q[$(INST_LIBDIR)/Imager/Inline.pod], lib/Imager/Font.pm=>q[$(INST_LIBDIR)/Imager/Font.pm], imerror.h=>q[$(INST_LIBDIR)/Imager/include/imerror.h], imager.h=>q[$(INST_LIBDIR)/Imager/include/imager.h], imextdef.h=>q[$(INST_LIBDIR)/Imager/include/imextdef.h], lib/Imager/Font/BBox.pm=>q[$(INST_LIBDIR)/Imager/Font/BBox.pm], lib/Imager/Font/Truetype.pm=>q[$(INST_LIBDIR)/Imager/Font/Truetype.pm], lib/Imager/Preprocess.pm=>q[$(INST_LIBDIR)/Imager/Preprocess.pm], immacros.h=>q[$(INST_LIBDIR)/Imager/include/immacros.h], regmach.h=>q[$(INST_LIBDIR)/Imager/include/regmach.h], imdatatypes.h=>q[$(INST_LIBDIR)/Imager/include/imdatatypes.h], lib/Imager/LargeSamples.pod=>q[$(INST_LIBDIR)/Imager/LargeSamples.pod], imrender.h=>q[$(INST_LIBDIR)/Imager/include/imrender.h], lib/Imager/ExtUtils.pm=>q[$(INST_LIBDIR)/Imager/ExtUtils.pm], iolayert.h=>q[$(INST_LIBDIR)/Imager/include/iolayert.h], lib/Imager/Transformations.pod=>q[$(INST_LIBDIR)/Imager/Transformations.pod] }
#     PREREQ_PM => { Test::More=>q[0.47], Scalar::Util=>q[1], XSLoader=>q[0] }
#     TYPEMAPS => [q[typemap.local], q[typemap]]
#     VERSION_FROM => q[Imager.pm]
#     clean => { FILES=>q[testout rubthru.c scale.c conv.c  filters.c gaussian.c render.c rubthru.c] }
#     test => { TESTS=>q[t/*.t t/*/*.t] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/local/lib/perl5/5.16/mach/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -DPIC -fPIC
CCDLFLAGS =   -Wl,-R/usr/local/lib/perl5/5.16/mach/CORE
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared  -L/usr/local/lib -fstack-protector
LDFLAGS = -pthread -Wl,-E  -fstack-protector -L/usr/local/lib
LIBC = 
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = freebsd
OSVERS = 9.1-release-p19
RANLIB = :
SITELIBEXP = /usr/local/lib/perl5/site_perl/5.16
SITEARCHEXP = /usr/local/lib/perl5/site_perl/5.16/mach
SO = so
VENDORARCHEXP = 
VENDORLIBEXP = 


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = Imager
NAME_SYM = Imager
VERSION = 1.000
VERSION_MACRO = VERSION
VERSION_SYM = 1_000
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 1.000
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1
MAN3EXT = 3
INSTALLDIRS = site
DESTDIR = 
PREFIX = /usr/local
PERLPREFIX = /usr/local
SITEPREFIX = /usr/local
VENDORPREFIX = 
INSTALLPRIVLIB = /usr/local/lib/perl5/5.16
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = /usr/local/lib/perl5/site_perl/5.16
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = 
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = /usr/local/lib/perl5/5.16/mach
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = /usr/local/lib/perl5/site_perl/5.16/mach
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = 
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = /usr/local/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = /usr/local/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = 
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = /usr/local/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = /usr/local/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = 
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = /usr/local/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = /usr/local/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = 
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = /usr/local/lib/perl5/5.16/perl/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = /usr/local/lib/perl5/5.16/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = 
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /usr/local/lib/perl5/5.16
PERL_ARCHLIB = /usr/local/lib/perl5/5.16/mach
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/local/lib/perl5/5.16/mach/CORE
PERL = /usr/local/bin/perl5
FULLPERL = /usr/local/bin/perl5
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/local/lib/perl5/5.16/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.6302
MM_REVISION = 66302

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = Imager
BASEEXT = Imager
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = Imager.pm
INC =   -I/usr/local/include/freetype2 -I/usr/local/include/freetype1/freetype
DEFINE = -DOS_freebsd 
OBJECT = Imager$(OBJ_EXT) context$(OBJ_EXT) draw$(OBJ_EXT) polygon$(OBJ_EXT) image$(OBJ_EXT) io$(OBJ_EXT) iolayer$(OBJ_EXT) log$(OBJ_EXT) gaussian$(OBJ_EXT) conv$(OBJ_EXT) pnm$(OBJ_EXT) raw$(OBJ_EXT) feat$(OBJ_EXT) combine$(OBJ_EXT) filters$(OBJ_EXT) dynaload$(OBJ_EXT) stackmach$(OBJ_EXT) datatypes$(OBJ_EXT) regmach$(OBJ_EXT) trans2$(OBJ_EXT) quant$(OBJ_EXT) error$(OBJ_EXT) convert$(OBJ_EXT) map$(OBJ_EXT) tags$(OBJ_EXT) palimg$(OBJ_EXT) maskimg$(OBJ_EXT) img8$(OBJ_EXT) img16$(OBJ_EXT) rotate$(OBJ_EXT) bmp$(OBJ_EXT) tga$(OBJ_EXT) color$(OBJ_EXT) fills$(OBJ_EXT) imgdouble$(OBJ_EXT) limits$(OBJ_EXT) hlines$(OBJ_EXT) imext$(OBJ_EXT) scale$(OBJ_EXT) rubthru$(OBJ_EXT) render$(OBJ_EXT) paste$(OBJ_EXT) compose$(OBJ_EXT) flip$(OBJ_EXT) perlio$(OBJ_EXT) mutexpthr$(OBJ_EXT)  fontft1$(OBJ_EXT)
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = Imager.xs
C_FILES  = Imager.c \
	bmp.c \
	color.c \
	combine.c \
	compose.c \
	context.c \
	convert.c \
	datatypes.c \
	draw.c \
	dynaload.c \
	error.c \
	feat.c \
	fills.c \
	flip.c \
	fontft1.c \
	hlines.c \
	image.c \
	imext.c \
	img16.c \
	img8.c \
	imgdouble.c \
	io.c \
	iolayer.c \
	limits.c \
	log.c \
	map.c \
	maskimg.c \
	mutexnull.c \
	mutexpthr.c \
	mutexwin.c \
	palimg.c \
	paste.c \
	perlio.c \
	pnm.c \
	polygon.c \
	quant.c \
	raw.c \
	regmach.c \
	rotate.c \
	stackmach.c \
	tags.c \
	tga.c \
	trans2.c
O_FILES  = Imager.o \
	bmp.o \
	color.o \
	combine.o \
	compose.o \
	context.o \
	convert.o \
	datatypes.o \
	draw.o \
	dynaload.o \
	error.o \
	feat.o \
	fills.o \
	flip.o \
	fontft1.o \
	hlines.o \
	image.o \
	imext.o \
	img16.o \
	img8.o \
	imgdouble.o \
	io.o \
	iolayer.o \
	limits.o \
	log.o \
	map.o \
	maskimg.o \
	mutexnull.o \
	mutexpthr.o \
	mutexwin.o \
	palimg.o \
	paste.o \
	perlio.o \
	pnm.o \
	polygon.o \
	quant.o \
	raw.o \
	regmach.o \
	rotate.o \
	stackmach.o \
	tags.o \
	tga.o \
	trans2.o
H_FILES  = draw.h \
	dynaload.h \
	ext.h \
	feat.h \
	imager.h \
	imageri.h \
	imconfig.h \
	imdatatypes.h \
	imerror.h \
	imext.h \
	imextdef.h \
	imextpl.h \
	imextpltypes.h \
	imexttypes.h \
	imio.h \
	immacros.h \
	imperl.h \
	imperlio.h \
	imrender.h \
	iolayer.h \
	iolayert.h \
	log.h \
	plug.h \
	ppport.h \
	regmach.h \
	rendert.h \
	stackmach.h
MAN1PODS = 
MAN3PODS = Imager.pm \
	lib/Imager/API.pod \
	lib/Imager/APIRef.pod \
	lib/Imager/Color.pm \
	lib/Imager/Color/Float.pm \
	lib/Imager/Color/Table.pm \
	lib/Imager/Cookbook.pod \
	lib/Imager/Draw.pod \
	lib/Imager/Engines.pod \
	lib/Imager/Expr.pm \
	lib/Imager/Expr/Assem.pm \
	lib/Imager/ExtUtils.pm \
	lib/Imager/Files.pod \
	lib/Imager/Fill.pm \
	lib/Imager/Filters.pod \
	lib/Imager/Font.pm \
	lib/Imager/Font/BBox.pm \
	lib/Imager/Font/FreeType2.pm \
	lib/Imager/Font/Test.pm \
	lib/Imager/Font/Truetype.pm \
	lib/Imager/Font/Type1.pm \
	lib/Imager/Font/Wrap.pm \
	lib/Imager/Fountain.pm \
	lib/Imager/Handy.pod \
	lib/Imager/IO.pod \
	lib/Imager/ImageTypes.pod \
	lib/Imager/Inline.pod \
	lib/Imager/Install.pod \
	lib/Imager/LargeSamples.pod \
	lib/Imager/Matrix2d.pm \
	lib/Imager/Preprocess.pm \
	lib/Imager/Probe.pm \
	lib/Imager/Regops.pm \
	lib/Imager/Security.pod \
	lib/Imager/Test.pm \
	lib/Imager/Threads.pod \
	lib/Imager/Transform.pm \
	lib/Imager/Transformations.pod \
	lib/Imager/Tutorial.pod \
	lib/Imager/interface.pod \
	lib/Imager/regmach.pod

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = $(INST_ARCHAUTODIR)/$(BASEEXT)$(LIB_EXT)
INST_DYNAMIC     = $(INST_ARCHAUTODIR)/$(DLBASE).$(DLEXT)
INST_BOOT        = $(INST_ARCHAUTODIR)/$(BASEEXT).bs

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = Imager.pm \
	draw.h \
	dynaload.h \
	ext.h \
	feat.h \
	imager.h \
	imageri.h \
	imconfig.h \
	imdatatypes.h \
	imerror.h \
	imext.h \
	imextdef.h \
	imextpl.h \
	imextpltypes.h \
	imexttypes.h \
	imio.h \
	immacros.h \
	imperl.h \
	imperlio.h \
	imrender.h \
	iolayer.h \
	iolayert.h \
	lib/Imager/API.pod \
	lib/Imager/APIRef.pod \
	lib/Imager/Color.pm \
	lib/Imager/Color/Float.pm \
	lib/Imager/Color/Table.pm \
	lib/Imager/Cookbook.pod \
	lib/Imager/Draw.pod \
	lib/Imager/Engines.pod \
	lib/Imager/Expr.pm \
	lib/Imager/Expr/Assem.pm \
	lib/Imager/ExtUtils.pm \
	lib/Imager/Files.pod \
	lib/Imager/Fill.pm \
	lib/Imager/Filters.pod \
	lib/Imager/Font.pm \
	lib/Imager/Font/BBox.pm \
	lib/Imager/Font/FreeType2.pm \
	lib/Imager/Font/Image.pm \
	lib/Imager/Font/Test.pm \
	lib/Imager/Font/Truetype.pm \
	lib/Imager/Font/Type1.pm \
	lib/Imager/Font/Wrap.pm \
	lib/Imager/Fountain.pm \
	lib/Imager/Handy.pod \
	lib/Imager/IO.pod \
	lib/Imager/ImageTypes.pod \
	lib/Imager/Inline.pod \
	lib/Imager/Install.pod \
	lib/Imager/LargeSamples.pod \
	lib/Imager/Matrix2d.pm \
	lib/Imager/Preprocess.pm \
	lib/Imager/Probe.pm \
	lib/Imager/Regops.pm \
	lib/Imager/Security.pod \
	lib/Imager/Test.pm \
	lib/Imager/Threads.pod \
	lib/Imager/Transform.pm \
	lib/Imager/Transformations.pod \
	lib/Imager/Tutorial.pod \
	lib/Imager/interface.pod \
	lib/Imager/regmach.pod \
	log.h \
	plug.h \
	ppport.h \
	regmach.h \
	rendert.h \
	stackmach.h \
	typemap

PM_TO_BLIB = imio.h \
	$(INST_LIBDIR)/Imager/include/imio.h \
	lib/Imager/Engines.pod \
	$(INST_LIBDIR)/Imager/Engines.pod \
	lib/Imager/Font/FreeType2.pm \
	$(INST_LIBDIR)/Imager/Font/FreeType2.pm \
	lib/Imager/Font/Image.pm \
	$(INST_LIBDIR)/Imager/Font/Image.pm \
	typemap \
	$(INST_LIBDIR)/Imager/typemap \
	lib/Imager/Color/Table.pm \
	$(INST_LIBDIR)/Imager/Color/Table.pm \
	lib/Imager/Font/Wrap.pm \
	$(INST_LIBDIR)/Imager/Font/Wrap.pm \
	lib/Imager/Fountain.pm \
	$(INST_LIBDIR)/Imager/Fountain.pm \
	lib/Imager/Tutorial.pod \
	$(INST_LIBDIR)/Imager/Tutorial.pod \
	lib/Imager/Threads.pod \
	$(INST_LIBDIR)/Imager/Threads.pod \
	rendert.h \
	$(INST_LIBDIR)/Imager/include/rendert.h \
	lib/Imager/APIRef.pod \
	$(INST_LIBDIR)/Imager/APIRef.pod \
	lib/Imager/Draw.pod \
	$(INST_LIBDIR)/Imager/Draw.pod \
	imextpltypes.h \
	$(INST_LIBDIR)/Imager/include/imextpltypes.h \
	imperl.h \
	$(INST_LIBDIR)/Imager/include/imperl.h \
	Imager.pm \
	$(INST_LIBDIR)/Imager.pm \
	lib/Imager/Color/Float.pm \
	$(INST_LIBDIR)/Imager/Color/Float.pm \
	lib/Imager/ImageTypes.pod \
	$(INST_LIBDIR)/Imager/ImageTypes.pod \
	lib/Imager/Filters.pod \
	$(INST_LIBDIR)/Imager/Filters.pod \
	lib/Imager/API.pod \
	$(INST_LIBDIR)/Imager/API.pod \
	log.h \
	$(INST_LIBDIR)/Imager/include/log.h \
	lib/Imager/Install.pod \
	$(INST_LIBDIR)/Imager/Install.pod \
	imext.h \
	$(INST_LIBDIR)/Imager/include/imext.h \
	lib/Imager/Cookbook.pod \
	$(INST_LIBDIR)/Imager/Cookbook.pod \
	lib/Imager/regmach.pod \
	$(INST_LIBDIR)/Imager/regmach.pod \
	imperlio.h \
	$(INST_LIBDIR)/Imager/include/imperlio.h \
	plug.h \
	$(INST_LIBDIR)/Imager/include/plug.h \
	ppport.h \
	$(INST_LIBDIR)/Imager/include/ppport.h \
	imextpl.h \
	$(INST_LIBDIR)/Imager/include/imextpl.h \
	lib/Imager/Expr.pm \
	$(INST_LIBDIR)/Imager/Expr.pm \
	lib/Imager/Security.pod \
	$(INST_LIBDIR)/Imager/Security.pod \
	iolayer.h \
	$(INST_LIBDIR)/Imager/include/iolayer.h \
	ext.h \
	$(INST_LIBDIR)/Imager/include/ext.h \
	lib/Imager/IO.pod \
	$(INST_LIBDIR)/Imager/IO.pod \
	lib/Imager/interface.pod \
	$(INST_LIBDIR)/Imager/interface.pod \
	lib/Imager/Color.pm \
	$(INST_LIBDIR)/Imager/Color.pm \
	lib/Imager/Matrix2d.pm \
	$(INST_LIBDIR)/Imager/Matrix2d.pm \
	imconfig.h \
	$(INST_LIBDIR)/Imager/include/imconfig.h \
	lib/Imager/Handy.pod \
	$(INST_LIBDIR)/Imager/Handy.pod \
	lib/Imager/Probe.pm \
	$(INST_LIBDIR)/Imager/Probe.pm \
	feat.h \
	$(INST_LIBDIR)/Imager/include/feat.h \
	dynaload.h \
	$(INST_LIBDIR)/Imager/include/dynaload.h \
	lib/Imager/Files.pod \
	$(INST_LIBDIR)/Imager/Files.pod \
	stackmach.h \
	$(INST_LIBDIR)/Imager/include/stackmach.h \
	lib/Imager/Fill.pm \
	$(INST_LIBDIR)/Imager/Fill.pm \
	imageri.h \
	$(INST_LIBDIR)/Imager/include/imageri.h \
	lib/Imager/Font/Test.pm \
	$(INST_LIBDIR)/Imager/Font/Test.pm \
	imexttypes.h \
	$(INST_LIBDIR)/Imager/include/imexttypes.h \
	lib/Imager/Regops.pm \
	$(INST_LIBDIR)/Imager/Regops.pm \
	lib/Imager/Font/Type1.pm \
	$(INST_LIBDIR)/Imager/Font/Type1.pm \
	lib/Imager/Transform.pm \
	$(INST_LIBDIR)/Imager/Transform.pm \
	lib/Imager/Expr/Assem.pm \
	$(INST_LIBDIR)/Imager/Expr/Assem.pm \
	lib/Imager/Test.pm \
	$(INST_LIBDIR)/Imager/Test.pm \
	draw.h \
	$(INST_LIBDIR)/Imager/include/draw.h \
	lib/Imager/Inline.pod \
	$(INST_LIBDIR)/Imager/Inline.pod \
	lib/Imager/Font.pm \
	$(INST_LIBDIR)/Imager/Font.pm \
	imerror.h \
	$(INST_LIBDIR)/Imager/include/imerror.h \
	imager.h \
	$(INST_LIBDIR)/Imager/include/imager.h \
	imextdef.h \
	$(INST_LIBDIR)/Imager/include/imextdef.h \
	lib/Imager/Font/BBox.pm \
	$(INST_LIBDIR)/Imager/Font/BBox.pm \
	lib/Imager/Font/Truetype.pm \
	$(INST_LIBDIR)/Imager/Font/Truetype.pm \
	lib/Imager/Preprocess.pm \
	$(INST_LIBDIR)/Imager/Preprocess.pm \
	immacros.h \
	$(INST_LIBDIR)/Imager/include/immacros.h \
	regmach.h \
	$(INST_LIBDIR)/Imager/include/regmach.h \
	imdatatypes.h \
	$(INST_LIBDIR)/Imager/include/imdatatypes.h \
	lib/Imager/LargeSamples.pod \
	$(INST_LIBDIR)/Imager/LargeSamples.pod \
	imrender.h \
	$(INST_LIBDIR)/Imager/include/imrender.h \
	lib/Imager/ExtUtils.pm \
	$(INST_LIBDIR)/Imager/ExtUtils.pm \
	iolayert.h \
	$(INST_LIBDIR)/Imager/include/iolayert.h \
	lib/Imager/Transformations.pod \
	$(INST_LIBDIR)/Imager/Transformations.pod


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.6302
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$$$ARGV[0], $$$$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:

XSUBPPDIR = /usr/local/lib/perl5/5.16/ExtUtils
XSUBPP = $(XSUBPPDIR)$(DFSEP)xsubpp
XSUBPPRUN = $(PERLRUN) $(XSUBPP)
XSPROTOARG = 
XSUBPPDEPS = /usr/local/lib/perl5/5.16/ExtUtils/typemap typemap.local typemap typemap $(XSUBPP)
XSUBPPARGS = -typemap /usr/local/lib/perl5/5.16/ExtUtils/typemap -typemap typemap.local -typemap typemap -typemap typemap
XSUBPP_EXTRA_ARGS = 


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = Imager
DISTVNAME = Imager-1.000


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:

CCFLAGS = -DAPPLLIB_EXP="/usr/local/lib/perl5/5.16/BSDPAN" -DHAS_FPSETMASK -DHAS_FLOATINGPOINT_H -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include
OPTIMIZE = -O2 -pipe -fno-strict-aliasing
PERLTYPE = 
MPOLLUTE = 


# --- MakeMaker const_loadlibs section:

# Imager might depend on some other libraries:
# See ExtUtils::Liblist for details
#
EXTRALIBS = -L/usr/local/lib -L/usr/lib -lttf
LDLOADLIBS = -lm -L/usr/local/lib -L/usr/lib -lttf
BSLOADLIBS = 
LD_RUN_PATH = /usr/local/lib


# --- MakeMaker const_cccmd section:
CCCMD = $(CC) -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION)

# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	OPTIMIZE="$(OPTIMIZE)"\
	PREFIX="$(PREFIX)"\
	PASTHRU_DEFINE="$(PASTHRU_DEFINE)"\
	PASTHRU_INC="$(PASTHRU_INC)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:

.c.i:
	cc -E -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c > $*.i

.c.s:
	$(CCCMD) -S $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c

.c$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c

.cpp$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cpp

.cxx$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cxx

.cc$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cc

.C$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.C


# --- MakeMaker xs_c section:

.xs.c:
	$(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $(XSUBPP_EXTRA_ARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c


# --- MakeMaker xs_o section:

.xs$(OBJ_EXT):
	$(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

$(O_FILES): $(H_FILES)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(INST_DYNAMIC) $(INST_BOOT)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_bs section:
BOOTSTRAP = $(BASEEXT).bs

# As Mkbootstrap might not write a file (if none is required)
# we use touch to prevent make continually trying to remake it.
# The DynaLoader only reads a non-empty file.
$(BOOTSTRAP) : $(FIRST_MAKEFILE) $(BOOTDEP) $(INST_ARCHAUTODIR)$(DFSEP).exists
	$(NOECHO) $(ECHO) "Running Mkbootstrap for $(NAME) ($(BSLOADLIBS))"
	$(NOECHO) $(PERLRUN) \
		"-MExtUtils::Mkbootstrap" \
		-e "Mkbootstrap('$(BASEEXT)','$(BSLOADLIBS)');"
	$(NOECHO) $(TOUCH) $@
	$(CHMOD) $(PERM_RW) $@

$(INST_BOOT) : $(BOOTSTRAP) $(INST_ARCHAUTODIR)$(DFSEP).exists
	$(NOECHO) $(RM_RF) $@
	- $(CP) $(BOOTSTRAP) $@
	$(CHMOD) $(PERM_RW) $@


# --- MakeMaker dynamic_lib section:

# This section creates the dynamically loadable $(INST_DYNAMIC)
# from $(OBJECT) and possibly $(MYEXTLIB).
ARMAYBE = :
OTHERLDFLAGS = 
INST_DYNAMIC_DEP = 
INST_DYNAMIC_FIX = 

$(INST_DYNAMIC): $(OBJECT) $(MYEXTLIB) $(BOOTSTRAP) $(INST_ARCHAUTODIR)$(DFSEP).exists $(EXPORT_LIST) $(PERL_ARCHIVE) $(PERL_ARCHIVE_AFTER) $(INST_DYNAMIC_DEP)
	$(RM_F) $@
	LD_RUN_PATH="$(LD_RUN_PATH)" $(LD)  $(LDDLFLAGS) $(LDFROM) $(OTHERLDFLAGS) -o $@ $(MYEXTLIB)	\
	  $(PERL_ARCHIVE) $(LDLOADLIBS) $(PERL_ARCHIVE_AFTER) $(EXPORT_LIST)	\
	  $(INST_DYNAMIC_FIX)
	$(CHMOD) $(PERM_RWX) $@


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:

$(INST_STATIC) : $(OBJECT) $(MYEXTLIB) $(INST_ARCHAUTODIR)$(DFSEP).exists
	$(RM_RF) $@
	$(FULL_AR) $(AR_STATIC_ARGS) $@ $(OBJECT) && $(RANLIB) $@
	$(CHMOD) $(PERM_RWX) $@
	$(NOECHO) $(ECHO) "$(EXTRALIBS)" > $(INST_ARCHAUTODIR)/extralibs.ld


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	lib/Imager/Probe.pm \
	lib/Imager/Files.pod \
	lib/Imager/Engines.pod \
	lib/Imager/Font/FreeType2.pm \
	lib/Imager/Fill.pm \
	lib/Imager/Font/Test.pm \
	lib/Imager/Color/Table.pm \
	lib/Imager/Regops.pm \
	lib/Imager/Font/Wrap.pm \
	lib/Imager/Fountain.pm \
	lib/Imager/Tutorial.pod \
	lib/Imager/Threads.pod \
	lib/Imager/Transform.pm \
	lib/Imager/Font/Type1.pm \
	lib/Imager/APIRef.pod \
	lib/Imager/Draw.pod \
	Imager.pm \
	lib/Imager/Expr/Assem.pm \
	lib/Imager/Test.pm \
	lib/Imager/Color/Float.pm \
	lib/Imager/Inline.pod \
	lib/Imager/ImageTypes.pod \
	lib/Imager/Filters.pod \
	lib/Imager/Font.pm \
	lib/Imager/API.pod \
	lib/Imager/Font/BBox.pm \
	lib/Imager/Install.pod \
	lib/Imager/Preprocess.pm \
	lib/Imager/Font/Truetype.pm \
	lib/Imager/Cookbook.pod \
	lib/Imager/regmach.pod \
	lib/Imager/Expr.pm \
	lib/Imager/Security.pod \
	lib/Imager/LargeSamples.pod \
	lib/Imager/IO.pod \
	lib/Imager/ExtUtils.pm \
	lib/Imager/interface.pod \
	lib/Imager/Transformations.pod \
	lib/Imager/Color.pm \
	lib/Imager/Matrix2d.pm \
	lib/Imager/Handy.pod
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/Imager/Probe.pm $(INST_MAN3DIR)/Imager::Probe.$(MAN3EXT) \
	  lib/Imager/Files.pod $(INST_MAN3DIR)/Imager::Files.$(MAN3EXT) \
	  lib/Imager/Engines.pod $(INST_MAN3DIR)/Imager::Engines.$(MAN3EXT) \
	  lib/Imager/Font/FreeType2.pm $(INST_MAN3DIR)/Imager::Font::FreeType2.$(MAN3EXT) \
	  lib/Imager/Fill.pm $(INST_MAN3DIR)/Imager::Fill.$(MAN3EXT) \
	  lib/Imager/Font/Test.pm $(INST_MAN3DIR)/Imager::Font::Test.$(MAN3EXT) \
	  lib/Imager/Color/Table.pm $(INST_MAN3DIR)/Imager::Color::Table.$(MAN3EXT) \
	  lib/Imager/Regops.pm $(INST_MAN3DIR)/Imager::Regops.$(MAN3EXT) \
	  lib/Imager/Font/Wrap.pm $(INST_MAN3DIR)/Imager::Font::Wrap.$(MAN3EXT) \
	  lib/Imager/Fountain.pm $(INST_MAN3DIR)/Imager::Fountain.$(MAN3EXT) \
	  lib/Imager/Tutorial.pod $(INST_MAN3DIR)/Imager::Tutorial.$(MAN3EXT) \
	  lib/Imager/Threads.pod $(INST_MAN3DIR)/Imager::Threads.$(MAN3EXT) \
	  lib/Imager/Transform.pm $(INST_MAN3DIR)/Imager::Transform.$(MAN3EXT) \
	  lib/Imager/Font/Type1.pm $(INST_MAN3DIR)/Imager::Font::Type1.$(MAN3EXT) \
	  lib/Imager/APIRef.pod $(INST_MAN3DIR)/Imager::APIRef.$(MAN3EXT) \
	  lib/Imager/Draw.pod $(INST_MAN3DIR)/Imager::Draw.$(MAN3EXT) \
	  Imager.pm $(INST_MAN3DIR)/Imager.$(MAN3EXT) \
	  lib/Imager/Expr/Assem.pm $(INST_MAN3DIR)/Imager::Expr::Assem.$(MAN3EXT) \
	  lib/Imager/Test.pm $(INST_MAN3DIR)/Imager::Test.$(MAN3EXT) \
	  lib/Imager/Color/Float.pm $(INST_MAN3DIR)/Imager::Color::Float.$(MAN3EXT) \
	  lib/Imager/Inline.pod $(INST_MAN3DIR)/Imager::Inline.$(MAN3EXT) \
	  lib/Imager/ImageTypes.pod $(INST_MAN3DIR)/Imager::ImageTypes.$(MAN3EXT) \
	  lib/Imager/Filters.pod $(INST_MAN3DIR)/Imager::Filters.$(MAN3EXT) \
	  lib/Imager/Font.pm $(INST_MAN3DIR)/Imager::Font.$(MAN3EXT) \
	  lib/Imager/API.pod $(INST_MAN3DIR)/Imager::API.$(MAN3EXT) \
	  lib/Imager/Font/BBox.pm $(INST_MAN3DIR)/Imager::Font::BBox.$(MAN3EXT) \
	  lib/Imager/Install.pod $(INST_MAN3DIR)/Imager::Install.$(MAN3EXT) \
	  lib/Imager/Preprocess.pm $(INST_MAN3DIR)/Imager::Preprocess.$(MAN3EXT) \
	  lib/Imager/Font/Truetype.pm $(INST_MAN3DIR)/Imager::Font::Truetype.$(MAN3EXT) \
	  lib/Imager/Cookbook.pod $(INST_MAN3DIR)/Imager::Cookbook.$(MAN3EXT) \
	  lib/Imager/regmach.pod $(INST_MAN3DIR)/Imager::regmach.$(MAN3EXT) \
	  lib/Imager/Expr.pm $(INST_MAN3DIR)/Imager::Expr.$(MAN3EXT) \
	  lib/Imager/Security.pod $(INST_MAN3DIR)/Imager::Security.$(MAN3EXT) \
	  lib/Imager/LargeSamples.pod $(INST_MAN3DIR)/Imager::LargeSamples.$(MAN3EXT) \
	  lib/Imager/IO.pod $(INST_MAN3DIR)/Imager::IO.$(MAN3EXT) \
	  lib/Imager/ExtUtils.pm $(INST_MAN3DIR)/Imager::ExtUtils.$(MAN3EXT) \
	  lib/Imager/interface.pod $(INST_MAN3DIR)/Imager::interface.$(MAN3EXT) \
	  lib/Imager/Transformations.pod $(INST_MAN3DIR)/Imager::Transformations.$(MAN3EXT) \
	  lib/Imager/Color.pm $(INST_MAN3DIR)/Imager::Color.$(MAN3EXT) \
	  lib/Imager/Matrix2d.pm $(INST_MAN3DIR)/Imager::Matrix2d.$(MAN3EXT) \
	  lib/Imager/Handy.pod $(INST_MAN3DIR)/Imager::Handy.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:


# --- MakeMaker subdirs section:

# The default clean, realclean and test targets in this Makefile
# have automatically been given entries for each subdir.


subdirs ::
	$(NOECHO) cd CountColor && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd DynTest && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd FT2 && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Flines && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd GIF && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd ICO && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd JPEG && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Mandelbrot && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd PNG && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd SGI && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd T1 && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd TIFF && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd W32 && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd dynfilt && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)


# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(ABSPERLRUN)  -e 'chdir '\''CountColor'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''DynTest'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''FT2'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Flines'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''GIF'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''ICO'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''JPEG'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Mandelbrot'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''PNG'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''SGI'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''T1'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''TIFF'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''W32'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''dynfilt'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  core.[0-9] $(BASEEXT).bso \
	  pm_to_blib.ts core.[0-9][0-9][0-9][0-9] \
	  MYMETA.yml perl$(EXE_EXT) \
	  tmon.out *$(OBJ_EXT) \
	  pm_to_blib blibdirs.ts \
	  Imager.c *perl.core \
	  core.*perl.*.? $(BASEEXT).def \
	  core.[0-9][0-9][0-9] mon.out \
	  lib$(BASEEXT).def perl.exe \
	  perlmain.c so_locations \
	  $(BASEEXT).exp *$(LIB_EXT) \
	  core $(INST_ARCHAUTODIR)/extralibs.all \
	  core.[0-9][0-9] MYMETA.json \
	  $(BASEEXT).x $(BOOTSTRAP) \
	  $(INST_ARCHAUTODIR)/extralibs.ld core.[0-9][0-9][0-9][0-9][0-9] \
	  $(MAKE_APERL_FILE) perl 
	- $(RM_RF) \
	  scale.c testout \
	  gaussian.c conv.c \
	  render.c rubthru.c \
	  blib filters.c 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	- $(ABSPERLRUN)  -e 'chdir '\''CountColor'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''CountColor'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''DynTest'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''DynTest'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''FT2'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''FT2'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Flines'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Flines'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''GIF'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''GIF'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''ICO'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''ICO'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''JPEG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''JPEG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Mandelbrot'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Mandelbrot'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''PNG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''PNG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''SGI'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''SGI'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''T1'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''T1'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TIFF'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TIFF'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''W32'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''W32'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''dynfilt'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''dynfilt'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(OBJECT) $(MAKEFILE_OLD) \
	  $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile : create_distdir
	$(NOECHO) $(ECHO) Generating META.yml
	$(NOECHO) $(ECHO) '---' > META_new.yml
	$(NOECHO) $(ECHO) 'abstract: '\''Perl extension for Generating 24 bit Images'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'author:' >> META_new.yml
	$(NOECHO) $(ECHO) '  - '\''Tony Cook <tonyc@cpan.org>, Arnar M. Hrafnkelsson'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'build_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '  ExtUtils::MakeMaker: 0' >> META_new.yml
	$(NOECHO) $(ECHO) 'configure_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '  ExtUtils::MakeMaker: 0' >> META_new.yml
	$(NOECHO) $(ECHO) 'dynamic_config: 1' >> META_new.yml
	$(NOECHO) $(ECHO) 'generated_by: '\''ExtUtils::MakeMaker version 6.6302, CPAN::Meta::Converter version 2.120630'\''' >> META_new.yml
	$(NOECHO) $(ECHO) 'license: perl' >> META_new.yml
	$(NOECHO) $(ECHO) 'meta-spec:' >> META_new.yml
	$(NOECHO) $(ECHO) '  url: http://module-build.sourceforge.net/META-spec-v1.4.html' >> META_new.yml
	$(NOECHO) $(ECHO) '  version: 1.4' >> META_new.yml
	$(NOECHO) $(ECHO) 'name: Imager' >> META_new.yml
	$(NOECHO) $(ECHO) 'no_index:' >> META_new.yml
	$(NOECHO) $(ECHO) '  directory:' >> META_new.yml
	$(NOECHO) $(ECHO) '    - t' >> META_new.yml
	$(NOECHO) $(ECHO) '    - inc' >> META_new.yml
	$(NOECHO) $(ECHO) '    - PNG' >> META_new.yml
	$(NOECHO) $(ECHO) '    - GIF' >> META_new.yml
	$(NOECHO) $(ECHO) '    - TIFF' >> META_new.yml
	$(NOECHO) $(ECHO) '    - JPEG' >> META_new.yml
	$(NOECHO) $(ECHO) '    - W32' >> META_new.yml
	$(NOECHO) $(ECHO) '    - FT2' >> META_new.yml
	$(NOECHO) $(ECHO) '    - T1' >> META_new.yml
	$(NOECHO) $(ECHO) 'recommends:' >> META_new.yml
	$(NOECHO) $(ECHO) '  Parse::RecDescent: 0' >> META_new.yml
	$(NOECHO) $(ECHO) 'requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '  Scalar::Util: 1' >> META_new.yml
	$(NOECHO) $(ECHO) '  Test::More: 0.47' >> META_new.yml
	$(NOECHO) $(ECHO) '  XSLoader: 0' >> META_new.yml
	$(NOECHO) $(ECHO) 'resources:' >> META_new.yml
	$(NOECHO) $(ECHO) '  bugtracker: http://rt.cpan.org/NoAuth/Bugs.html?Dist=Imager' >> META_new.yml
	$(NOECHO) $(ECHO) '  homepage: http://imager.perl.org/' >> META_new.yml
	$(NOECHO) $(ECHO) '  repository: git://git.imager.perl.org/imager.git' >> META_new.yml
	$(NOECHO) $(ECHO) 'version: 1.000' >> META_new.yml
	-$(NOECHO) $(MV) META_new.yml $(DISTVNAME)/META.yml
	$(NOECHO) $(ECHO) Generating META.json
	$(NOECHO) $(ECHO) '{' > META_new.json
	$(NOECHO) $(ECHO) '   "abstract" : "Perl extension for Generating 24 bit Images",' >> META_new.json
	$(NOECHO) $(ECHO) '   "author" : [' >> META_new.json
	$(NOECHO) $(ECHO) '      "Tony Cook <tonyc@cpan.org>, Arnar M. Hrafnkelsson"' >> META_new.json
	$(NOECHO) $(ECHO) '   ],' >> META_new.json
	$(NOECHO) $(ECHO) '   "dynamic_config" : 1,' >> META_new.json
	$(NOECHO) $(ECHO) '   "generated_by" : "ExtUtils::MakeMaker version 6.6302, CPAN::Meta::Converter version 2.120630",' >> META_new.json
	$(NOECHO) $(ECHO) '   "license" : [' >> META_new.json
	$(NOECHO) $(ECHO) '      "perl_5"' >> META_new.json
	$(NOECHO) $(ECHO) '   ],' >> META_new.json
	$(NOECHO) $(ECHO) '   "meta-spec" : {' >> META_new.json
	$(NOECHO) $(ECHO) '      "url" : "http://search.cpan.org/perldoc?CPAN::Meta::Spec",' >> META_new.json
	$(NOECHO) $(ECHO) '      "version" : "2"' >> META_new.json
	$(NOECHO) $(ECHO) '   },' >> META_new.json
	$(NOECHO) $(ECHO) '   "name" : "Imager",' >> META_new.json
	$(NOECHO) $(ECHO) '   "no_index" : {' >> META_new.json
	$(NOECHO) $(ECHO) '      "directory" : [' >> META_new.json
	$(NOECHO) $(ECHO) '         "t",' >> META_new.json
	$(NOECHO) $(ECHO) '         "inc",' >> META_new.json
	$(NOECHO) $(ECHO) '         "PNG",' >> META_new.json
	$(NOECHO) $(ECHO) '         "GIF",' >> META_new.json
	$(NOECHO) $(ECHO) '         "TIFF",' >> META_new.json
	$(NOECHO) $(ECHO) '         "JPEG",' >> META_new.json
	$(NOECHO) $(ECHO) '         "W32",' >> META_new.json
	$(NOECHO) $(ECHO) '         "FT2",' >> META_new.json
	$(NOECHO) $(ECHO) '         "T1"' >> META_new.json
	$(NOECHO) $(ECHO) '      ]' >> META_new.json
	$(NOECHO) $(ECHO) '   },' >> META_new.json
	$(NOECHO) $(ECHO) '   "prereqs" : {' >> META_new.json
	$(NOECHO) $(ECHO) '      "build" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "requires" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "ExtUtils::MakeMaker" : "0"' >> META_new.json
	$(NOECHO) $(ECHO) '         }' >> META_new.json
	$(NOECHO) $(ECHO) '      },' >> META_new.json
	$(NOECHO) $(ECHO) '      "configure" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "requires" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "ExtUtils::MakeMaker" : "0"' >> META_new.json
	$(NOECHO) $(ECHO) '         }' >> META_new.json
	$(NOECHO) $(ECHO) '      },' >> META_new.json
	$(NOECHO) $(ECHO) '      "runtime" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "recommends" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "Parse::RecDescent" : "0"' >> META_new.json
	$(NOECHO) $(ECHO) '         },' >> META_new.json
	$(NOECHO) $(ECHO) '         "requires" : {' >> META_new.json
	$(NOECHO) $(ECHO) '            "Scalar::Util" : "1",' >> META_new.json
	$(NOECHO) $(ECHO) '            "Test::More" : "0.47",' >> META_new.json
	$(NOECHO) $(ECHO) '            "XSLoader" : "0"' >> META_new.json
	$(NOECHO) $(ECHO) '         }' >> META_new.json
	$(NOECHO) $(ECHO) '      }' >> META_new.json
	$(NOECHO) $(ECHO) '   },' >> META_new.json
	$(NOECHO) $(ECHO) '   "release_status" : "stable",' >> META_new.json
	$(NOECHO) $(ECHO) '   "resources" : {' >> META_new.json
	$(NOECHO) $(ECHO) '      "bugtracker" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "web" : "http://rt.cpan.org/NoAuth/Bugs.html?Dist=Imager"' >> META_new.json
	$(NOECHO) $(ECHO) '      },' >> META_new.json
	$(NOECHO) $(ECHO) '      "homepage" : "http://imager.perl.org/",' >> META_new.json
	$(NOECHO) $(ECHO) '      "repository" : {' >> META_new.json
	$(NOECHO) $(ECHO) '         "url" : "git://git.imager.perl.org/imager.git"' >> META_new.json
	$(NOECHO) $(ECHO) '      }' >> META_new.json
	$(NOECHO) $(ECHO) '   },' >> META_new.json
	$(NOECHO) $(ECHO) '   "version" : "1.000"' >> META_new.json
	$(NOECHO) $(ECHO) '}' >> META_new.json
	-$(NOECHO) $(MV) META_new.json $(DISTVNAME)/META.json


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old 



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir distmeta 
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -e q{META.yml};' \
	  -e 'eval { maniadd({q{META.yml} => q{Module YAML meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.yml to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -f q{META.json};' \
	  -e 'eval { maniadd({q{META.json} => q{Module JSON meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.json to MANIFEST: $$$${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLARCHLIB)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLVENDORARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_vendor_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLVENDORLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::
	$(NOECHO) $(UNINSTALL) $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::
	$(NOECHO) $(UNINSTALL) $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:

PERL_HDRS = \
	$(PERL_INC)/EXTERN.h		\
	$(PERL_INC)/INTERN.h		\
	$(PERL_INC)/XSUB.h		\
	$(PERL_INC)/av.h		\
	$(PERL_INC)/config.h		\
	$(PERL_INC)/cop.h		\
	$(PERL_INC)/cv.h		\
	$(PERL_INC)/dosish.h		\
	$(PERL_INC)/embed.h		\
	$(PERL_INC)/embedvar.h		\
	$(PERL_INC)/fakethr.h		\
	$(PERL_INC)/form.h		\
	$(PERL_INC)/gv.h		\
	$(PERL_INC)/handy.h		\
	$(PERL_INC)/hv.h		\
	$(PERL_INC)/intrpvar.h		\
	$(PERL_INC)/iperlsys.h		\
	$(PERL_INC)/keywords.h		\
	$(PERL_INC)/mg.h		\
	$(PERL_INC)/nostdio.h		\
	$(PERL_INC)/op.h		\
	$(PERL_INC)/opcode.h		\
	$(PERL_INC)/patchlevel.h	\
	$(PERL_INC)/perl.h		\
	$(PERL_INC)/perlio.h		\
	$(PERL_INC)/perlsdio.h		\
	$(PERL_INC)/perlsfio.h		\
	$(PERL_INC)/perlvars.h		\
	$(PERL_INC)/perly.h		\
	$(PERL_INC)/pp.h		\
	$(PERL_INC)/pp_proto.h		\
	$(PERL_INC)/proto.h		\
	$(PERL_INC)/regcomp.h		\
	$(PERL_INC)/regexp.h		\
	$(PERL_INC)/regnodes.h		\
	$(PERL_INC)/scope.h		\
	$(PERL_INC)/sv.h		\
	$(PERL_INC)/thread.h		\
	$(PERL_INC)/unixish.h		\
	$(PERL_INC)/util.h

$(OBJECT) : $(PERL_HDRS)

Imager.c : $(XSUBPPDEPS)


# --- MakeMaker makefile section:

$(OBJECT) : $(FIRST_MAKEFILE)

# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/local/bin/perl5

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR=CountColor:DynTest:FT2:Flines:GIF:ICO:JPEG:Mandelbrot:PNG:SGI:T1:TIFF:W32:dynfilt \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t t/*/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)

subdirs-test ::
	$(NOECHO) cd CountColor && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd DynTest && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd FT2 && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd Flines && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd GIF && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd ICO && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd JPEG && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd Mandelbrot && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd PNG && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd SGI && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd T1 && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd TIFF && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd W32 && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd dynfilt && $(MAKE) test $(PASTHRU)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: pure_all $(MAP_TARGET)
	PERL_DL_NONLAZY=1 ./$(MAP_TARGET) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_static :: pure_all $(MAP_TARGET)
	PERL_DL_NONLAZY=1 ./$(MAP_TARGET) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)



# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="$(VERSION)">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Perl extension for Generating 24 bit Images</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Tony Cook &lt;tonyc@cpan.org&gt;, Arnar M. Hrafnkelsson</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Scalar::Util" VERSION="1" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::More" VERSION="0.47" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="XSLoader::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="amd64-freebsd-thread-multi-5.16" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  imio.h $(INST_LIBDIR)/Imager/include/imio.h \
	  lib/Imager/Engines.pod $(INST_LIBDIR)/Imager/Engines.pod \
	  lib/Imager/Font/FreeType2.pm $(INST_LIBDIR)/Imager/Font/FreeType2.pm \
	  lib/Imager/Font/Image.pm $(INST_LIBDIR)/Imager/Font/Image.pm \
	  typemap $(INST_LIBDIR)/Imager/typemap \
	  lib/Imager/Color/Table.pm $(INST_LIBDIR)/Imager/Color/Table.pm \
	  lib/Imager/Font/Wrap.pm $(INST_LIBDIR)/Imager/Font/Wrap.pm \
	  lib/Imager/Fountain.pm $(INST_LIBDIR)/Imager/Fountain.pm \
	  lib/Imager/Tutorial.pod $(INST_LIBDIR)/Imager/Tutorial.pod \
	  lib/Imager/Threads.pod $(INST_LIBDIR)/Imager/Threads.pod \
	  rendert.h $(INST_LIBDIR)/Imager/include/rendert.h \
	  lib/Imager/APIRef.pod $(INST_LIBDIR)/Imager/APIRef.pod \
	  lib/Imager/Draw.pod $(INST_LIBDIR)/Imager/Draw.pod \
	  imextpltypes.h $(INST_LIBDIR)/Imager/include/imextpltypes.h \
	  imperl.h $(INST_LIBDIR)/Imager/include/imperl.h \
	  Imager.pm $(INST_LIBDIR)/Imager.pm \
	  lib/Imager/Color/Float.pm $(INST_LIBDIR)/Imager/Color/Float.pm \
	  lib/Imager/ImageTypes.pod $(INST_LIBDIR)/Imager/ImageTypes.pod \
	  lib/Imager/Filters.pod $(INST_LIBDIR)/Imager/Filters.pod \
	  lib/Imager/API.pod $(INST_LIBDIR)/Imager/API.pod \
	  log.h $(INST_LIBDIR)/Imager/include/log.h \
	  lib/Imager/Install.pod $(INST_LIBDIR)/Imager/Install.pod \
	  imext.h $(INST_LIBDIR)/Imager/include/imext.h \
	  lib/Imager/Cookbook.pod $(INST_LIBDIR)/Imager/Cookbook.pod \
	  lib/Imager/regmach.pod $(INST_LIBDIR)/Imager/regmach.pod \
	  imperlio.h $(INST_LIBDIR)/Imager/include/imperlio.h \
	  plug.h $(INST_LIBDIR)/Imager/include/plug.h \
	  ppport.h $(INST_LIBDIR)/Imager/include/ppport.h \
	  imextpl.h $(INST_LIBDIR)/Imager/include/imextpl.h \
	  lib/Imager/Expr.pm $(INST_LIBDIR)/Imager/Expr.pm \
	  lib/Imager/Security.pod $(INST_LIBDIR)/Imager/Security.pod \
	  iolayer.h $(INST_LIBDIR)/Imager/include/iolayer.h \
	  ext.h $(INST_LIBDIR)/Imager/include/ext.h \
	  lib/Imager/IO.pod $(INST_LIBDIR)/Imager/IO.pod \
	  lib/Imager/interface.pod $(INST_LIBDIR)/Imager/interface.pod \
	  lib/Imager/Color.pm $(INST_LIBDIR)/Imager/Color.pm \
	  lib/Imager/Matrix2d.pm $(INST_LIBDIR)/Imager/Matrix2d.pm \
	  imconfig.h $(INST_LIBDIR)/Imager/include/imconfig.h \
	  lib/Imager/Handy.pod $(INST_LIBDIR)/Imager/Handy.pod \
	  lib/Imager/Probe.pm $(INST_LIBDIR)/Imager/Probe.pm \
	  feat.h $(INST_LIBDIR)/Imager/include/feat.h \
	  dynaload.h $(INST_LIBDIR)/Imager/include/dynaload.h \
	  lib/Imager/Files.pod $(INST_LIBDIR)/Imager/Files.pod \
	  stackmach.h $(INST_LIBDIR)/Imager/include/stackmach.h \
	  lib/Imager/Fill.pm $(INST_LIBDIR)/Imager/Fill.pm \
	  imageri.h $(INST_LIBDIR)/Imager/include/imageri.h \
	  lib/Imager/Font/Test.pm $(INST_LIBDIR)/Imager/Font/Test.pm \
	  imexttypes.h $(INST_LIBDIR)/Imager/include/imexttypes.h \
	  lib/Imager/Regops.pm $(INST_LIBDIR)/Imager/Regops.pm \
	  lib/Imager/Font/Type1.pm $(INST_LIBDIR)/Imager/Font/Type1.pm \
	  lib/Imager/Transform.pm $(INST_LIBDIR)/Imager/Transform.pm \
	  lib/Imager/Expr/Assem.pm $(INST_LIBDIR)/Imager/Expr/Assem.pm \
	  lib/Imager/Test.pm $(INST_LIBDIR)/Imager/Test.pm \
	  draw.h $(INST_LIBDIR)/Imager/include/draw.h \
	  lib/Imager/Inline.pod $(INST_LIBDIR)/Imager/Inline.pod \
	  lib/Imager/Font.pm $(INST_LIBDIR)/Imager/Font.pm \
	  imerror.h $(INST_LIBDIR)/Imager/include/imerror.h \
	  imager.h $(INST_LIBDIR)/Imager/include/imager.h \
	  imextdef.h $(INST_LIBDIR)/Imager/include/imextdef.h \
	  lib/Imager/Font/BBox.pm $(INST_LIBDIR)/Imager/Font/BBox.pm \
	  lib/Imager/Font/Truetype.pm $(INST_LIBDIR)/Imager/Font/Truetype.pm \
	  lib/Imager/Preprocess.pm $(INST_LIBDIR)/Imager/Preprocess.pm \
	  immacros.h $(INST_LIBDIR)/Imager/include/immacros.h \
	  regmach.h $(INST_LIBDIR)/Imager/include/regmach.h \
	  imdatatypes.h $(INST_LIBDIR)/Imager/include/imdatatypes.h \
	  lib/Imager/LargeSamples.pod $(INST_LIBDIR)/Imager/LargeSamples.pod \
	  imrender.h $(INST_LIBDIR)/Imager/include/imrender.h \
	  lib/Imager/ExtUtils.pm $(INST_LIBDIR)/Imager/ExtUtils.pm \
	  iolayert.h $(INST_LIBDIR)/Imager/include/iolayert.h \
	  lib/Imager/Transformations.pod $(INST_LIBDIR)/Imager/Transformations.pod 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:

dyntest.$(MYEXTLIB) : dynfilt/Makefile
	cd dynfilt && $(MAKE) $(PASTHRU)

lib/Imager/Regops.pm : regmach.h regops.perl
	$(PERL) regops.perl regmach.h lib/Imager/Regops.pm

imconfig.h : Makefile.PL
	$(ECHO) "imconfig.h out-of-date with respect to $?"
	$(PERLRUN) Makefile.PL
	$(ECHO) "==> Your Makefile has been rebuilt - re-run your make command <=="

lib/Imager/APIRef.pod : $(C_FILES) $(H_FILES) apidocs.perl
	$(PERLRUN) apidocs.perl lib/Imager/APIRef.pod


conv.c: conv.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess conv.im conv.c


compose.c: compose.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess compose.im compose.c


combine.c: combine.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess combine.im combine.c


render.c: render.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess render.im render.c


filters.c: filters.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess filters.im filters.c


flip.c: flip.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess flip.im flip.c


convert.c: convert.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess convert.im convert.c


paste.c: paste.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess paste.im paste.c


gaussian.c: gaussian.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess gaussian.im gaussian.c


scale.c: scale.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess scale.im scale.c


rotate.c: rotate.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess rotate.im rotate.c


rubthru.c: rubthru.im lib/Imager/Preprocess.pm
	$(PERLRUN) -Ilib -MImager::Preprocess -epreprocess rubthru.im rubthru.c



# End.

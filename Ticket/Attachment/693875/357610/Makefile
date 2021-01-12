# This Makefile is for the ExtUtils::MakeMaker extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.54 (Revision: 65400) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: (q[INSTALL_BASE=/home/nagios/CPAN], q[INSTALLARCHLIB=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64], q[INSTALLSITEARCH=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64], q[VENDORARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64], q[VENDORLIBEXP=/home/nagios/CPAN/lib/perl5], q[SITEARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64], q[SITELIBEXP=/home/nagios/CPAN/lib/perl5], q[INSTALLPRIVLIB=/home/nagios/CPAN/lib/perl5], q[INSTALLBIN=/home/nagios/CPAN/bin], q[INSTALLSCRIPT=/home/nagios/CPAN/bin], q[INSTALLMAN1DIR=/home/nagios/CPAN/man/man1], q[INSTALLMAN3DIR=/home/nagios/CPAN/man/man3], q[INSTALLHTMLDIR=none], q[INSTALLHTML1DIR=none], q[INSTALLHTML3DIR=none])
#
#   MakeMaker Parameters:

#     ABSTRACT_FROM => q[lib/ExtUtils/MakeMaker.pm]
#     AUTHOR => q[Michael G Schwern <schwern@pobox.com>]
#     CONFIGURE_REQUIRES => {  }
#     EXE_FILES => [q[bin/instmodsh]]
#     INSTALLDIRS => q[perl]
#     LICENSE => q[perl]
#     META_ADD => { build_requires=>{  } }
#     META_MERGE => { resources=>{ repository=>q[http://github.com/schwern/extutils-makemaker], homepage=>q[http://makemaker.org], MailingList=>q[makemaker@perl.org], bugtracker=>q[http://rt.cpan.org/NoAuth/Bugs.html?Dist=ExtUtils-MakeMaker], license=>q[http://dev.perl.org/licenses/] }, no_index=>{ package=>[q[DynaLoader], q[in]] } }
#     MIN_PERL_VERSION => q[5.006]
#     NAME => q[ExtUtils::MakeMaker]
#     PMLIBDIRS => [q[lib], q[inc]]
#     PMLIBPARENTDIRS => [q[lib], q[inc]]
#     PREREQ_PM => { Pod::Man=>q[0], File::Spec=>q[0.8], File::Basename=>q[0], DirHandle=>q[0] }
#     VERSION_FROM => q[lib/ExtUtils/MakeMaker.pm]

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /opt/perl5/lib/5.8.0/PA-RISC2.0-LP64/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = +Z
CCDLFLAGS = -Wl,-E -Wl,-B,deferred 
DLEXT = sl
DLSRC = dl_hpux.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -b +vnocompatwarnings -L/usr/local/lib -L/lib/pa20_64
LDFLAGS =  +DD64 -L/usr/local/lib -L/lib/pa20_64
LIBC = /lib/pa20_64/libc.sl
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = hpux
OSVERS = 11.11
RANLIB = :
SITELIBEXP = /home/nagios/CPAN/lib/perl5
SITEARCHEXP = /home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64
SO = sl
VENDORARCHEXP = /home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64
VENDORLIBEXP = /home/nagios/CPAN/lib/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = ExtUtils::MakeMaker
NAME_SYM = ExtUtils_MakeMaker
VERSION = 6.54
VERSION_MACRO = VERSION
VERSION_SYM = 6_54
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 6.54
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
INSTALLDIRS = perl
INSTALL_BASE = /home/nagios/CPAN
DESTDIR = 
PREFIX = $(INSTALL_BASE)
INSTALLPRIVLIB = /home/nagios/CPAN/lib/perl5
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = /home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = /home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(INSTALL_BASE)/lib/perl5/PA-RISC2.0-LP64
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = /home/nagios/CPAN/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(INSTALL_BASE)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(INSTALL_BASE)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = /home/nagios/CPAN/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = /home/nagios/CPAN/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = /home/nagios/CPAN/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /opt/perl5/lib/5.8.0
PERL_ARCHLIB = /opt/perl5/lib/5.8.0/PA-RISC2.0-LP64
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /opt/perl5/lib/5.8.0/PA-RISC2.0-LP64/CORE
PERL = /opt/perl5/bin/perl
FULLPERL = /opt/perl5/bin/perl
ABSPERL = $(PERL)
PERLRUN = $(PERL) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUN = $(FULLPERL) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUN = $(ABSPERL) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = lib/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.54
MM_REVISION = 65400

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = ExtUtils/MakeMaker
BASEEXT = MakeMaker
PARENT_NAME = ExtUtils
DLBASE = $(BASEEXT)
VERSION_FROM = lib/ExtUtils/MakeMaker.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = bin/instmodsh
MAN3PODS = lib/ExtUtils/Command/MM.pm \
	lib/ExtUtils/Liblist.pm \
	lib/ExtUtils/MM.pm \
	lib/ExtUtils/MM_AIX.pm \
	lib/ExtUtils/MM_Any.pm \
	lib/ExtUtils/MM_BeOS.pm \
	lib/ExtUtils/MM_Cygwin.pm \
	lib/ExtUtils/MM_DOS.pm \
	lib/ExtUtils/MM_Darwin.pm \
	lib/ExtUtils/MM_MacOS.pm \
	lib/ExtUtils/MM_NW5.pm \
	lib/ExtUtils/MM_OS2.pm \
	lib/ExtUtils/MM_QNX.pm \
	lib/ExtUtils/MM_UWIN.pm \
	lib/ExtUtils/MM_Unix.pm \
	lib/ExtUtils/MM_VMS.pm \
	lib/ExtUtils/MM_VOS.pm \
	lib/ExtUtils/MM_Win32.pm \
	lib/ExtUtils/MM_Win95.pm \
	lib/ExtUtils/MY.pm \
	lib/ExtUtils/MakeMaker.pm \
	lib/ExtUtils/MakeMaker/Config.pm \
	lib/ExtUtils/MakeMaker/FAQ.pod \
	lib/ExtUtils/MakeMaker/Tutorial.pod \
	lib/ExtUtils/Mkbootstrap.pm \
	lib/ExtUtils/Mksymlists.pm \
	lib/ExtUtils/testlib.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)/ExtUtils
INST_ARCHLIBDIR  = $(INST_ARCHLIB)/ExtUtils

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/ExtUtils/Command/MM.pm \
	lib/ExtUtils/Liblist.pm \
	lib/ExtUtils/Liblist/Kid.pm \
	lib/ExtUtils/MM.pm \
	lib/ExtUtils/MM_AIX.pm \
	lib/ExtUtils/MM_Any.pm \
	lib/ExtUtils/MM_BeOS.pm \
	lib/ExtUtils/MM_Cygwin.pm \
	lib/ExtUtils/MM_DOS.pm \
	lib/ExtUtils/MM_Darwin.pm \
	lib/ExtUtils/MM_MacOS.pm \
	lib/ExtUtils/MM_NW5.pm \
	lib/ExtUtils/MM_OS2.pm \
	lib/ExtUtils/MM_QNX.pm \
	lib/ExtUtils/MM_UWIN.pm \
	lib/ExtUtils/MM_Unix.pm \
	lib/ExtUtils/MM_VMS.pm \
	lib/ExtUtils/MM_VOS.pm \
	lib/ExtUtils/MM_Win32.pm \
	lib/ExtUtils/MM_Win95.pm \
	lib/ExtUtils/MY.pm \
	lib/ExtUtils/MakeMaker.pm \
	lib/ExtUtils/MakeMaker/Config.pm \
	lib/ExtUtils/MakeMaker/FAQ.pod \
	lib/ExtUtils/MakeMaker/Tutorial.pod \
	lib/ExtUtils/Mkbootstrap.pm \
	lib/ExtUtils/Mksymlists.pm \
	lib/ExtUtils/testlib.pm

PM_TO_BLIB = lib/ExtUtils/MM_VOS.pm \
	blib/lib/ExtUtils/MM_VOS.pm \
	lib/ExtUtils/Mksymlists.pm \
	blib/lib/ExtUtils/Mksymlists.pm \
	lib/ExtUtils/MM.pm \
	blib/lib/ExtUtils/MM.pm \
	lib/ExtUtils/MM_UWIN.pm \
	blib/lib/ExtUtils/MM_UWIN.pm \
	lib/ExtUtils/testlib.pm \
	blib/lib/ExtUtils/testlib.pm \
	lib/ExtUtils/MM_DOS.pm \
	blib/lib/ExtUtils/MM_DOS.pm \
	lib/ExtUtils/MM_Cygwin.pm \
	blib/lib/ExtUtils/MM_Cygwin.pm \
	lib/ExtUtils/MM_Win95.pm \
	blib/lib/ExtUtils/MM_Win95.pm \
	lib/ExtUtils/Liblist.pm \
	blib/lib/ExtUtils/Liblist.pm \
	lib/ExtUtils/MM_AIX.pm \
	blib/lib/ExtUtils/MM_AIX.pm \
	lib/ExtUtils/MM_Darwin.pm \
	blib/lib/ExtUtils/MM_Darwin.pm \
	lib/ExtUtils/Liblist/Kid.pm \
	blib/lib/ExtUtils/Liblist/Kid.pm \
	lib/ExtUtils/Mkbootstrap.pm \
	blib/lib/ExtUtils/Mkbootstrap.pm \
	lib/ExtUtils/MakeMaker/FAQ.pod \
	blib/lib/ExtUtils/MakeMaker/FAQ.pod \
	lib/ExtUtils/MM_NW5.pm \
	blib/lib/ExtUtils/MM_NW5.pm \
	lib/ExtUtils/MakeMaker.pm \
	blib/lib/ExtUtils/MakeMaker.pm \
	lib/ExtUtils/MM_OS2.pm \
	blib/lib/ExtUtils/MM_OS2.pm \
	lib/ExtUtils/MM_Unix.pm \
	blib/lib/ExtUtils/MM_Unix.pm \
	lib/ExtUtils/MM_Win32.pm \
	blib/lib/ExtUtils/MM_Win32.pm \
	lib/ExtUtils/MY.pm \
	blib/lib/ExtUtils/MY.pm \
	lib/ExtUtils/MM_MacOS.pm \
	blib/lib/ExtUtils/MM_MacOS.pm \
	lib/ExtUtils/MM_VMS.pm \
	blib/lib/ExtUtils/MM_VMS.pm \
	lib/ExtUtils/MM_BeOS.pm \
	blib/lib/ExtUtils/MM_BeOS.pm \
	lib/ExtUtils/MakeMaker/Tutorial.pod \
	blib/lib/ExtUtils/MakeMaker/Tutorial.pod \
	lib/ExtUtils/MM_QNX.pm \
	blib/lib/ExtUtils/MM_QNX.pm \
	lib/ExtUtils/Command/MM.pm \
	blib/lib/ExtUtils/Command/MM.pm \
	lib/ExtUtils/MakeMaker/Config.pm \
	blib/lib/ExtUtils/MakeMaker/Config.pm \
	lib/ExtUtils/MM_Any.pm \
	blib/lib/ExtUtils/MM_Any.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.54
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


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
DISTNAME = ExtUtils-MakeMaker
DISTVNAME = ExtUtils-MakeMaker-6.54


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"\
	INSTALL_BASE="$(INSTALL_BASE)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

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

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	bin/instmodsh \
	lib/ExtUtils/MakeMaker.pm \
	lib/ExtUtils/MM_OS2.pm \
	lib/ExtUtils/MM_VOS.pm \
	lib/ExtUtils/MM_Unix.pm \
	lib/ExtUtils/Mksymlists.pm \
	lib/ExtUtils/MM.pm \
	lib/ExtUtils/MM_Win32.pm \
	lib/ExtUtils/MM_UWIN.pm \
	lib/ExtUtils/testlib.pm \
	lib/ExtUtils/MM_Cygwin.pm \
	lib/ExtUtils/MM_DOS.pm \
	lib/ExtUtils/MY.pm \
	lib/ExtUtils/MM_MacOS.pm \
	lib/ExtUtils/MM_VMS.pm \
	lib/ExtUtils/MM_Win95.pm \
	lib/ExtUtils/MM_BeOS.pm \
	lib/ExtUtils/Liblist.pm \
	lib/ExtUtils/MM_Darwin.pm \
	lib/ExtUtils/MM_AIX.pm \
	lib/ExtUtils/MakeMaker/Tutorial.pod \
	lib/ExtUtils/Mkbootstrap.pm \
	lib/ExtUtils/MakeMaker/FAQ.pod \
	lib/ExtUtils/MM_QNX.pm \
	lib/ExtUtils/Command/MM.pm \
	lib/ExtUtils/MakeMaker/Config.pm \
	lib/ExtUtils/MM_NW5.pm \
	lib/ExtUtils/MM_Any.pm
	$(NOECHO) $(POD2MAN) --section=1 --perm_rw=$(PERM_RW) \
	  bin/instmodsh $(INST_MAN1DIR)/instmodsh.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/ExtUtils/MakeMaker.pm $(INST_MAN3DIR)/ExtUtils::MakeMaker.$(MAN3EXT) \
	  lib/ExtUtils/MM_OS2.pm $(INST_MAN3DIR)/ExtUtils::MM_OS2.$(MAN3EXT) \
	  lib/ExtUtils/MM_VOS.pm $(INST_MAN3DIR)/ExtUtils::MM_VOS.$(MAN3EXT) \
	  lib/ExtUtils/MM_Unix.pm $(INST_MAN3DIR)/ExtUtils::MM_Unix.$(MAN3EXT) \
	  lib/ExtUtils/Mksymlists.pm $(INST_MAN3DIR)/ExtUtils::Mksymlists.$(MAN3EXT) \
	  lib/ExtUtils/MM.pm $(INST_MAN3DIR)/ExtUtils::MM.$(MAN3EXT) \
	  lib/ExtUtils/MM_Win32.pm $(INST_MAN3DIR)/ExtUtils::MM_Win32.$(MAN3EXT) \
	  lib/ExtUtils/MM_UWIN.pm $(INST_MAN3DIR)/ExtUtils::MM_UWIN.$(MAN3EXT) \
	  lib/ExtUtils/testlib.pm $(INST_MAN3DIR)/ExtUtils::testlib.$(MAN3EXT) \
	  lib/ExtUtils/MM_Cygwin.pm $(INST_MAN3DIR)/ExtUtils::MM_Cygwin.$(MAN3EXT) \
	  lib/ExtUtils/MM_DOS.pm $(INST_MAN3DIR)/ExtUtils::MM_DOS.$(MAN3EXT) \
	  lib/ExtUtils/MY.pm $(INST_MAN3DIR)/ExtUtils::MY.$(MAN3EXT) \
	  lib/ExtUtils/MM_MacOS.pm $(INST_MAN3DIR)/ExtUtils::MM_MacOS.$(MAN3EXT) \
	  lib/ExtUtils/MM_VMS.pm $(INST_MAN3DIR)/ExtUtils::MM_VMS.$(MAN3EXT) \
	  lib/ExtUtils/MM_Win95.pm $(INST_MAN3DIR)/ExtUtils::MM_Win95.$(MAN3EXT) \
	  lib/ExtUtils/MM_BeOS.pm $(INST_MAN3DIR)/ExtUtils::MM_BeOS.$(MAN3EXT) \
	  lib/ExtUtils/Liblist.pm $(INST_MAN3DIR)/ExtUtils::Liblist.$(MAN3EXT) \
	  lib/ExtUtils/MM_Darwin.pm $(INST_MAN3DIR)/ExtUtils::MM_Darwin.$(MAN3EXT) \
	  lib/ExtUtils/MM_AIX.pm $(INST_MAN3DIR)/ExtUtils::MM_AIX.$(MAN3EXT) \
	  lib/ExtUtils/MakeMaker/Tutorial.pod $(INST_MAN3DIR)/ExtUtils::MakeMaker::Tutorial.$(MAN3EXT) \
	  lib/ExtUtils/Mkbootstrap.pm $(INST_MAN3DIR)/ExtUtils::Mkbootstrap.$(MAN3EXT) \
	  lib/ExtUtils/MakeMaker/FAQ.pod $(INST_MAN3DIR)/ExtUtils::MakeMaker::FAQ.$(MAN3EXT) \
	  lib/ExtUtils/MM_QNX.pm $(INST_MAN3DIR)/ExtUtils::MM_QNX.$(MAN3EXT) \
	  lib/ExtUtils/Command/MM.pm $(INST_MAN3DIR)/ExtUtils::Command::MM.$(MAN3EXT) \
	  lib/ExtUtils/MakeMaker/Config.pm $(INST_MAN3DIR)/ExtUtils::MakeMaker::Config.$(MAN3EXT) \
	  lib/ExtUtils/MM_NW5.pm $(INST_MAN3DIR)/ExtUtils::MM_NW5.$(MAN3EXT) \
	  lib/ExtUtils/MM_Any.pm $(INST_MAN3DIR)/ExtUtils::MM_Any.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = bin/instmodsh

pure_all :: $(INST_SCRIPT)/instmodsh
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/instmodsh 

$(INST_SCRIPT)/instmodsh : bin/instmodsh $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/instmodsh
	$(CP) bin/instmodsh $(INST_SCRIPT)/instmodsh
	$(FIXIN) $(INST_SCRIPT)/instmodsh
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/instmodsh



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  *$(LIB_EXT) core \
	  core.[0-9] $(INST_ARCHAUTODIR)/extralibs.all \
	  core.[0-9][0-9] $(BASEEXT).bso \
	  pm_to_blib.ts core.[0-9][0-9][0-9][0-9] \
	  $(BASEEXT).x $(BOOTSTRAP) \
	  perl$(EXE_EXT) tmon.out \
	  *$(OBJ_EXT) pm_to_blib \
	  $(INST_ARCHAUTODIR)/extralibs.ld blibdirs.ts \
	  core.[0-9][0-9][0-9][0-9][0-9] *perl.core \
	  core.*perl.*.? $(MAKE_APERL_FILE) \
	  perl $(BASEEXT).def \
	  core.[0-9][0-9][0-9] mon.out \
	  perlmain.c perl.exe \
	  lib$(BASEEXT).def so_locations \
	  $(BASEEXT).exp 
	- $(RM_RF) \
	  blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile : create_distdir
	$(NOECHO) $(ECHO) Generating META.yml
	$(NOECHO) $(ECHO) '--- #YAML:1.0' > META_new.yml
	$(NOECHO) $(ECHO) 'name:               ExtUtils-MakeMaker' >> META_new.yml
	$(NOECHO) $(ECHO) 'version:            6.54' >> META_new.yml
	$(NOECHO) $(ECHO) 'abstract:           Create a module Makefile' >> META_new.yml
	$(NOECHO) $(ECHO) 'author:' >> META_new.yml
	$(NOECHO) $(ECHO) '    - Michael G Schwern <schwern@pobox.com>' >> META_new.yml
	$(NOECHO) $(ECHO) 'license:            perl' >> META_new.yml
	$(NOECHO) $(ECHO) 'distribution_type:  module' >> META_new.yml
	$(NOECHO) $(ECHO) 'configure_requires:  {}' >> META_new.yml
	$(NOECHO) $(ECHO) 'build_requires:  {}' >> META_new.yml
	$(NOECHO) $(ECHO) 'requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '    DirHandle:       0' >> META_new.yml
	$(NOECHO) $(ECHO) '    File::Basename:  0' >> META_new.yml
	$(NOECHO) $(ECHO) '    File::Spec:      0.8' >> META_new.yml
	$(NOECHO) $(ECHO) '    perl:            5.006' >> META_new.yml
	$(NOECHO) $(ECHO) '    Pod::Man:        0' >> META_new.yml
	$(NOECHO) $(ECHO) 'resources:' >> META_new.yml
	$(NOECHO) $(ECHO) '    bugtracker:   http://rt.cpan.org/NoAuth/Bugs.html?Dist=ExtUtils-MakeMaker' >> META_new.yml
	$(NOECHO) $(ECHO) '    homepage:     http://makemaker.org' >> META_new.yml
	$(NOECHO) $(ECHO) '    license:      http://dev.perl.org/licenses/' >> META_new.yml
	$(NOECHO) $(ECHO) '    MailingList:  makemaker@perl.org' >> META_new.yml
	$(NOECHO) $(ECHO) '    repository:   http://github.com/schwern/extutils-makemaker' >> META_new.yml
	$(NOECHO) $(ECHO) 'no_index:' >> META_new.yml
	$(NOECHO) $(ECHO) '    directory:' >> META_new.yml
	$(NOECHO) $(ECHO) '        - t' >> META_new.yml
	$(NOECHO) $(ECHO) '        - inc' >> META_new.yml
	$(NOECHO) $(ECHO) '    package:' >> META_new.yml
	$(NOECHO) $(ECHO) '        - DynaLoader' >> META_new.yml
	$(NOECHO) $(ECHO) '        - in' >> META_new.yml
	$(NOECHO) $(ECHO) 'generated_by:       ExtUtils::MakeMaker version 6.54' >> META_new.yml
	$(NOECHO) $(ECHO) 'meta-spec:' >> META_new.yml
	$(NOECHO) $(ECHO) '    url:      http://module-build.sourceforge.net/META-spec-v1.4.html' >> META_new.yml
	$(NOECHO) $(ECHO) '    version:  1.4' >> META_new.yml
	-$(NOECHO) $(MV) META_new.yml $(DISTVNAME)/META.yml


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
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL "INSTALL_BASE=/home/nagios/CPAN" "INSTALLARCHLIB=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "INSTALLSITEARCH=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "VENDORARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "VENDORLIBEXP=/home/nagios/CPAN/lib/perl5" "SITEARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "SITELIBEXP=/home/nagios/CPAN/lib/perl5" "INSTALLPRIVLIB=/home/nagios/CPAN/lib/perl5" "INSTALLBIN=/home/nagios/CPAN/bin" "INSTALLSCRIPT=/home/nagios/CPAN/bin" "INSTALLMAN1DIR=/home/nagios/CPAN/man/man1" "INSTALLMAN3DIR=/home/nagios/CPAN/man/man3" "INSTALLHTMLDIR=none" "INSTALLHTML1DIR=none" "INSTALLHTML3DIR=none"
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
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{META.yml} => q{Module meta-data (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add META.yml to MANIFEST: $${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $${'\''@'\''}\n"' --
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


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL "INSTALL_BASE=/home/nagios/CPAN" "INSTALLARCHLIB=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "INSTALLSITEARCH=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "VENDORARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "VENDORLIBEXP=/home/nagios/CPAN/lib/perl5" "SITEARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64" "SITELIBEXP=/home/nagios/CPAN/lib/perl5" "INSTALLPRIVLIB=/home/nagios/CPAN/lib/perl5" "INSTALLBIN=/home/nagios/CPAN/bin" "INSTALLSCRIPT=/home/nagios/CPAN/bin" "INSTALLMAN1DIR=/home/nagios/CPAN/man/man1" "INSTALLMAN3DIR=/home/nagios/CPAN/man/man3" "INSTALLHTMLDIR=none" "INSTALLHTML1DIR=none" "INSTALLHTML3DIR=none"
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /opt/perl5/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS= \
		INSTALL_BASE=/home/nagios/CPAN \
		INSTALLARCHLIB=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64 \
		INSTALLSITEARCH=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64 \
		VENDORARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64 \
		VENDORLIBEXP=/home/nagios/CPAN/lib/perl5 \
		SITEARCHEXP=/home/nagios/CPAN/lib/perl5/PA-RISC2.0-LP64 \
		SITELIBEXP=/home/nagios/CPAN/lib/perl5 \
		INSTALLPRIVLIB=/home/nagios/CPAN/lib/perl5 \
		INSTALLBIN=/home/nagios/CPAN/bin \
		INSTALLSCRIPT=/home/nagios/CPAN/bin \
		INSTALLMAN1DIR=/home/nagios/CPAN/man/man1 \
		INSTALLMAN3DIR=/home/nagios/CPAN/man/man3 \
		INSTALLHTMLDIR=none \
		INSTALLHTML1DIR=none \
		INSTALLHTML3DIR=none


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="6.54">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Create a module Makefile</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Michael G Schwern &lt;schwern@pobox.com&gt;</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <PERLCORE VERSION="5,006,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DirHandle::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="File::Basename" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="File::Spec" VERSION="0.8" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Pod::Man" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="PA-RISC2.0-LP64-5.8" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/ExtUtils/MM_VOS.pm blib/lib/ExtUtils/MM_VOS.pm \
	  lib/ExtUtils/Mksymlists.pm blib/lib/ExtUtils/Mksymlists.pm \
	  lib/ExtUtils/MM.pm blib/lib/ExtUtils/MM.pm \
	  lib/ExtUtils/MM_UWIN.pm blib/lib/ExtUtils/MM_UWIN.pm \
	  lib/ExtUtils/testlib.pm blib/lib/ExtUtils/testlib.pm \
	  lib/ExtUtils/MM_DOS.pm blib/lib/ExtUtils/MM_DOS.pm \
	  lib/ExtUtils/MM_Cygwin.pm blib/lib/ExtUtils/MM_Cygwin.pm \
	  lib/ExtUtils/MM_Win95.pm blib/lib/ExtUtils/MM_Win95.pm \
	  lib/ExtUtils/Liblist.pm blib/lib/ExtUtils/Liblist.pm \
	  lib/ExtUtils/MM_AIX.pm blib/lib/ExtUtils/MM_AIX.pm \
	  lib/ExtUtils/MM_Darwin.pm blib/lib/ExtUtils/MM_Darwin.pm \
	  lib/ExtUtils/Liblist/Kid.pm blib/lib/ExtUtils/Liblist/Kid.pm \
	  lib/ExtUtils/Mkbootstrap.pm blib/lib/ExtUtils/Mkbootstrap.pm \
	  lib/ExtUtils/MakeMaker/FAQ.pod blib/lib/ExtUtils/MakeMaker/FAQ.pod \
	  lib/ExtUtils/MM_NW5.pm blib/lib/ExtUtils/MM_NW5.pm \
	  lib/ExtUtils/MakeMaker.pm blib/lib/ExtUtils/MakeMaker.pm \
	  lib/ExtUtils/MM_OS2.pm blib/lib/ExtUtils/MM_OS2.pm \
	  lib/ExtUtils/MM_Unix.pm blib/lib/ExtUtils/MM_Unix.pm \
	  lib/ExtUtils/MM_Win32.pm blib/lib/ExtUtils/MM_Win32.pm \
	  lib/ExtUtils/MY.pm blib/lib/ExtUtils/MY.pm \
	  lib/ExtUtils/MM_MacOS.pm blib/lib/ExtUtils/MM_MacOS.pm \
	  lib/ExtUtils/MM_VMS.pm blib/lib/ExtUtils/MM_VMS.pm \
	  lib/ExtUtils/MM_BeOS.pm blib/lib/ExtUtils/MM_BeOS.pm \
	  lib/ExtUtils/MakeMaker/Tutorial.pod blib/lib/ExtUtils/MakeMaker/Tutorial.pod \
	  lib/ExtUtils/MM_QNX.pm blib/lib/ExtUtils/MM_QNX.pm \
	  lib/ExtUtils/Command/MM.pm blib/lib/ExtUtils/Command/MM.pm \
	  lib/ExtUtils/MakeMaker/Config.pm blib/lib/ExtUtils/MakeMaker/Config.pm \
	  lib/ExtUtils/MM_Any.pm blib/lib/ExtUtils/MM_Any.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.

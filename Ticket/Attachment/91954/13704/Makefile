# This Makefile is for the Tk extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.03 (Revision: 1.63) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: (q[BINARY_LOCATION=i386-linux-thread-multi/Tk804.025-PPM.tar.gz])
#
#   MakeMaker Parameters:

#     ABSTRACT => q[Tk - a Graphical User Interface Toolkit]
#     AUTHOR => q[nick@ni-s.u-net.com (Nick Ing-Simmons)]
#     DEFINE => q[]
#     DIR => [q[pTk], q[pod], q[demos], q[Xlib], q[WinPhoto], q[Tixish], q[TixPixmap], q[TixGrid], q[TextList], q[Text], q[TList], q[Scrollbar], q[Scale], q[PNG], q[NBFrame], q[Mwm], q[Menubutton], q[Listbox], q[JPEG], q[InputO], q[IO], q[HList], q[Event], q[Entry], q[DragDrop], q[Compound], q[Canvas]]
#     DISTNAME => q[Tk]
#     EXE_FILES => [q[ptksh], q[ptked], q[gedi]]
#     INC => q[-I/usr/X11R6/include]
#     LIBS => [q[-L/usr/X11R6/lib -lX11 -lnsl -lm]]
#     MYEXTLIB => q[pTk/libpTk$(LIB_EXT)]
#     NAME => q[Tk]
#     OBJECT => q[$(O_FILES)]
#     TYPEMAPS => [q[/home/Downloads/asterisk/Tk-804.025_beta6/Tk/typemap]]
#     VERSION => q[804.025]
#     XS_VERSION => q[804.025]
#     clean => { FILES=>q[pTk/tkConfig.h Tk/Config.pm *.bak] }
#     macro => { WINARCH=>q[x], TKDIR=>q[.] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/perl5/5.8.0/i386-linux-thread-multi/Config.pm)

# They may have been overridden via Makefile.PL or on the command line
AR = ar
CC = gcc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -rdynamic -Wl,-rpath,/usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE
DLEXT = so
DLSRC = dl_dlopen.xs
LD = gcc
LDDLFLAGS = -shared -L/usr/local/lib
LDFLAGS =  -L/usr/local/lib
LIBC = /lib/libc-2.3.1.so
LIB_EXT = .a'
libc='
OBJ_EXT = ub
OSNAME = linux
OSVERS = 2.4.20-2.48smp
RANLIB = _
SO = so
EXE_EXT = 
FULL_AR = /usr/bin/ar


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
NAME = Tk
DISTNAME = Tk
NAME_SYM = Tk
VERSION = 804.025
VERSION_SYM = 804_025
XS_VERSION = 804.025
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INSTALLDIRS = site
PREFIX = /usr
SITEPREFIX = /usr
VENDORPREFIX = /usr
INSTALLPRIVLIB = /usr/lib/perl5/5.8.0
INSTALLSITELIB = /usr/lib/perl5/site_perl/5.8.0'
installsiteman1='/usr/share/man/man1'
installsiteman3='/usr/share/man/man3'
installsitescript='/usr/bin'
installstyle='lib/perl5'
installusrbinperl='define'
installvendorarch='/usr/lib/perl5/vendor_perl/5.8.0/i386-linux-thread-multi'
installvendorbin='/usr/bin'
installvendorhtml1=''
installvendorhtml3=''
installvendorlib='/usr/lib/perl5/vendor_perl/5.8.
INSTALLVENDORLIB = ib/perl5'
installusrbinperl='def
INSTALLARCHLIB = /usr/lib/perl5/5.8.0/i386-linux-thread-multi
INSTALLSITEARCH = 
INSTALLVENDORARCH = /usr/lib/perl5/vendor_perl/5.8
INSTALLBIN = /usr/bin'
installhtml1dir=''
installhtml3dir=''
installman1
INSTALLSITEBIN = /usr
INSTALLVENDORBIN = /usr/bin'
installvendorhtml1=''
installvendorhtml3=''
installvendorlib='/u
INSTALLSCRIPT = /usr/bin
PERL_LIB = /usr/lib/perl5/5.8.0
PERL_ARCHLIB = /usr/lib/perl5/5.8.0/i386-linux-thread-multi
SITELIBEXP = '/usr/lib/perl5/site_perl'
sit
SITEARCHEXP = /usr/lib/pe
LIBPERL_A = libperl.a'
libc='
MYEXTLIB = pTk/libpTk$(LIB_EXT)
FIRST_MAKEFILE = Makefile
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE
PERL = /usr/bin/perl
FULLPERL = /usr/bin/perl
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERL = $(PERL)
ABSPERLRUN = $(ABSPERL)
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULL_AR = /usr/bin/ar
PERL_CORE = 0
NOOP = $(SHELL) -c true
NOECHO = @

VERSION_MACRO = VERSION
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc

MAKEMAKER = /usr/lib/perl5/5.8.0/ExtUtils/MakeMaker.pm
MM_VERSION = 6.03

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
FULLEXT = Tk
BASEEXT = Tk
PARENT_NAME = 
DLBASE = $(BASEEXT)
INC = -I/usr/X11R6/include
DEFINE = 
OBJECT = $(O_FILES)
LDFROM = $(OBJECT)
LINKTYPE = dynamic

# Handy lists of source code files:
XS_FILES= Tk.xs
C_FILES = Tk.c \
	chnGlue.c \
	encGlue.c \
	evtGlue.c \
	objGlue.c \
	tixGlue.c \
	tkGlue.c \
	tkGlue_f.c \
	tkWin32Dll.c
O_FILES = Tkub \
	chnGlueub \
	encGlueub \
	evtGlueub \
	objGlueub \
	tixGlueub \
	tkGlueub \
	tkGlue_fub \
	tkWin32Dllub
H_FILES = tkGlue.h \
	tkGlue_f.h
MAN1PODS = 
MAN3PODS = Tk.pod \
	Tk/Adjuster.pm \
	Tk/Animation.pm \
	Tk/CmdLine.pm \
	Tk/ColorEditor.pm \
	Tk/Dialog.pm \
	Tk/FileSelect.pm \
	Tk/MainWindow.pm \
	Tk/Menu/Item.pm \
	Tk/Optionmenu.pm \
	Tk/Pane.pm \
	Tk/ProgressBar.pm \
	Tk/Submethods.pm \
	Tk/Table.pm \
	Tk/Trace.pm \
	Tk/Widget.pm \
	Tk/Xrm.pm \
	Tk/widgets.pm \
	lib/Tie/Watch.pm
INST_MAN1DIR = blib/man1
MAN1EXT = 
INSTALLMAN1DIR = none
INSTALLSITEMAN1DIR = /usr/share/man/man1
INSTALLVENDORMAN1DIR = /usr/share/man/man1
INST_MAN3DIR = blib/man3
MAN3EXT = 3pm
INSTALLMAN3DIR = /usr/share/man/man3
INSTALLSITEMAN3DIR = /usr/share/man/man3
INSTALLVENDORMAN3DIR = /usr/share/man/man3
PERM_RW = 644
PERM_RWX = 755

# work around a famous dec-osf make(1) feature(?):
makemakerdflt: all

.SUFFIXES:
.SUFFIXES: .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

# Nick wanted to get rid of .PRECIOUS. I don't remember why. I seem to recall, that
# some make implementations will delete the Makefile when we rebuild it. Because
# we call false(1) when we rebuild it. So make(1) is not completely wrong when it
# does so. Our milage may vary.
# .PRECIOUS: Makefile    # seems to be not necessary anymore

.PHONY: all config static dynamic test linkext manifest

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)/Config.pm $(PERL_INC)/config.h

# Where to put things:
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC  = $(INST_ARCHAUTODIR)/$(BASEEXT)$(LIB_EXT)
INST_DYNAMIC = $(INST_ARCHAUTODIR)/$(DLBASE).$(DLEXT)
INST_BOOT    = $(INST_ARCHAUTODIR)/$(BASEEXT).bs

EXPORT_LIST = 

PERL_ARCHIVE = 

PERL_ARCHIVE_AFTER = 

TO_INST_PM = Tk.pm \
	Tk.pod \
	Tk/Adjuster.pm \
	Tk/After.pm \
	Tk/Animation.pm \
	Tk/Bitmap.pm \
	Tk/Button.pm \
	Tk/Camel.xpm \
	Tk/Checkbutton.pm \
	Tk/Clipboard.pm \
	Tk/CmdLine.pm \
	Tk/ColorEdit.xpm \
	Tk/ColorEditor.pm \
	Tk/Config.pm \
	Tk/Configure.pm \
	Tk/Credits \
	Tk/Derived.pm \
	Tk/Dialog.pm \
	Tk/Dirlist.pm \
	Tk/DummyEncode.pm \
	Tk/English.pm \
	Tk/ErrorDialog.pm \
	Tk/FBox.pm \
	Tk/FileSelect.pm \
	Tk/Font.pm \
	Tk/Frame.pm \
	Tk/IconList.pm \
	Tk/Image.pm \
	Tk/ItemStyle.pm \
	Tk/LabEntry.pm \
	Tk/LabRadio.pm \
	Tk/Label.pm \
	Tk/Labelframe.pm \
	Tk/MMtry.pm \
	Tk/MMutil.pm \
	Tk/MainWindow.pm \
	Tk/MakeDepend.pm \
	Tk/Menu.pm \
	Tk/Menu/Item.pm \
	Tk/Menubar.pm \
	Tk/Message.pm \
	Tk/Optionmenu.pm \
	Tk/Pane.pm \
	Tk/Panedwindow.pm \
	Tk/Photo.pm \
	Tk/Pretty.pm \
	Tk/ProgressBar.pm \
	Tk/README.Adjust \
	Tk/ROText.pm \
	Tk/Radiobutton.pm \
	Tk/Region.pm \
	Tk/Spinbox.pm \
	Tk/Stats.pm \
	Tk/Submethods.pm \
	Tk/Table.pm \
	Tk/TextEdit.pm \
	Tk/TextUndo.pm \
	Tk/Tiler.pm \
	Tk/Tk.xbm \
	Tk/Tk.xpm \
	Tk/Toplevel.pm \
	Tk/Trace.pm \
	Tk/Widget.pm \
	Tk/Wm.pm \
	Tk/X11Font.pm \
	Tk/Xcamel.gif \
	Tk/Xrm.pm \
	Tk/act_folder.xbm \
	Tk/act_folder.xpm \
	Tk/anim.gif \
	Tk/arrowdownwin.xbm \
	Tk/cbxarrow.xbm \
	Tk/file.xbm \
	Tk/file.xpm \
	Tk/folder.xbm \
	Tk/folder.xpm \
	Tk/icon.gif \
	Tk/install.pm \
	Tk/license.terms \
	Tk/openfile.xbm \
	Tk/openfolder.xbm \
	Tk/openfolder.xpm \
	Tk/prolog.ps \
	Tk/srcfile.xpm \
	Tk/textfile.xpm \
	Tk/tranicon.gif \
	Tk/typemap \
	Tk/widgets.pm \
	Tk/win.xbm \
	Tk/winfolder.xpm \
	Tk/wintext.xpm \
	TkXSUB.def \
	fix_4_os2.pl \
	lib/Tie/Watch.pm \
	tkGlue.def \
	tkGlue.h \
	tkGlue.m \
	tkGlue.t \
	tkGlue_f.h \
	vtab.def

PM_TO_BLIB = Tk/install.pm \
	blib/lib/Tk/install.pm \
	Tk/folder.xpm \
	blib/lib/Tk/folder.xpm \
	Tk/Checkbutton.pm \
	blib/lib/Tk/Checkbutton.pm \
	Tk/X11Font.pm \
	blib/lib/Tk/X11Font.pm \
	Tk/Wm.pm \
	blib/lib/Tk/Wm.pm \
	Tk/Dirlist.pm \
	blib/lib/Tk/Dirlist.pm \
	Tk/prolog.ps \
	blib/lib/Tk/prolog.ps \
	Tk/file.xpm \
	blib/lib/Tk/file.xpm \
	Tk.pod \
	blib/lib/Tk.pod \
	Tk/TextEdit.pm \
	blib/lib/Tk/TextEdit.pm \
	Tk/TextUndo.pm \
	blib/lib/Tk/TextUndo.pm \
	Tk/winfolder.xpm \
	blib/lib/Tk/winfolder.xpm \
	Tk/LabEntry.pm \
	blib/lib/Tk/LabEntry.pm \
	Tk/act_folder.xpm \
	blib/lib/Tk/act_folder.xpm \
	Tk/Optionmenu.pm \
	blib/lib/Tk/Optionmenu.pm \
	Tk/Photo.pm \
	blib/lib/Tk/Photo.pm \
	Tk/Toplevel.pm \
	blib/lib/Tk/Toplevel.pm \
	Tk/FileSelect.pm \
	blib/lib/Tk/FileSelect.pm \
	Tk/wintext.xpm \
	blib/lib/Tk/wintext.xpm \
	Tk/arrowdownwin.xbm \
	blib/lib/Tk/arrowdownwin.xbm \
	Tk/LabRadio.pm \
	blib/lib/Tk/LabRadio.pm \
	Tk/typemap \
	blib/lib/Tk/typemap \
	tkGlue.t \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.t \
	Tk/folder.xbm \
	blib/lib/Tk/folder.xbm \
	Tk/Dialog.pm \
	blib/lib/Tk/Dialog.pm \
	Tk/Tk.xpm \
	blib/lib/Tk/Tk.xpm \
	Tk/Frame.pm \
	blib/lib/Tk/Frame.pm \
	Tk/cbxarrow.xbm \
	blib/lib/Tk/cbxarrow.xbm \
	Tk/Menubar.pm \
	blib/lib/Tk/Menubar.pm \
	Tk/Xrm.pm \
	blib/lib/Tk/Xrm.pm \
	Tk/openfolder.xbm \
	blib/lib/Tk/openfolder.xbm \
	Tk/Widget.pm \
	blib/lib/Tk/Widget.pm \
	Tk/ColorEditor.pm \
	blib/lib/Tk/ColorEditor.pm \
	vtab.def \
	$(INST_ARCHLIBDIR)/Tk/vtab.def \
	Tk/Submethods.pm \
	blib/lib/Tk/Submethods.pm \
	Tk/Panedwindow.pm \
	blib/lib/Tk/Panedwindow.pm \
	Tk/Tk.xbm \
	blib/lib/Tk/Tk.xbm \
	Tk/tranicon.gif \
	blib/lib/Tk/tranicon.gif \
	Tk/widgets.pm \
	blib/lib/Tk/widgets.pm \
	Tk/file.xbm \
	blib/lib/Tk/file.xbm \
	Tk/Adjuster.pm \
	blib/lib/Tk/Adjuster.pm \
	Tk/Message.pm \
	blib/lib/Tk/Message.pm \
	tkGlue.h \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.h \
	Tk/Config.pm \
	$(INST_ARCHLIBDIR)/Tk/Config.pm \
	Tk/README.Adjust \
	blib/lib/Tk/README.Adjust \
	Tk/Configure.pm \
	blib/lib/Tk/Configure.pm \
	Tk/After.pm \
	blib/lib/Tk/After.pm \
	Tk/Tiler.pm \
	blib/lib/Tk/Tiler.pm \
	Tk/MakeDepend.pm \
	blib/lib/Tk/MakeDepend.pm \
	Tk/DummyEncode.pm \
	blib/lib/Tk/DummyEncode.pm \
	Tk/Credits \
	blib/lib/Tk/Credits \
	fix_4_os2.pl \
	blib/lib/fix_4_os2.pl \
	Tk/ItemStyle.pm \
	blib/lib/Tk/ItemStyle.pm \
	Tk/Menu.pm \
	blib/lib/Tk/Menu.pm \
	Tk/IconList.pm \
	blib/lib/Tk/IconList.pm \
	tkGlue.def \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.def \
	Tk/ROText.pm \
	blib/lib/Tk/ROText.pm \
	Tk/win.xbm \
	blib/lib/Tk/win.xbm \
	Tk/Labelframe.pm \
	blib/lib/Tk/Labelframe.pm \
	tkGlue_f.h \
	$(INST_ARCHLIBDIR)/Tk/tkGlue_f.h \
	Tk/anim.gif \
	blib/lib/Tk/anim.gif \
	Tk/Stats.pm \
	blib/lib/Tk/Stats.pm \
	Tk/openfile.xbm \
	blib/lib/Tk/openfile.xbm \
	Tk/Clipboard.pm \
	blib/lib/Tk/Clipboard.pm \
	Tk/ProgressBar.pm \
	blib/lib/Tk/ProgressBar.pm \
	TkXSUB.def \
	$(INST_ARCHLIBDIR)/Tk/TkXSUB.def \
	Tk/Menu/Item.pm \
	blib/lib/Tk/Menu/Item.pm \
	Tk/Animation.pm \
	blib/lib/Tk/Animation.pm \
	Tk/MMutil.pm \
	blib/lib/Tk/MMutil.pm \
	Tk/FBox.pm \
	blib/lib/Tk/FBox.pm \
	Tk/ColorEdit.xpm \
	blib/lib/Tk/ColorEdit.xpm \
	Tk/Pane.pm \
	blib/lib/Tk/Pane.pm \
	tkGlue.m \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.m \
	Tk/Font.pm \
	blib/lib/Tk/Font.pm \
	Tk/Button.pm \
	blib/lib/Tk/Button.pm \
	Tk/MMtry.pm \
	blib/lib/Tk/MMtry.pm \
	Tk/Pretty.pm \
	blib/lib/Tk/Pretty.pm \
	Tk/textfile.xpm \
	blib/lib/Tk/textfile.xpm \
	Tk/Camel.xpm \
	blib/lib/Tk/Camel.xpm \
	Tk/MainWindow.pm \
	blib/lib/Tk/MainWindow.pm \
	Tk/Trace.pm \
	blib/lib/Tk/Trace.pm \
	Tk/srcfile.xpm \
	blib/lib/Tk/srcfile.xpm \
	Tk/Image.pm \
	blib/lib/Tk/Image.pm \
	Tk/openfolder.xpm \
	blib/lib/Tk/openfolder.xpm \
	Tk/Radiobutton.pm \
	blib/lib/Tk/Radiobutton.pm \
	Tk/Derived.pm \
	blib/lib/Tk/Derived.pm \
	Tk/act_folder.xbm \
	blib/lib/Tk/act_folder.xbm \
	Tk/Xcamel.gif \
	blib/lib/Tk/Xcamel.gif \
	Tk/Bitmap.pm \
	blib/lib/Tk/Bitmap.pm \
	Tk/Label.pm \
	blib/lib/Tk/Label.pm \
	Tk/Spinbox.pm \
	blib/lib/Tk/Spinbox.pm \
	Tk/English.pm \
	blib/lib/Tk/English.pm \
	Tk/license.terms \
	blib/lib/Tk/license.terms \
	Tk/Region.pm \
	blib/lib/Tk/Region.pm \
	Tk/ErrorDialog.pm \
	blib/lib/Tk/ErrorDialog.pm \
	lib/Tie/Watch.pm \
	blib/lib/Tie/Watch.pm \
	Tk/CmdLine.pm \
	blib/lib/Tk/CmdLine.pm \
	Tk/Table.pm \
	blib/lib/Tk/Table.pm \
	Tk/icon.gif \
	blib/lib/Tk/icon.gif \
	Tk.pm \
	blib/lib/Tk.pm

GCCOPT =  -Wall -Wno-implicit-int -Wno-comment -Wno-unused -D__USE_FIXED_PROTOTYPES__


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(PERLRUN) -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1) ;'



# --- MakeMaker tool_xsubpp section:

XSUBPPDIR = /usr/lib/perl5/5.8.0/ExtUtils
XSUBPP = $(XSUBPPDIR)/xsubpp
XSPROTOARG = 
XSUBPPDEPS = $(XSUBPPDIR)/typemap /home/Downloads/asterisk/Tk-804.025_beta6/Tk/typemap $(XSUBPP)
XSUBPPARGS = -typemap $(XSUBPPDIR)/typemap -typemap /home/Downloads/asterisk/Tk-804.025_beta6/Tk/typemap
XSUBPP_EXTRA_ARGS = 


# --- MakeMaker tools_other section:

SHELL = /bin/sh
CHMOD = chmod
CP = cp
LD = gcc
MV = mv
NOOP = $(SHELL) -c true
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1

# The following is a portable way to say mkdir -p
# To see which directories are created, change the if 0 to if 1
MKPATH = $(PERLRUN) "-MExtUtils::Command" -e mkpath

# This helps us to minimize the effect of the .exists files A yet
# better solution would be to have a stable file in the perl
# distribution with a timestamp of zero. But this solution doesn't
# need any changes to the core distribution and works with older perls
EQUALIZE_TIMESTAMP = $(PERLRUN) "-MExtUtils::Command" -e eqtime

# Here we warn users that an old packlist file was found somewhere,
# and that they should call some uninstall routine
WARN_IF_OLD_PACKLIST = $(PERL) -we 'exit unless -f $$ARGV[0];' \
-e 'print "WARNING: I have found an old package in\n";' \
-e 'print "\t$$ARGV[0].\n";' \
-e 'print "Please make sure the two installations are not conflicting\n";'

UNINST=0
VERBINST=0

MOD_INSTALL = $(PERL) "-I$(INST_LIB)" "-I$(PERL_LIB)" "-MExtUtils::Install" \
-e "install({@ARGV},'$(VERBINST)',0,'$(UNINST)');"

DOC_INSTALL = $(PERL) -e '$$\="\n\n";' \
-e 'print "=head2 ", scalar(localtime), ": C<", shift, ">", " L<", $$arg=shift, "|", $$arg, ">";' \
-e 'print "=over 4";' \
-e 'while (defined($$key = shift) and defined($$val = shift)){print "=item *";print "C<$$key: $$val>";}' \
-e 'print "=back";'

UNINSTALL =   $(PERLRUN) "-MExtUtils::Install" \
-e 'uninstall($$ARGV[0],1,1); print "\nUninstall is deprecated. Please check the";' \
-e 'print " packlist above carefully.\n  There may be errors. Remove the";' \
-e 'print " appropriate files manually.\n  Sorry for the inconveniences.\n"'


# --- MakeMaker dist section:
ZIPFLAGS = -r
TO_UNIX = @$(NOOP)
TAR = tar
POSTOP = @$(NOOP)
ZIP = zip
DIST_DEFAULT = tardist
CI = ci -u
SHAR = shar
COMPRESS = gzip --best
DIST_CP = best
PREOP = @$(NOOP)
TARFLAGS = cvf
DISTVNAME = $(DISTNAME)-$(VERSION)
SUFFIX = .gz
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q


# --- MakeMaker macro section:
WINARCH = x
TKDIR = .


# --- MakeMaker depend section:


# --- MakeMaker cflags section:

CCFLAGS = -D_REENTRANT -D_GNU_SOURCE -DTHREADS_HAVE_PIDS -DDEBUGGING -fno-strict-aliasing -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -I/usr/include/gdbm
OPTIMIZE = -O2 -march=i386
PERLTYPE = 
MPOLLUTE = 


# --- MakeMaker const_loadlibs section:

# Tk might depend on some other libraries:
# See ExtUtils::Liblist for details
#
EXTRALIBS = -L/usr/X11R6/lib -lX11 -lnsl -lm
LDLOADLIBS = -L/usr/X11R6/lib -lX11 -lnsl -lm
BSLOADLIBS = 
LD_RUN_PATH = /usr/X11R6/lib:/lib


# --- MakeMaker const_cccmd section:
CCCMD = $(CC) -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION)

# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIB="$(LIB)"\
	LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"\
	OPTIMIZE="$(OPTIMIZE)"\
	PASTHRU_DEFINE="$(PASTHRU_DEFINE)"\
	PASTHRU_INC="$(PASTHRU_INC)"


# --- MakeMaker c_o section:

.c.i:
	gcc -E -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c > $*.i

.c.s:
	$(CCCMD) -S $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c

.c$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c

.C$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.C

.cpp$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.cpp

.cxx$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.cxx

.cc$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.cc


# --- MakeMaker xs_c section:

.xs.c:
	$(PERLRUN) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $(XSUBPP_EXTRA_ARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c


# --- MakeMaker xs_o section:

.xs$(OBJ_EXT):
	$(PERLRUN) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c


# --- MakeMaker top_targets section:

all :: pure_all html
	@$(NOOP)

pure_all :: config pm_to_blib subdirs linkext
	@$(NOOP)

subdirs :: $(MYEXTLIB)
	@$(NOOP)

config :: Makefile $(INST_LIBDIR)/.exists
	@$(NOOP)

config :: $(INST_ARCHAUTODIR)/.exists
	@$(NOOP)

config :: $(INST_AUTODIR)/.exists
	@$(NOOP)

$(INST_AUTODIR)/.exists :: /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h
	@$(MKPATH) $(INST_AUTODIR)
	@$(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h $(INST_AUTODIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_AUTODIR)

$(INST_LIBDIR)/.exists :: /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h
	@$(MKPATH) $(INST_LIBDIR)
	@$(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h $(INST_LIBDIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_LIBDIR)

$(INST_ARCHAUTODIR)/.exists :: /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h
	@$(MKPATH) $(INST_ARCHAUTODIR)
	@$(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h $(INST_ARCHAUTODIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_ARCHAUTODIR)

config :: $(INST_MAN3DIR)/.exists
	@$(NOOP)


$(INST_MAN3DIR)/.exists :: /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h
	@$(MKPATH) $(INST_MAN3DIR)
	@$(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h $(INST_MAN3DIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_MAN3DIR)

$(O_FILES): $(H_FILES)

help:
	perldoc ExtUtils::MakeMaker


# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	@$(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make dynamic"
#dynamic :: Makefile $(INST_DYNAMIC) $(INST_BOOT) $(INST_PM)
dynamic :: Makefile $(INST_DYNAMIC) $(INST_BOOT)
	@$(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP = Tk.bs

# As Mkbootstrap might not write a file (if none is required)
# we use touch to prevent make continually trying to remake it.
# The DynaLoader only reads a non-empty file.
$(BOOTSTRAP): Makefile  $(INST_ARCHAUTODIR)/.exists
	@echo "Running Mkbootstrap for $(NAME) ($(BSLOADLIBS))"
	@$(PERLRUN) \
		"-MExtUtils::Mkbootstrap" \
		-e "Mkbootstrap('$(BASEEXT)','$(BSLOADLIBS)');"
	@$(TOUCH) $(BOOTSTRAP)
	$(CHMOD) $(PERM_RW) $@

$(INST_BOOT): $(BOOTSTRAP) $(INST_ARCHAUTODIR)/.exists
	@rm -rf $(INST_BOOT)
	-cp $(BOOTSTRAP) $(INST_BOOT)
	$(CHMOD) $(PERM_RW) $@


# --- MakeMaker dynamic_lib section:

# This section creates the dynamically loadable $(INST_DYNAMIC)
# from $(OBJECT) and possibly $(MYEXTLIB).
ARMAYBE = :
OTHERLDFLAGS = 
INST_DYNAMIC_DEP = 

$(INST_DYNAMIC): $(OBJECT) $(MYEXTLIB) $(BOOTSTRAP) $(INST_ARCHAUTODIR)/.exists $(EXPORT_LIST) $(PERL_ARCHIVE) $(PERL_ARCHIVE_AFTER) $(INST_DYNAMIC_DEP)
	$(RM_F) $@
	LD_RUN_PATH="$(LD_RUN_PATH)" $(LD)  $(LDDLFLAGS) $(LDFROM) $(OTHERLDFLAGS) -o $@ $(MYEXTLIB) $(PERL_ARCHIVE) $(LDLOADLIBS) $(PERL_ARCHIVE_AFTER) $(EXPORT_LIST)
	$(CHMOD) $(PERM_RWX) $@


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
#static :: Makefile $(INST_STATIC) $(INST_PM)
static :: Makefile $(INST_STATIC)
	@$(NOOP)


# --- MakeMaker static_lib section:

$(INST_STATIC): $(OBJECT) $(MYEXTLIB) $(INST_ARCHAUTODIR)/.exists
	$(RM_RF) $@
	cp $(MYEXTLIB) $@
	$(FULL_AR) $(AR_STATIC_ARGS) $@ $(OBJECT) && $(RANLIB) $@
	$(CHMOD) $(PERM_RWX) $@
	@echo "$(EXTRALIBS)" > $(INST_ARCHAUTODIR)/extralibs.ld



# --- MakeMaker manifypods section:
POD2MAN_EXE = /usr/bin/pod2man --center "perl/Tk Documentation" --release "Tk$(VERSION)"
POD2MAN = $(PERL) -we '%m=@ARGV;for (keys %m){' \
-e 'next if -e $$m{$$_} && -M $$m{$$_} < -M $$_ && -M $$m{$$_} < -M "Makefile";' \
-e 'print "Manifying $$m{$$_}\n";' \
-e 'system(q[$(PERLRUN) $(POD2MAN_EXE) ].qq[$$_>$$m{$$_}])==0 or warn "Couldn\047t install $$m{$$_}\n";' \
-e 'chmod(oct($(PERM_RW)), $$m{$$_}) or warn "chmod $(PERM_RW) $$m{$$_}: $$!\n";}'

manifypods : pure_all Tk/Dialog.pm \
	Tk/Pane.pm \
	Tk/Xrm.pm \
	Tk/Widget.pm \
	Tk/ColorEditor.pm \
	Tk/Trace.pm \
	Tk/MainWindow.pm \
	Tk.pod \
	Tk/Submethods.pm \
	Tk/widgets.pm \
	Tk/ProgressBar.pm \
	Tk/Optionmenu.pm \
	Tk/Menu/Item.pm \
	Tk/Animation.pm \
	Tk/FileSelect.pm \
	Tk/Adjuster.pm \
	lib/Tie/Watch.pm \
	Tk/CmdLine.pm \
	Tk/Table.pm
	@$(POD2MAN) \
	Tk/Dialog.pm \
	$(INST_MAN3DIR)/Tk::Dialog.$(MAN3EXT) \
	Tk/Pane.pm \
	$(INST_MAN3DIR)/Tk::Pane.$(MAN3EXT) \
	Tk/Xrm.pm \
	$(INST_MAN3DIR)/Tk::Xrm.$(MAN3EXT) \
	Tk/Widget.pm \
	$(INST_MAN3DIR)/Tk::Widget.$(MAN3EXT) \
	Tk/ColorEditor.pm \
	$(INST_MAN3DIR)/Tk::ColorEditor.$(MAN3EXT) \
	Tk/Trace.pm \
	$(INST_MAN3DIR)/Tk::Trace.$(MAN3EXT) \
	Tk/MainWindow.pm \
	$(INST_MAN3DIR)/Tk::MainWindow.$(MAN3EXT) \
	Tk.pod \
	$(INST_MAN3DIR)/Tk.$(MAN3EXT) \
	Tk/Submethods.pm \
	$(INST_MAN3DIR)/Tk::Submethods.$(MAN3EXT) \
	Tk/widgets.pm \
	$(INST_MAN3DIR)/Tk::widgets.$(MAN3EXT) \
	Tk/ProgressBar.pm \
	$(INST_MAN3DIR)/Tk::ProgressBar.$(MAN3EXT) \
	Tk/Optionmenu.pm \
	$(INST_MAN3DIR)/Tk::Optionmenu.$(MAN3EXT) \
	Tk/Menu/Item.pm \
	$(INST_MAN3DIR)/Tk::Menu::Item.$(MAN3EXT) \
	Tk/Animation.pm \
	$(INST_MAN3DIR)/Tk::Animation.$(MAN3EXT) \
	Tk/FileSelect.pm \
	$(INST_MAN3DIR)/Tk::FileSelect.$(MAN3EXT) \
	Tk/Adjuster.pm \
	$(INST_MAN3DIR)/Tk::Adjuster.$(MAN3EXT) \
	lib/Tie/Watch.pm \
	$(INST_MAN3DIR)/Tie::Watch.$(MAN3EXT) \
	Tk/CmdLine.pm \
	$(INST_MAN3DIR)/Tk::CmdLine.$(MAN3EXT) \
	Tk/Table.pm \
	$(INST_MAN3DIR)/Tk::Table.$(MAN3EXT)

# --- MakeMaker processPL section:

all :: MANIFEST.SKIP
	@$(NOOP)

MANIFEST.SKIP :: MANIFEST.SKIP.PL
	$(PERLRUNINST) MANIFEST.SKIP.PL MANIFEST.SKIP

all :: vtab.def
	@$(NOOP)

vtab.def :: vtab.def.PL
	$(PERLRUNINST) vtab.def.PL vtab.def


# --- MakeMaker installbin section:

$(INST_SCRIPT)/.exists :: /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h
	@$(MKPATH) $(INST_SCRIPT)
	@$(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.0/i386-linux-thread-multi/CORE/perl.h $(INST_SCRIPT)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)

EXE_FILES = ptksh ptked gedi

FIXIN = $(PERLRUN) "-MExtUtils::MY" \
    -e "MY->fixin(shift)"

pure_all :: $(INST_SCRIPT)/ptksh $(INST_SCRIPT)/gedi $(INST_SCRIPT)/ptked
	@$(NOOP)

realclean ::
	rm -f $(INST_SCRIPT)/ptksh $(INST_SCRIPT)/gedi $(INST_SCRIPT)/ptked

$(INST_SCRIPT)/ptksh: ptksh Makefile $(INST_SCRIPT)/.exists
	@rm -f $(INST_SCRIPT)/ptksh
	$(PERL) -I. -MTk::install -e installbin perl ptksh $(INST_SCRIPT)/ptksh
	$(FIXIN) $(INST_SCRIPT)/ptksh
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/ptksh

$(INST_SCRIPT)/gedi: gedi Makefile $(INST_SCRIPT)/.exists
	@rm -f $(INST_SCRIPT)/gedi
	$(PERL) -I. -MTk::install -e installbin perl gedi $(INST_SCRIPT)/gedi
	$(FIXIN) $(INST_SCRIPT)/gedi
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/gedi

$(INST_SCRIPT)/ptked: ptked Makefile $(INST_SCRIPT)/.exists
	@rm -f $(INST_SCRIPT)/ptked
	$(PERL) -I. -MTk::install -e installbin perl ptked $(INST_SCRIPT)/ptked
	$(FIXIN) $(INST_SCRIPT)/ptked
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/ptked


# --- MakeMaker subdirs section:

# The default clean, realclean and test targets in this Makefile
# have automatically been given entries for each subdir.


subdirs ::
	@cd pTk && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd pod && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd demos && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Xlib && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd WinPhoto && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Tixish && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd TixPixmap && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd TixGrid && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd TextList && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Text && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd TList && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Scrollbar && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Scale && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd PNG && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd NBFrame && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Mwm && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Menubutton && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Listbox && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd JPEG && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd InputO && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd IO && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd HList && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Event && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Entry && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd DragDrop && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Compound && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	@cd Canvas && $(MAKE) -f $(FIRST_MAKEFILE) all $(PASTHRU)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean ::
	-cd pTk && $(TEST_F) Makefile && $(MAKE) clean
	-cd pod && $(TEST_F) Makefile && $(MAKE) clean
	-cd demos && $(TEST_F) Makefile && $(MAKE) clean
	-cd Xlib && $(TEST_F) Makefile && $(MAKE) clean
	-cd WinPhoto && $(TEST_F) Makefile && $(MAKE) clean
	-cd Tixish && $(TEST_F) Makefile && $(MAKE) clean
	-cd TixPixmap && $(TEST_F) Makefile && $(MAKE) clean
	-cd TixGrid && $(TEST_F) Makefile && $(MAKE) clean
	-cd TextList && $(TEST_F) Makefile && $(MAKE) clean
	-cd Text && $(TEST_F) Makefile && $(MAKE) clean
	-cd TList && $(TEST_F) Makefile && $(MAKE) clean
	-cd Scrollbar && $(TEST_F) Makefile && $(MAKE) clean
	-cd Scale && $(TEST_F) Makefile && $(MAKE) clean
	-cd PNG && $(TEST_F) Makefile && $(MAKE) clean
	-cd NBFrame && $(TEST_F) Makefile && $(MAKE) clean
	-cd Mwm && $(TEST_F) Makefile && $(MAKE) clean
	-cd Menubutton && $(TEST_F) Makefile && $(MAKE) clean
	-cd Listbox && $(TEST_F) Makefile && $(MAKE) clean
	-cd JPEG && $(TEST_F) Makefile && $(MAKE) clean
	-cd InputO && $(TEST_F) Makefile && $(MAKE) clean
	-cd IO && $(TEST_F) Makefile && $(MAKE) clean
	-cd HList && $(TEST_F) Makefile && $(MAKE) clean
	-cd Event && $(TEST_F) Makefile && $(MAKE) clean
	-cd Entry && $(TEST_F) Makefile && $(MAKE) clean
	-cd DragDrop && $(TEST_F) Makefile && $(MAKE) clean
	-cd Compound && $(TEST_F) Makefile && $(MAKE) clean
	-cd Canvas && $(TEST_F) Makefile && $(MAKE) clean
	-rm -rf Tk.c pTk/tkConfig.h Tk/Config.pm *.bak ./blib $(MAKE_APERL_FILE) $(INST_ARCHAUTODIR)/extralibs.all perlmain.c tmon.out mon.out so_locations pm_to_blib *$(OBJ_EXT) *$(LIB_EXT) perl.exe perl perl$(EXE_EXT) $(BOOTSTRAP) $(BASEEXT).bso $(BASEEXT).def lib$(BASEEXT).def $(BASEEXT).exp $(BASEEXT).x core core.*perl.*.? *perl.core
	-mv Makefile Makefile.old $(DEV_NULL)


# --- MakeMaker realclean section:

# Delete temporary files (via clean) and also delete installed files
realclean purge ::  clean
	-cd pTk && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd pTk && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd pod && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd pod && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd demos && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd demos && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Xlib && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Xlib && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd WinPhoto && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd WinPhoto && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Tixish && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Tixish && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd TixPixmap && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd TixPixmap && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd TixGrid && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd TixGrid && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd TextList && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd TextList && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Text && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Text && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd TList && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd TList && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Scrollbar && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Scrollbar && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Scale && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Scale && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd PNG && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd PNG && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd NBFrame && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd NBFrame && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Mwm && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Mwm && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Menubutton && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Menubutton && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Listbox && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Listbox && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd JPEG && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd JPEG && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd InputO && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd InputO && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd IO && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd IO && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd HList && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd HList && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Event && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Event && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Entry && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Entry && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd DragDrop && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd DragDrop && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Compound && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Compound && $(TEST_F) Makefile && $(MAKE)  realclean
	-cd Canvas && $(TEST_F) Makefile.old && $(MAKE) -f Makefile.old realclean
	-cd Canvas && $(TEST_F) Makefile && $(MAKE)  realclean
	rm -rf $(INST_AUTODIR) $(INST_ARCHAUTODIR)
	rm -rf $(DISTVNAME)
	rm -f $(INST_DYNAMIC) $(INST_BOOT)
	rm -f $(INST_STATIC)
	rm -f  blib/lib/Tk/install.pm blib/lib/Tk/folder.xpm blib/lib/Tk/Checkbutton.pm
	rm -f blib/lib/Tk/X11Font.pm blib/lib/Tk/Wm.pm blib/lib/Tk/Dirlist.pm
	rm -f blib/lib/Tk/prolog.ps blib/lib/Tk/file.xpm blib/lib/Tk.pod
	rm -f blib/lib/Tk/TextEdit.pm blib/lib/Tk/TextUndo.pm blib/lib/Tk/winfolder.xpm
	rm -f blib/lib/Tk/LabEntry.pm blib/lib/Tk/act_folder.xpm blib/lib/Tk/Optionmenu.pm
	rm -f blib/lib/Tk/Photo.pm blib/lib/Tk/Toplevel.pm blib/lib/Tk/FileSelect.pm
	rm -f blib/lib/Tk/wintext.xpm blib/lib/Tk/arrowdownwin.xbm blib/lib/Tk/LabRadio.pm
	rm -f blib/lib/Tk/typemap $(INST_ARCHLIBDIR)/Tk/tkGlue.t blib/lib/Tk/folder.xbm
	rm -f blib/lib/Tk/Dialog.pm blib/lib/Tk/Tk.xpm blib/lib/Tk/Frame.pm
	rm -f blib/lib/Tk/cbxarrow.xbm blib/lib/Tk/Menubar.pm blib/lib/Tk/Xrm.pm
	rm -f blib/lib/Tk/openfolder.xbm blib/lib/Tk/Widget.pm blib/lib/Tk/ColorEditor.pm
	rm -f $(INST_ARCHLIBDIR)/Tk/vtab.def blib/lib/Tk/Submethods.pm
	rm -f blib/lib/Tk/Panedwindow.pm blib/lib/Tk/Tk.xbm blib/lib/Tk/tranicon.gif
	rm -f blib/lib/Tk/widgets.pm blib/lib/Tk/file.xbm blib/lib/Tk/Adjuster.pm
	rm -f blib/lib/Tk/Message.pm $(INST_ARCHLIBDIR)/Tk/tkGlue.h
	rm -f $(INST_ARCHLIBDIR)/Tk/Config.pm blib/lib/Tk/README.Adjust
	rm -f blib/lib/Tk/Configure.pm blib/lib/Tk/After.pm blib/lib/Tk/Tiler.pm
	rm -f blib/lib/Tk/MakeDepend.pm blib/lib/Tk/DummyEncode.pm blib/lib/Tk/Credits
	rm -f blib/lib/fix_4_os2.pl blib/lib/Tk/ItemStyle.pm blib/lib/Tk/Menu.pm
	rm -f blib/lib/Tk/IconList.pm $(INST_ARCHLIBDIR)/Tk/tkGlue.def blib/lib/Tk/ROText.pm
	rm -f blib/lib/Tk/win.xbm blib/lib/Tk/Labelframe.pm $(INST_ARCHLIBDIR)/Tk/tkGlue_f.h
	rm -f blib/lib/Tk/anim.gif blib/lib/Tk/Stats.pm blib/lib/Tk/openfile.xbm
	rm -f blib/lib/Tk/Clipboard.pm blib/lib/Tk/ProgressBar.pm
	rm -f $(INST_ARCHLIBDIR)/Tk/TkXSUB.def blib/lib/Tk/Menu/Item.pm
	rm -f blib/lib/Tk/Animation.pm blib/lib/Tk/MMutil.pm blib/lib/Tk/FBox.pm
	rm -f blib/lib/Tk/ColorEdit.xpm blib/lib/Tk/Pane.pm $(INST_ARCHLIBDIR)/Tk/tkGlue.m
	rm -f blib/lib/Tk/Font.pm blib/lib/Tk/Button.pm blib/lib/Tk/MMtry.pm
	rm -f blib/lib/Tk/Pretty.pm blib/lib/Tk/textfile.xpm blib/lib/Tk/Camel.xpm
	rm -f blib/lib/Tk/MainWindow.pm blib/lib/Tk/Trace.pm blib/lib/Tk/srcfile.xpm
	rm -f blib/lib/Tk/Image.pm blib/lib/Tk/openfolder.xpm blib/lib/Tk/Radiobutton.pm
	rm -f blib/lib/Tk/Derived.pm blib/lib/Tk/act_folder.xbm blib/lib/Tk/Xcamel.gif
	rm -f blib/lib/Tk/Bitmap.pm blib/lib/Tk/Label.pm blib/lib/Tk/Spinbox.pm
	rm -f blib/lib/Tk/English.pm blib/lib/Tk/license.terms blib/lib/Tk/Region.pm
	rm -f blib/lib/Tk/ErrorDialog.pm blib/lib/Tie/Watch.pm blib/lib/Tk/CmdLine.pm
	rm -f blib/lib/Tk/Table.pm blib/lib/Tk/icon.gif blib/lib/Tk.pm
	rm -rf Makefile Makefile.old


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
	$(RM_F) *~ *.orig */*~ */*.orig



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT)
	@$(PERL) -le 'print "Warning: Makefile possibly out of date with $$vf" if ' \
	    -e '-e ($$vf="$(VERSION_FROM)") and -M $$vf < -M "Makefile";'

tardist : $(DISTVNAME).tar$(SUFFIX)

zipdist : $(DISTVNAME).zip

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) \
		$(DISTVNAME).tar$(SUFFIX) > \
		$(DISTVNAME).tar$(SUFFIX)_uu

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker dist_dir section:
distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"



# --- MakeMaker dist_test section:

disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)


# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
		-e "@all = keys %{ maniread() };" \
		-e 'print("Executing $(CI) @all\n"); system("$(CI) @all");' \
		-e 'print("Executing $(RCS_LABEL) ...\n"); system("$(RCS_LABEL) @all");'


# --- MakeMaker install section:

install :: all pure_install doc_install

install_perl :: all pure_perl_install doc_perl_install

install_site :: all pure_site_install doc_site_install

install_vendor :: all pure_vendor_install doc_vendor_install

pure_install :: pure_$(INSTALLDIRS)_install

doc_install :: doc_$(INSTALLDIRS)_install
	@echo Appending installation info to $(INSTALLARCHLIB)/perllocal.pod

pure__install : pure_site_install
	@echo INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	@echo INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install ::
	@$(MOD_INSTALL) \
		read $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist \
		write $(INSTALLARCHLIB)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(INSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(INSTALLARCHLIB) \
		$(INST_BIN) $(INSTALLBIN) \
		$(INST_SCRIPT) $(INSTALLSCRIPT) \
		$(INST_MAN1DIR) $(INSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(INSTALLMAN3DIR)
	@$(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install ::
	@$(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(INSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(INSTALLSITELIB) \
		$(INST_ARCHLIB) $(INSTALLSITEARCH) \
		$(INST_BIN) $(INSTALLSITEBIN) \
		$(INST_SCRIPT) $(INSTALLSCRIPT) \
		$(INST_MAN1DIR) $(INSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(INSTALLSITEMAN3DIR)
	@$(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install ::
	@$(MOD_INSTALL) \
		$(INST_LIB) $(INSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(INSTALLVENDORARCH) \
		$(INST_BIN) $(INSTALLVENDORBIN) \
		$(INST_SCRIPT) $(INSTALLSCRIPT) \
		$(INST_MAN1DIR) $(INSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(INSTALLVENDORMAN3DIR)

doc_perl_install ::
	-@$(MKPATH) $(INSTALLARCHLIB)
	-@$(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(INSTALLARCHLIB)/perllocal.pod

doc_site_install ::
	-@$(MKPATH) $(INSTALLARCHLIB)
	-@$(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(INSTALLSITEARCH)/perllocal.pod

doc_vendor_install ::


uninstall :: uninstall_from_$(INSTALLDIRS)dirs

uninstall_from_perldirs ::
	@$(UNINSTALL) $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist

uninstall_from_sitedirs ::
	@$(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE:
	@$(NOOP)


# --- MakeMaker perldepend section:

PERL_HDRS = \
	$(PERL_INC)/EXTERN.h		\
	$(PERL_INC)/INTERN.h		\
	$(PERL_INC)/XSUB.h		\
	$(PERL_INC)/av.h		\
	$(PERL_INC)/cc_runtime.h	\
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
	$(PERL_INC)/opnames.h		\
	$(PERL_INC)/patchlevel.h	\
	$(PERL_INC)/perl.h		\
	$(PERL_INC)/perlapi.h		\
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
	$(PERL_INC)/thrdvar.h		\
	$(PERL_INC)/thread.h		\
	$(PERL_INC)/unixish.h		\
	$(PERL_INC)/utf8.h		\
	$(PERL_INC)/util.h		\
	$(PERL_INC)/warnings.h

$(OBJECT) : $(PERL_HDRS)

Tk.c : $(XSUBPPDEPS)

Tk$(OBJ_EXT) : Tk.c pTk/Lang.h pTk/default.h pTk/tcl.h pTk/tclDecls.h \
 pTk/tclPlatDecls.h pTk/tk.h pTk/tkConfig.h pTk/tkDecls.h pTk/tkEvent.h \
 pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h pTk/tkFont.h pTk/tkInt.h \
 pTk/tkIntDecls.h pTk/tkOption.h pTk/tkOption.t pTk/tkOption_f.h \
 pTk/tkPort.h pTk/tkUnixDefault.h pTk/tkUnixPort.h pTk/tkXrm.h \
 tkGlue.def tkGlue.h vtab.def

chnGlue$(OBJ_EXT) : chnGlue.c pTk/Lang.h pTk/tcl.h pTk/tclDecls.h \
 pTk/tclPlatDecls.h pTk/tk.h pTk/tkConfig.h pTk/tkDecls.h pTk/tkEvent.h \
 pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h pTk/tkInt.h \
 pTk/tkIntDecls.h pTk/tkOption.h pTk/tkOption.t pTk/tkOption_f.h \
 pTk/tkPort.h pTk/tkUnixPort.h tkGlue.def tkGlue.h vtab.def

encGlue$(OBJ_EXT) : encGlue.c pTk/Lang.h pTk/tcl.h pTk/tclDecls.h \
 pTk/tclPlatDecls.h pTk/tk.h pTk/tkConfig.h pTk/tkDecls.h pTk/tkEvent.h \
 pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h pTk/tkInt.h \
 pTk/tkIntDecls.h pTk/tkOption.h pTk/tkOption.t pTk/tkOption_f.h \
 pTk/tkPort.h pTk/tkUnixPort.h tkGlue.def tkGlue.h vtab.def

evtGlue$(OBJ_EXT) : evtGlue.c pTk/Lang.h pTk/tcl.h pTk/tclDecls.h \
 pTk/tclPlatDecls.h pTk/tk.h pTk/tkConfig.h pTk/tkDecls.h pTk/tkEvent.h \
 pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h pTk/tkInt.h \
 pTk/tkIntDecls.h pTk/tkOption.h pTk/tkOption.t pTk/tkOption_f.h \
 pTk/tkPort.h pTk/tkUnixPort.h tkGlue.def tkGlue.h vtab.def

objGlue$(OBJ_EXT) : objGlue.c pTk/Lang.h pTk/tcl.h pTk/tclDecls.h \
 pTk/tclPlatDecls.h pTk/tk.h pTk/tkConfig.h pTk/tkDecls.h pTk/tkEvent.h \
 pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h pTk/tkInt.h \
 pTk/tkIntDecls.h pTk/tkOption.h pTk/tkOption.t pTk/tkOption_f.h \
 pTk/tkPort.h pTk/tkUnixPort.h tkGlue.def tkGlue.h vtab.def

tixGlue$(OBJ_EXT) : tixGlue.c pTk/Lang.h pTk/Lang.m pTk/Lang.t \
 pTk/Lang_f.h pTk/Xlib.m pTk/Xlib.t pTk/Xlib_f.h pTk/tcl.h \
 pTk/tclDecls.h pTk/tclDecls.m pTk/tclDecls.t pTk/tclDecls_f.h \
 pTk/tclPlatDecls.h pTk/tix.h pTk/tix.m pTk/tix.t pTk/tixImgXpm.h \
 pTk/tixImgXpm.m pTk/tixImgXpm.t pTk/tixImgXpm_f.h pTk/tixInt.h \
 pTk/tixInt.m pTk/tixInt.t pTk/tixInt_f.h pTk/tixPort.h \
 pTk/tixUnixPort.h pTk/tix_f.h pTk/tk.h pTk/tk.m pTk/tk.t \
 pTk/tkConfig.h pTk/tkDecls.h pTk/tkDecls.m pTk/tkDecls.t \
 pTk/tkDecls_f.h pTk/tkEvent.h pTk/tkEvent.m pTk/tkEvent.t \
 pTk/tkEvent_f.h pTk/tkOption.h pTk/tkOption.t pTk/tkOption_f.h \
 pTk/tkPort.h pTk/tkUnixPort.h pTk/tkVMacro.h pTk/tk_f.h tkGlue.def \
 tkGlue.h vtab.def

tkGlue$(OBJ_EXT) : tkGlue.c TkXSUB.def pTk/Lang.h pTk/Lang.t \
 pTk/Lang_f.h pTk/Xlib.h pTk/Xlib.t pTk/Xlib_f.h pTk/img.h pTk/imgInt.h \
 pTk/imgInt.m pTk/imgInt.t pTk/imgInt_f.h pTk/tcl.h pTk/tclDecls.h \
 pTk/tclDecls.t pTk/tclDecls_f.h pTk/tclPlatDecls.h pTk/tix.h \
 pTk/tixPort.h pTk/tixUnixPort.h pTk/tk.h pTk/tk.t pTk/tkConfig.h \
 pTk/tkDecls.h pTk/tkDecls.t pTk/tkDecls_f.h pTk/tkEvent.h \
 pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h pTk/tkImgPhoto.h \
 pTk/tkImgPhoto.m pTk/tkImgPhoto.t pTk/tkImgPhoto_f.h pTk/tkInt.h \
 pTk/tkInt.t pTk/tkIntDecls.h pTk/tkIntDecls.t pTk/tkIntDecls_f.h \
 pTk/tkIntPlatDecls.h pTk/tkInt_f.h pTk/tkOption.h pTk/tkOption.t \
 pTk/tkOption_f.h pTk/tkPort.h pTk/tkUnixInt.h pTk/tkUnixPort.h \
 pTk/tk_f.h tkGlue.def tkGlue.h tkGlue.t tkGlue_f.h vtab.def

tkGlue_f$(OBJ_EXT) : tkGlue_f.c pTk/Lang.h pTk/Lang.t pTk/Lang_f.h \
 pTk/Xlib.h pTk/Xlib.t pTk/Xlib_f.h pTk/tcl.h pTk/tclDecls.h \
 pTk/tclPlatDecls.h pTk/tk.h pTk/tk.t pTk/tkConfig.h pTk/tkDecls.h \
 pTk/tkEvent.h pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h \
 pTk/tkImgPhoto.h pTk/tkInt.h pTk/tkInt.t pTk/tkIntDecls.h \
 pTk/tkInt_f.h pTk/tkOption.h pTk/tkOption.t pTk/tkOption_f.h \
 pTk/tkPort.h pTk/tkUnixPort.h pTk/tk_f.h tkGlue.def tkGlue.h tkGlue.t \
 tkGlue_f.h vtab.def

tkWin32Dll$(OBJ_EXT) : tkWin32Dll.c pTk/Lang.h pTk/tcl.h \
 pTk/tclDecls.h pTk/tclPlatDecls.h pTk/tkConfig.h pTk/tkEvent.h \
 pTk/tkEvent.m pTk/tkEvent.t pTk/tkEvent_f.h pTk/tkPort.h \
 pTk/tkUnixPort.h


# --- MakeMaker makefile section:


# We take a very conservative approach here, but it\'s worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
Makefile : Makefile.PL $(CONFIGDEP) /home/Downloads/asterisk/Tk-804.025_beta6/Tk/Config.pm /home/Downloads/asterisk/Tk-804.025_beta6/Tk/MMutil.pm
	@echo "Makefile out-of-date with respect to $?"
	@echo "Cleaning current config before rebuilding Makefile..."
	-@$(RM_F) Makefile.old
	-@$(MV) Makefile Makefile.old
	-$(MAKE) -f Makefile.old clean $(DEV_NULL) || $(NOOP)
	$(PERLRUN) Makefile.PL "BINARY_LOCATION=i386-linux-thread-multi/Tk804.025-PPM.tar.gz"
	@echo "==> Your Makefile has been rebuilt. <=="
	@echo "==> Please rerun the make command.  <=="
	false



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) -f $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE)
	@echo Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	@$(PERLRUNINST) \
		Makefile.PL DIR=pTk:pod:demos:Xlib:WinPhoto:Tixish:TixPixmap:TixGrid:TextList:Text:TList:Scrollbar:Scale:PNG:NBFrame:Mwm:Menubutton:Listbox:JPEG:InputO:IO:HList:Event:Entry:DragDrop:Compound:Canvas \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS= \
		BINARY_LOCATION=i386-linux-thread-multi/Tk804.025-PPM.tar.gz


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/JP.t t/KR.t t/Require.t t/Trace.t t/X.t t/after.t t/autoload.t t/balloon.t t/browseentry-grabtest.t t/browseentry-subclassing.t t/browseentry.t t/browseentry2.t t/create.t t/cursor.t t/dash.t t/entry.t t/fbox.t t/fileevent.t t/fileselect.t t/font.t t/geomgr.t t/iso8859-1.t t/leak.t t/list.t t/listbox.t t/magic.t t/mega.t t/mwm.t t/optmenu.t t/photo.t t/progbar.t t/regexp.t t/trace1.t t/widget.t t/wm-time.t t/zzHList.t t/zzPhoto.t t/zzScrolled.t t/zzText.t t/zzTixGrid.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE)
	@cd PNG && $(TEST_F) Makefile && $(MAKE) test $(PASTHRU)
	@cd JPEG && $(TEST_F) Makefile && $(MAKE) test $(PASTHRU)
	@cd Event && $(TEST_F) Makefile && $(MAKE) test $(PASTHRU)

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
ppd:
	@$(PERL) -e "print qq{<SOFTPKG NAME=\"$(DISTNAME)\" VERSION=\"804,025,0,0\">\n\t<TITLE>$(DISTNAME)</TITLE>\n\t<ABSTRACT>Tk - a Graphical User Interface Toolkit</ABSTRACT>\n\t<AUTHOR>nick\@ni-s.u-net.com (Nick Ing-Simmons)</AUTHOR>\n}" > $(DISTNAME).ppd
	@$(PERL) -e "print qq{\t<IMPLEMENTATION>\n}" >> $(DISTNAME).ppd
	@$(PERL) -e "print qq{\t\t<OS NAME=\"$(OSNAME)\" />\n\t\t<ARCHITECTURE NAME=\"i386-linux-thread-multi\" />\n\t\t<CODEBASE HREF=\"i386-linux-thread-multi/Tk804.025-PPM.tar.gz\" />\n\t</IMPLEMENTATION>\n</SOFTPKG>\n}" >> $(DISTNAME).ppd

# --- MakeMaker pm_to_blib section:

pm_to_blib: $(TO_INST_PM)
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/install.pm blib/lib/Tk/install.pm Tk/folder.xpm blib/lib/Tk/folder.xpm Tk/Checkbutton.pm blib/lib/Tk/Checkbutton.pm Tk/X11Font.pm blib/lib/Tk/X11Font.pm Tk/Dirlist.pm blib/lib/Tk/Dirlist.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/Wm.pm blib/lib/Tk/Wm.pm Tk/prolog.ps blib/lib/Tk/prolog.ps Tk/file.xpm blib/lib/Tk/file.xpm Tk.pod blib/lib/Tk.pod Tk/TextEdit.pm blib/lib/Tk/TextEdit.pm Tk/TextUndo.pm blib/lib/Tk/TextUndo.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/LabEntry.pm blib/lib/Tk/LabEntry.pm Tk/winfolder.xpm blib/lib/Tk/winfolder.xpm Tk/act_folder.xpm blib/lib/Tk/act_folder.xpm Tk/Optionmenu.pm blib/lib/Tk/Optionmenu.pm Tk/Photo.pm blib/lib/Tk/Photo.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/FileSelect.pm blib/lib/Tk/FileSelect.pm Tk/Toplevel.pm blib/lib/Tk/Toplevel.pm Tk/wintext.xpm blib/lib/Tk/wintext.xpm Tk/arrowdownwin.xbm blib/lib/Tk/arrowdownwin.xbm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/LabRadio.pm blib/lib/Tk/LabRadio.pm Tk/typemap blib/lib/Tk/typemap tkGlue.t $(INST_ARCHLIBDIR)/Tk/tkGlue.t Tk/folder.xbm blib/lib/Tk/folder.xbm Tk/Dialog.pm blib/lib/Tk/Dialog.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/Tk.xpm blib/lib/Tk/Tk.xpm Tk/Frame.pm blib/lib/Tk/Frame.pm Tk/cbxarrow.xbm blib/lib/Tk/cbxarrow.xbm Tk/Menubar.pm blib/lib/Tk/Menubar.pm Tk/Xrm.pm blib/lib/Tk/Xrm.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/ColorEditor.pm blib/lib/Tk/ColorEditor.pm Tk/Widget.pm blib/lib/Tk/Widget.pm Tk/openfolder.xbm blib/lib/Tk/openfolder.xbm vtab.def $(INST_ARCHLIBDIR)/Tk/vtab.def}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/Submethods.pm blib/lib/Tk/Submethods.pm Tk/Panedwindow.pm blib/lib/Tk/Panedwindow.pm Tk/Tk.xbm blib/lib/Tk/Tk.xbm Tk/tranicon.gif blib/lib/Tk/tranicon.gif Tk/widgets.pm blib/lib/Tk/widgets.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/file.xbm blib/lib/Tk/file.xbm Tk/Adjuster.pm blib/lib/Tk/Adjuster.pm Tk/Message.pm blib/lib/Tk/Message.pm Tk/README.Adjust blib/lib/Tk/README.Adjust Tk/Config.pm $(INST_ARCHLIBDIR)/Tk/Config.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{tkGlue.h $(INST_ARCHLIBDIR)/Tk/tkGlue.h Tk/After.pm blib/lib/Tk/After.pm Tk/Configure.pm blib/lib/Tk/Configure.pm Tk/MakeDepend.pm blib/lib/Tk/MakeDepend.pm Tk/Tiler.pm blib/lib/Tk/Tiler.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/DummyEncode.pm blib/lib/Tk/DummyEncode.pm fix_4_os2.pl blib/lib/fix_4_os2.pl Tk/Credits blib/lib/Tk/Credits Tk/Menu.pm blib/lib/Tk/Menu.pm Tk/ItemStyle.pm blib/lib/Tk/ItemStyle.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/IconList.pm blib/lib/Tk/IconList.pm tkGlue.def $(INST_ARCHLIBDIR)/Tk/tkGlue.def Tk/ROText.pm blib/lib/Tk/ROText.pm Tk/win.xbm blib/lib/Tk/win.xbm Tk/Labelframe.pm blib/lib/Tk/Labelframe.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{tkGlue_f.h $(INST_ARCHLIBDIR)/Tk/tkGlue_f.h Tk/Stats.pm blib/lib/Tk/Stats.pm Tk/anim.gif blib/lib/Tk/anim.gif Tk/Clipboard.pm blib/lib/Tk/Clipboard.pm Tk/openfile.xbm blib/lib/Tk/openfile.xbm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/ProgressBar.pm blib/lib/Tk/ProgressBar.pm TkXSUB.def $(INST_ARCHLIBDIR)/Tk/TkXSUB.def Tk/MMutil.pm blib/lib/Tk/MMutil.pm Tk/Animation.pm blib/lib/Tk/Animation.pm Tk/Menu/Item.pm blib/lib/Tk/Menu/Item.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/FBox.pm blib/lib/Tk/FBox.pm Tk/ColorEdit.xpm blib/lib/Tk/ColorEdit.xpm Tk/Pane.pm blib/lib/Tk/Pane.pm tkGlue.m $(INST_ARCHLIBDIR)/Tk/tkGlue.m Tk/Pretty.pm blib/lib/Tk/Pretty.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/MMtry.pm blib/lib/Tk/MMtry.pm Tk/Button.pm blib/lib/Tk/Button.pm Tk/Font.pm blib/lib/Tk/Font.pm Tk/textfile.xpm blib/lib/Tk/textfile.xpm Tk/Camel.xpm blib/lib/Tk/Camel.xpm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/Trace.pm blib/lib/Tk/Trace.pm Tk/MainWindow.pm blib/lib/Tk/MainWindow.pm Tk/srcfile.xpm blib/lib/Tk/srcfile.xpm Tk/Image.pm blib/lib/Tk/Image.pm Tk/Radiobutton.pm blib/lib/Tk/Radiobutton.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/openfolder.xpm blib/lib/Tk/openfolder.xpm Tk/Derived.pm blib/lib/Tk/Derived.pm Tk/act_folder.xbm blib/lib/Tk/act_folder.xbm Tk/Xcamel.gif blib/lib/Tk/Xcamel.gif Tk/Bitmap.pm blib/lib/Tk/Bitmap.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/Spinbox.pm blib/lib/Tk/Spinbox.pm Tk/Label.pm blib/lib/Tk/Label.pm Tk/English.pm blib/lib/Tk/English.pm Tk/Region.pm blib/lib/Tk/Region.pm Tk/license.terms blib/lib/Tk/license.terms}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/CmdLine.pm blib/lib/Tk/CmdLine.pm lib/Tie/Watch.pm blib/lib/Tie/Watch.pm Tk/ErrorDialog.pm blib/lib/Tk/ErrorDialog.pm Tk/Table.pm blib/lib/Tk/Table.pm Tk.pm blib/lib/Tk.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{Tk/icon.gif blib/lib/Tk/icon.gif}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(TOUCH) $@

# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


html : subdirs manifypods
	@cd pod && $(MAKE) html $(PASTHRU)

config       :: tkGlue.t tkGlue.m
	@$(NOOP)

$(BASEEXT)$(OBJ_EXT) : tkGlue.h
Makefile     : myConfig

tkGlue.t     : tkGlue.h pTk/mkVFunc
	$(PERL) pTk/mkVFunc -t $(WINARCH) tkGlue.h

tkGlue.m     : tkGlue.h pTk/mkVFunc
	$(PERL) pTk/mkVFunc -m $(WINARCH) tkGlue.h

$(MYEXTLIB)  : config FORCE
	cd pTk && $(MAKE) DEFINE="$(DEFINE)"

perlmain.c : config Makefile

pTk/tk.res : $(MYEXTLIB)

basic      : $(INST_DYNAMIC) pm_to_blib

MANIFEST : MANIFEST.SKIP $(FIRST_MAKEFILE)
	$(MAKE) manifest



# End.

# This Makefile is for the Tk extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.56 (Revision: 65600) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: (q[BINARY_LOCATION=darwin-thread-multi-2level/Tk804.029-PPM.tar.gz])
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Tk - a Graphical User Interface Toolkit]
#     AUTHOR => q[nick@ing-simmons.net (Nick Ing-Simmons)]
#     BUILD_REQUIRES => {  }
#     DEFINE => q[]
#     DIR => [q[pTk], q[pod], q[demos], q[Xlib], q[WinPhoto], q[Tixish], q[TixPixmap], q[TixGrid], q[TextList], q[Text], q[TList], q[Scrollbar], q[Scale], q[PNG], q[NBFrame], q[Mwm], q[Menubutton], q[Listbox], q[JPEG], q[InputO], q[IO], q[HList], q[Event], q[Entry], q[DragDrop], q[Compound], q[Canvas]]
#     DISTNAME => q[Tk]
#     DISTVNAME => q[Tk-804.029]
#     EXE_FILES => [q[ptksh], q[ptked], q[gedi]]
#     INC => q[-I/usr/X11R6/include]
#     LIBS => [q[-L/usr/X11R6/lib -lX11 -lm]]
#     LICENSE => q[unrestricted]
#     MYEXTLIB => q[pTk/libpTk$(LIB_EXT)]
#     NAME => q[Tk]
#     OBJECT => q[$(O_FILES)]
#     PREREQ_PM => { Test::More=>q[0], Encode=>q[0] }
#     TYPEMAPS => [q[/Users/pktm/Library/Application Support/.cpan/build/Tk-804.029-i9dgSK/Tk/typemap]]
#     VERSION => q[804.029]
#     XS_VERSION => q[804.029]
#     clean => { FILES=>q[pTk/tkConfig.h Tk/Config.pm *.bak] }
#     macro => { WINARCH=>q[x], TKDIR=>q[.] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /System/Library/Perl/5.10.0/darwin-thread-multi-2level/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = gcc-4.2
CCCDLFLAGS =  
CCDLFLAGS =  
DLEXT = bundle
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = gcc-4.2 -mmacosx-version-min=10.6
LDDLFLAGS = -arch x86_64 -arch i386 -arch ppc -bundle -undefined dynamic_lookup -L/usr/local/lib
LDFLAGS = -arch x86_64 -arch i386 -arch ppc -L/usr/local/lib
LIBC = /usr/lib/libc.dylib
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = darwin
OSVERS = 10.0
RANLIB = /usr/bin/ar s
SITELIBEXP = /Library/Perl/5.10.0
SITEARCHEXP = /Library/Perl/5.10.0/darwin-thread-multi-2level
SO = dylib
VENDORARCHEXP = /Network/Library/Perl/5.10.0/darwin-thread-multi-2level
VENDORLIBEXP = /Network/Library/Perl/5.10.0


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = Tk
NAME_SYM = Tk
VERSION = 804.029
VERSION_MACRO = VERSION
VERSION_SYM = 804_029
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 804.029
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1
MAN3EXT = 3pm
INSTALLDIRS = site
DESTDIR = 
PREFIX = $(SITEPREFIX)
PERLPREFIX = /
SITEPREFIX = /usr/local
VENDORPREFIX = /usr/local
INSTALLPRIVLIB = /Library/Perl/Updates/5.10.0
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = /Library/Perl/5.10.0
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = /Network/Library/Perl/5.10.0
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = /Library/Perl/Updates/5.10.0/darwin-thread-multi-2level
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = /Library/Perl/5.10.0/darwin-thread-multi-2level
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = /Network/Library/Perl/5.10.0/darwin-thread-multi-2level
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = /usr/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = /usr/local/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = /usr/local/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = /usr/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = /usr/local/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = /usr/local/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = /usr/share/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = /usr/local/share/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = /usr/local/share/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = /usr/share/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = /usr/local/share/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = /usr/local/share/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /System/Library/Perl/5.10.0
PERL_ARCHLIB = /System/Library/Perl/5.10.0/darwin-thread-multi-2level
LIBPERL_A = libperl.a
MYEXTLIB = pTk/libpTk$(LIB_EXT)
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /System/Library/Perl/5.10.0/darwin-thread-multi-2level/CORE
PERL = /usr/bin/perl
FULLPERL = /usr/bin/perl
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

MAKEMAKER   = /Library/Perl/Updates/5.10.0/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.56
MM_REVISION = 65600

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = Tk
BASEEXT = Tk
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = 
INC = -I/usr/X11R6/include
DEFINE = 
OBJECT = $(O_FILES)
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = Tk.xs
C_FILES  = Tk.c \
	chnGlue.c \
	encGlue.c \
	evtGlue.c \
	objGlue.c \
	tixGlue.c \
	tkGlue.c \
	tkGlue_f.c \
	tkWin32Dll.c
O_FILES  = Tk.o \
	chnGlue.o \
	encGlue.o \
	evtGlue.o \
	objGlue.o \
	tixGlue.o \
	tkGlue.o \
	tkGlue_f.o \
	tkWin32Dll.o
H_FILES  = tkGlue.h \
	tkGlue_f.h
MAN1PODS = ptked \
	ptksh
MAN3PODS = Tk.pod \
	Tk/Pane.pm \
	Tk/ProgressBar.pm \
	Tk/Trace.pm \
	lib/Tie/Watch.pm

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
	Tk/MsgBox.pm \
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
	lib/Tie/Watch.pm \
	tkGlue.def \
	tkGlue.h \
	tkGlue.m \
	tkGlue.t \
	tkGlue_f.h \
	vtab.def

PM_TO_BLIB = Tk/install.pm \
	$(INST_LIB)/Tk/install.pm \
	Tk/folder.xpm \
	$(INST_LIB)/Tk/folder.xpm \
	Tk/Checkbutton.pm \
	$(INST_LIB)/Tk/Checkbutton.pm \
	Tk/X11Font.pm \
	$(INST_LIB)/Tk/X11Font.pm \
	Tk/Wm.pm \
	$(INST_LIB)/Tk/Wm.pm \
	Tk/Dirlist.pm \
	$(INST_LIB)/Tk/Dirlist.pm \
	Tk/prolog.ps \
	$(INST_LIB)/Tk/prolog.ps \
	Tk/file.xpm \
	$(INST_LIB)/Tk/file.xpm \
	Tk.pod \
	$(INST_LIB)/Tk.pod \
	Tk/TextEdit.pm \
	$(INST_LIB)/Tk/TextEdit.pm \
	Tk/TextUndo.pm \
	$(INST_LIB)/Tk/TextUndo.pm \
	Tk/winfolder.xpm \
	$(INST_LIB)/Tk/winfolder.xpm \
	Tk/LabEntry.pm \
	$(INST_LIB)/Tk/LabEntry.pm \
	Tk/act_folder.xpm \
	$(INST_LIB)/Tk/act_folder.xpm \
	Tk/Optionmenu.pm \
	$(INST_LIB)/Tk/Optionmenu.pm \
	Tk/MsgBox.pm \
	$(INST_LIB)/Tk/MsgBox.pm \
	Tk/Photo.pm \
	$(INST_LIB)/Tk/Photo.pm \
	Tk/Toplevel.pm \
	$(INST_LIB)/Tk/Toplevel.pm \
	Tk/FileSelect.pm \
	$(INST_LIB)/Tk/FileSelect.pm \
	Tk/wintext.xpm \
	$(INST_LIB)/Tk/wintext.xpm \
	Tk/arrowdownwin.xbm \
	$(INST_LIB)/Tk/arrowdownwin.xbm \
	Tk/LabRadio.pm \
	$(INST_LIB)/Tk/LabRadio.pm \
	Tk/typemap \
	$(INST_LIB)/Tk/typemap \
	tkGlue.t \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.t \
	Tk/folder.xbm \
	$(INST_LIB)/Tk/folder.xbm \
	Tk/Dialog.pm \
	$(INST_LIB)/Tk/Dialog.pm \
	Tk/Tk.xpm \
	$(INST_LIB)/Tk/Tk.xpm \
	Tk/Frame.pm \
	$(INST_LIB)/Tk/Frame.pm \
	Tk/cbxarrow.xbm \
	$(INST_LIB)/Tk/cbxarrow.xbm \
	Tk/Menubar.pm \
	$(INST_LIB)/Tk/Menubar.pm \
	Tk/Xrm.pm \
	$(INST_LIB)/Tk/Xrm.pm \
	Tk/Widget.pm \
	$(INST_LIB)/Tk/Widget.pm \
	Tk/openfolder.xbm \
	$(INST_LIB)/Tk/openfolder.xbm \
	Tk/ColorEditor.pm \
	$(INST_LIB)/Tk/ColorEditor.pm \
	vtab.def \
	$(INST_ARCHLIBDIR)/Tk/vtab.def \
	Tk/Submethods.pm \
	$(INST_LIB)/Tk/Submethods.pm \
	Tk/Panedwindow.pm \
	$(INST_LIB)/Tk/Panedwindow.pm \
	Tk/Tk.xbm \
	$(INST_LIB)/Tk/Tk.xbm \
	Tk/tranicon.gif \
	$(INST_LIB)/Tk/tranicon.gif \
	Tk/widgets.pm \
	$(INST_LIB)/Tk/widgets.pm \
	Tk/file.xbm \
	$(INST_LIB)/Tk/file.xbm \
	Tk/Adjuster.pm \
	$(INST_LIB)/Tk/Adjuster.pm \
	Tk/Message.pm \
	$(INST_LIB)/Tk/Message.pm \
	tkGlue.h \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.h \
	Tk/Config.pm \
	$(INST_ARCHLIBDIR)/Tk/Config.pm \
	Tk/README.Adjust \
	$(INST_LIB)/Tk/README.Adjust \
	Tk/After.pm \
	$(INST_LIB)/Tk/After.pm \
	Tk/Configure.pm \
	$(INST_LIB)/Tk/Configure.pm \
	Tk/Tiler.pm \
	$(INST_LIB)/Tk/Tiler.pm \
	Tk/MakeDepend.pm \
	$(INST_LIB)/Tk/MakeDepend.pm \
	Tk/DummyEncode.pm \
	$(INST_LIB)/Tk/DummyEncode.pm \
	Tk/Credits \
	$(INST_LIB)/Tk/Credits \
	Tk/ItemStyle.pm \
	$(INST_LIB)/Tk/ItemStyle.pm \
	Tk/Menu.pm \
	$(INST_LIB)/Tk/Menu.pm \
	Tk/IconList.pm \
	$(INST_LIB)/Tk/IconList.pm \
	tkGlue.def \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.def \
	Tk/ROText.pm \
	$(INST_LIB)/Tk/ROText.pm \
	Tk/win.xbm \
	$(INST_LIB)/Tk/win.xbm \
	Tk/Labelframe.pm \
	$(INST_LIB)/Tk/Labelframe.pm \
	tkGlue_f.h \
	$(INST_ARCHLIBDIR)/Tk/tkGlue_f.h \
	Tk/Stats.pm \
	$(INST_LIB)/Tk/Stats.pm \
	Tk/anim.gif \
	$(INST_LIB)/Tk/anim.gif \
	Tk/Clipboard.pm \
	$(INST_LIB)/Tk/Clipboard.pm \
	Tk/openfile.xbm \
	$(INST_LIB)/Tk/openfile.xbm \
	Tk/ProgressBar.pm \
	$(INST_LIB)/Tk/ProgressBar.pm \
	TkXSUB.def \
	$(INST_ARCHLIBDIR)/Tk/TkXSUB.def \
	Tk/Menu/Item.pm \
	$(INST_LIB)/Tk/Menu/Item.pm \
	Tk/Animation.pm \
	$(INST_LIB)/Tk/Animation.pm \
	Tk/MMutil.pm \
	$(INST_LIB)/Tk/MMutil.pm \
	Tk/FBox.pm \
	$(INST_LIB)/Tk/FBox.pm \
	Tk/ColorEdit.xpm \
	$(INST_LIB)/Tk/ColorEdit.xpm \
	Tk/Pane.pm \
	$(INST_LIB)/Tk/Pane.pm \
	tkGlue.m \
	$(INST_ARCHLIBDIR)/Tk/tkGlue.m \
	Tk/Button.pm \
	$(INST_LIB)/Tk/Button.pm \
	Tk/Font.pm \
	$(INST_LIB)/Tk/Font.pm \
	Tk/MMtry.pm \
	$(INST_LIB)/Tk/MMtry.pm \
	Tk/Pretty.pm \
	$(INST_LIB)/Tk/Pretty.pm \
	Tk/textfile.xpm \
	$(INST_LIB)/Tk/textfile.xpm \
	Tk/Camel.xpm \
	$(INST_LIB)/Tk/Camel.xpm \
	Tk/Trace.pm \
	$(INST_LIB)/Tk/Trace.pm \
	Tk/MainWindow.pm \
	$(INST_LIB)/Tk/MainWindow.pm \
	Tk/srcfile.xpm \
	$(INST_LIB)/Tk/srcfile.xpm \
	Tk/Image.pm \
	$(INST_LIB)/Tk/Image.pm \
	Tk/Radiobutton.pm \
	$(INST_LIB)/Tk/Radiobutton.pm \
	Tk/openfolder.xpm \
	$(INST_LIB)/Tk/openfolder.xpm \
	Tk/Derived.pm \
	$(INST_LIB)/Tk/Derived.pm \
	Tk/act_folder.xbm \
	$(INST_LIB)/Tk/act_folder.xbm \
	Tk/Xcamel.gif \
	$(INST_LIB)/Tk/Xcamel.gif \
	Tk/Bitmap.pm \
	$(INST_LIB)/Tk/Bitmap.pm \
	Tk/Spinbox.pm \
	$(INST_LIB)/Tk/Spinbox.pm \
	Tk/Label.pm \
	$(INST_LIB)/Tk/Label.pm \
	Tk/English.pm \
	$(INST_LIB)/Tk/English.pm \
	Tk/Region.pm \
	$(INST_LIB)/Tk/Region.pm \
	Tk/license.terms \
	$(INST_LIB)/Tk/license.terms \
	Tk/ErrorDialog.pm \
	$(INST_LIB)/Tk/ErrorDialog.pm \
	Tk/CmdLine.pm \
	$(INST_LIB)/Tk/CmdLine.pm \
	lib/Tie/Watch.pm \
	blib/lib/Tie/Watch.pm \
	Tk/Table.pm \
	$(INST_LIB)/Tk/Table.pm \
	Tk.pm \
	$(INST_LIB)/Tk.pm \
	Tk/icon.gif \
	$(INST_LIB)/Tk/icon.gif

GCCOPT =  -Wall -Wno-implicit-int -Wno-comment -Wno-unused -D__USE_FIXED_PROTOTYPES__


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.56
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:

XSUBPPDIR = /Library/Perl/Updates/5.10.0/ExtUtils
XSUBPP = $(XSUBPPDIR)$(DFSEP)xsubpp
XSUBPPRUN = $(PERLRUN) $(XSUBPP)
XSPROTOARG = 
XSUBPPDEPS = /System/Library/Perl/5.10.0/ExtUtils/typemap /Users/pktm/Library/Application Support/.cpan/build/Tk-804.029-i9dgSK/Tk/typemap $(XSUBPP)
XSUBPPARGS = -typemap /System/Library/Perl/5.10.0/ExtUtils/typemap -typemap /Users/pktm/Library/Application Support/.cpan/build/Tk-804.029-i9dgSK/Tk/typemap
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
TAR = COPY_EXTENDED_ATTRIBUTES_DISABLE=1 COPYFILE_DISABLE=1 tar
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
DISTNAME = Tk
DISTVNAME = Tk-804.029


# --- MakeMaker macro section:
WINARCH = x
TKDIR = .


# --- MakeMaker depend section:


# --- MakeMaker cflags section:

CCFLAGS = -arch x86_64 -arch i386 -arch ppc -g -pipe -fno-common -DPERL_DARWIN -fno-strict-aliasing -I/usr/local/include
OPTIMIZE = -Os
PERLTYPE = 
MPOLLUTE = 


# --- MakeMaker const_loadlibs section:

# Tk might depend on some other libraries:
# See ExtUtils::Liblist for details
#
EXTRALIBS = -L/usr/X11R6/lib -lX11
LDLOADLIBS = -L/usr/X11R6/lib -lX11 -lm
BSLOADLIBS = 
LD_RUN_PATH = /usr/X11R6/lib


# --- MakeMaker const_cccmd section:
CCCMD = $(CC) -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION)

# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:
#Tk::MMutil pasthru

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
	gcc-4.2 -E -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c > $*.i

.c.s:
	$(CCCMD) -S $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c

.c$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c

.cpp$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.cpp

.cxx$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.cxx

.cc$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.cc

.C$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.C


# --- MakeMaker xs_c section:

.xs.c:
	$(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $(XSUBPP_EXTRA_ARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c


# --- MakeMaker xs_o section:

.xs$(OBJ_EXT):
	$(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $(GCCOPT) $*.c


# --- MakeMaker top_targets section:
all :: pure_all html
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
	$(CP) $(MYEXTLIB) $@
	$(FULL_AR) $(AR_STATIC_ARGS) $@ $(OBJECT) && $(RANLIB) $@
	$(CHMOD) $(PERM_RWX) $@
	$(NOECHO) $(ECHO) "$(EXTRALIBS)" > $(INST_ARCHAUTODIR)/extralibs.ld


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--" --center "perl/Tk Documentation" --release "Tk$(VERSION)"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	ptksh \
	ptked \
	Tk/Pane.pm \
	Tk.pod \
	Tk/ProgressBar.pm \
	Tk/Trace.pm \
	lib/Tie/Watch.pm
	$(NOECHO) $(POD2MAN) --section=1 --perm_rw=$(PERM_RW) \
	  ptksh $(INST_MAN1DIR)/ptksh.$(MAN1EXT) \
	  ptked $(INST_MAN1DIR)/ptked.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  Tk/Pane.pm $(INST_MAN3DIR)/Tk::Pane.$(MAN3EXT) \
	  Tk.pod $(INST_MAN3DIR)/Tk.$(MAN3EXT) \
	  Tk/ProgressBar.pm $(INST_MAN3DIR)/Tk::ProgressBar.$(MAN3EXT) \
	  Tk/Trace.pm $(INST_MAN3DIR)/Tk::Trace.$(MAN3EXT) \
	  lib/Tie/Watch.pm $(INST_MAN3DIR)/Tie::Watch.$(MAN3EXT) 




# --- MakeMaker processPL section:

all :: MANIFEST.SKIP
	$(NOECHO) $(NOOP)

MANIFEST.SKIP :: MANIFEST.SKIP.PL pm_to_blib
	$(PERLRUNINST) MANIFEST.SKIP.PL MANIFEST.SKIP

all :: vtab.def
	$(NOECHO) $(NOOP)

vtab.def :: vtab.def.PL 
	$(PERLRUN) vtab.def.PL vtab.def


# --- MakeMaker installbin section:

EXE_FILES = ptksh ptked gedi

pure_all :: $(INST_SCRIPT)/ptksh $(INST_SCRIPT)/gedi $(INST_SCRIPT)/ptked
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/ptksh $(INST_SCRIPT)/gedi \
	  $(INST_SCRIPT)/ptked 

$(INST_SCRIPT)/ptksh : ptksh $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/ptksh
	$(CP) ptksh $(INST_SCRIPT)/ptksh
	$(FIXIN) $(INST_SCRIPT)/ptksh
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/ptksh

$(INST_SCRIPT)/gedi : gedi $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/gedi
	$(CP) gedi $(INST_SCRIPT)/gedi
	$(FIXIN) $(INST_SCRIPT)/gedi
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/gedi

$(INST_SCRIPT)/ptked : ptked $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/ptked
	$(CP) ptked $(INST_SCRIPT)/ptked
	$(FIXIN) $(INST_SCRIPT)/ptked
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/ptked



# --- MakeMaker subdirs section:

# The default clean, realclean and test targets in this Makefile
# have automatically been given entries for each subdir.


subdirs ::
	$(NOECHO) cd pTk && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd pod && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd demos && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Xlib && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd WinPhoto && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Tixish && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd TixPixmap && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd TixGrid && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd TextList && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Text && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd TList && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Scrollbar && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Scale && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd PNG && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd NBFrame && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Mwm && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Menubutton && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Listbox && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd JPEG && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd InputO && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd IO && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd HList && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Event && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Entry && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd DragDrop && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Compound && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Canvas && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)


# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(ABSPERLRUN)  -e 'chdir '\''pTk'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''pod'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''demos'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Xlib'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''WinPhoto'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Tixish'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''TixPixmap'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''TixGrid'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''TextList'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Text'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''TList'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Scrollbar'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Scale'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''PNG'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''NBFrame'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Mwm'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Menubutton'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Listbox'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''JPEG'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''InputO'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''IO'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''HList'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Event'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Entry'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''DragDrop'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Compound'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Canvas'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


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
	  Tk.c $(INST_ARCHAUTODIR)/extralibs.ld \
	  blibdirs.ts core.[0-9][0-9][0-9][0-9][0-9] \
	  *perl.core core.*perl.*.? \
	  $(MAKE_APERL_FILE) $(BASEEXT).def \
	  perl core.[0-9][0-9][0-9] \
	  mon.out lib$(BASEEXT).def \
	  perl.exe perlmain.c \
	  so_locations $(BASEEXT).exp 
	- $(RM_RF) \
	  Tk/Config.pm pTk/tkConfig.h \
	  *.bak blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	- $(ABSPERLRUN)  -e 'chdir '\''pTk'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''pTk'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''pod'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''pod'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''demos'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''demos'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Xlib'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Xlib'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''WinPhoto'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''WinPhoto'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Tixish'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Tixish'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TixPixmap'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TixPixmap'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TixGrid'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TixGrid'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TextList'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TextList'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Text'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Text'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TList'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''TList'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Scrollbar'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Scrollbar'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Scale'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Scale'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''PNG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''PNG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''NBFrame'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''NBFrame'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Mwm'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Mwm'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Menubutton'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Menubutton'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Listbox'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Listbox'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''JPEG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''JPEG'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''InputO'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''InputO'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''IO'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''IO'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''HList'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''HList'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Event'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Event'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Entry'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Entry'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''DragDrop'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''DragDrop'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Compound'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Compound'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Canvas'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Canvas'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


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
	$(NOECHO) $(ECHO) '--- #YAML:1.0' > META_new.yml
	$(NOECHO) $(ECHO) 'name:               Tk' >> META_new.yml
	$(NOECHO) $(ECHO) 'version:            804.029' >> META_new.yml
	$(NOECHO) $(ECHO) 'abstract:           Tk - a Graphical User Interface Toolkit' >> META_new.yml
	$(NOECHO) $(ECHO) 'author:' >> META_new.yml
	$(NOECHO) $(ECHO) '    - nick@ing-simmons.net (Nick Ing-Simmons)' >> META_new.yml
	$(NOECHO) $(ECHO) 'license:            unrestricted' >> META_new.yml
	$(NOECHO) $(ECHO) 'distribution_type:  module' >> META_new.yml
	$(NOECHO) $(ECHO) 'configure_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '    ExtUtils::MakeMaker:  0' >> META_new.yml
	$(NOECHO) $(ECHO) 'build_requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '    ExtUtils::MakeMaker:  0' >> META_new.yml
	$(NOECHO) $(ECHO) 'requires:' >> META_new.yml
	$(NOECHO) $(ECHO) '    Encode:      0' >> META_new.yml
	$(NOECHO) $(ECHO) '    Test::More:  0' >> META_new.yml
	$(NOECHO) $(ECHO) 'no_index:' >> META_new.yml
	$(NOECHO) $(ECHO) '    directory:' >> META_new.yml
	$(NOECHO) $(ECHO) '        - t' >> META_new.yml
	$(NOECHO) $(ECHO) '        - inc' >> META_new.yml
	$(NOECHO) $(ECHO) 'generated_by:       ExtUtils::MakeMaker version 6.56' >> META_new.yml
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
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL "BINARY_LOCATION=darwin-thread-multi-2level/Tk804.029-PPM.tar.gz"
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


# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP) /Users/pktm/Library/Application Support/.cpan/build/Tk-804.029-i9dgSK/Tk/Config.pm /Users/pktm/Library/Application Support/.cpan/build/Tk-804.029-i9dgSK/Tk/MMutil.pm
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL "BINARY_LOCATION=darwin-thread-multi-2level/Tk804.029-PPM.tar.gz"
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR=pTk:pod:demos:Xlib:WinPhoto:Tixish:TixPixmap:TixGrid:TextList:Text:TList:Scrollbar:Scale:PNG:NBFrame:Mwm:Menubutton:Listbox:JPEG:InputO:IO:HList:Event:Entry:DragDrop:Compound:Canvas \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS= \
		BINARY_LOCATION=darwin-thread-multi-2level/Tk804.029-PPM.tar.gz


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/00wmcheck.t t/JP.t t/KR.t t/Require.t t/Tkxs.t t/Trace.t t/X.t t/adjuster.t t/after.t t/async.t t/autoload.t t/balloon.t t/bind.t t/browseentry-grabtest.t t/browseentry-subclassing.t t/browseentry.t t/browseentry2.t t/button-tcl.t t/button.t t/canvas-grid.t t/canvas.t t/canvas2.t t/coloreditor.t t/create.t t/cursor.t t/dash.t t/dialogbox.t t/dirtree.t t/entry.t t/errordialog.t t/exefiles.t t/fbox.t t/fileevent.t t/fileevent2.t t/fileselect.t t/font.t t/fork.t t/geomgr.t t/iso8859-1.t t/leak.t t/list.t t/listbox.t t/listvar.t t/magic.t t/mega.t t/msgbox.t t/mwm.t t/objglue.t t/optmenu.t t/photo.t t/pixmap.t t/progbar.t t/property.t t/regexp.t t/rotext.t t/slaves.t t/table.t t/text.t t/text2.t t/textundo.t t/trace1.t t/unicode.t t/widget.t t/wm-tcl.t t/wm-time.t t/wm.t t/zzHList.t t/zzPhoto.t t/zzScrolled.t t/zzText.t t/zzTixGrid.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)

subdirs-test ::
	$(NOECHO) cd PNG && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd JPEG && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd Event && $(MAKE) test $(PASTHRU)


test_dynamic :: pure_all
	$(FULLPERLRUN) "-It" "-MTkTest" "-MExtUtils::Command::MM" "-e" "check_display_harness; test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: pure_all $(MAP_TARGET)
	./$(MAP_TARGET) "-It" "-MTkTest" "-MExtUtils::Command::MM" "-e" "check_display_harness; test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_static :: pure_all $(MAP_TARGET)
	PERL_DL_NONLAZY=1 ./$(MAP_TARGET) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)



# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="804.029">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Tk - a Graphical User Interface Toolkit</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>nick@ing-simmons.net (Nick Ing-Simmons)</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Encode::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::More" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="darwin-thread-multi-2level-5.10" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="darwin-thread-multi-2level/Tk804.029-PPM.tar.gz" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  Tk/install.pm $(INST_LIB)/Tk/install.pm \
	  Tk/folder.xpm $(INST_LIB)/Tk/folder.xpm \
	  Tk/Checkbutton.pm $(INST_LIB)/Tk/Checkbutton.pm \
	  Tk/X11Font.pm $(INST_LIB)/Tk/X11Font.pm \
	  Tk/Wm.pm $(INST_LIB)/Tk/Wm.pm \
	  Tk/Dirlist.pm $(INST_LIB)/Tk/Dirlist.pm \
	  Tk/prolog.ps $(INST_LIB)/Tk/prolog.ps \
	  Tk/file.xpm $(INST_LIB)/Tk/file.xpm \
	  Tk.pod $(INST_LIB)/Tk.pod \
	  Tk/TextEdit.pm $(INST_LIB)/Tk/TextEdit.pm \
	  Tk/TextUndo.pm $(INST_LIB)/Tk/TextUndo.pm \
	  Tk/winfolder.xpm $(INST_LIB)/Tk/winfolder.xpm \
	  Tk/LabEntry.pm $(INST_LIB)/Tk/LabEntry.pm \
	  Tk/act_folder.xpm $(INST_LIB)/Tk/act_folder.xpm \
	  Tk/Optionmenu.pm $(INST_LIB)/Tk/Optionmenu.pm \
	  Tk/MsgBox.pm $(INST_LIB)/Tk/MsgBox.pm \
	  Tk/Photo.pm $(INST_LIB)/Tk/Photo.pm \
	  Tk/Toplevel.pm $(INST_LIB)/Tk/Toplevel.pm \
	  Tk/FileSelect.pm $(INST_LIB)/Tk/FileSelect.pm \
	  Tk/wintext.xpm $(INST_LIB)/Tk/wintext.xpm \
	  Tk/arrowdownwin.xbm $(INST_LIB)/Tk/arrowdownwin.xbm \
	  Tk/LabRadio.pm $(INST_LIB)/Tk/LabRadio.pm \
	  Tk/typemap $(INST_LIB)/Tk/typemap \
	  tkGlue.t $(INST_ARCHLIBDIR)/Tk/tkGlue.t \
	  Tk/folder.xbm $(INST_LIB)/Tk/folder.xbm \
	  Tk/Dialog.pm $(INST_LIB)/Tk/Dialog.pm \
	  Tk/Tk.xpm $(INST_LIB)/Tk/Tk.xpm \
	  Tk/Frame.pm $(INST_LIB)/Tk/Frame.pm \
	  Tk/cbxarrow.xbm $(INST_LIB)/Tk/cbxarrow.xbm \
	  Tk/Menubar.pm $(INST_LIB)/Tk/Menubar.pm \
	  Tk/Xrm.pm $(INST_LIB)/Tk/Xrm.pm \
	  Tk/Widget.pm $(INST_LIB)/Tk/Widget.pm \
	  Tk/openfolder.xbm $(INST_LIB)/Tk/openfolder.xbm \
	  Tk/ColorEditor.pm $(INST_LIB)/Tk/ColorEditor.pm \
	  vtab.def $(INST_ARCHLIBDIR)/Tk/vtab.def \
	  Tk/Submethods.pm $(INST_LIB)/Tk/Submethods.pm \
	  Tk/Panedwindow.pm $(INST_LIB)/Tk/Panedwindow.pm \
	  Tk/Tk.xbm $(INST_LIB)/Tk/Tk.xbm \
	  Tk/tranicon.gif $(INST_LIB)/Tk/tranicon.gif \
	  Tk/widgets.pm $(INST_LIB)/Tk/widgets.pm \
	  Tk/file.xbm $(INST_LIB)/Tk/file.xbm \
	  Tk/Adjuster.pm $(INST_LIB)/Tk/Adjuster.pm \
	  Tk/Message.pm $(INST_LIB)/Tk/Message.pm \
	  tkGlue.h $(INST_ARCHLIBDIR)/Tk/tkGlue.h \
	  Tk/Config.pm $(INST_ARCHLIBDIR)/Tk/Config.pm \
	  Tk/README.Adjust $(INST_LIB)/Tk/README.Adjust \
	  Tk/After.pm $(INST_LIB)/Tk/After.pm \
	  Tk/Configure.pm $(INST_LIB)/Tk/Configure.pm \
	  Tk/Tiler.pm $(INST_LIB)/Tk/Tiler.pm \
	  Tk/MakeDepend.pm $(INST_LIB)/Tk/MakeDepend.pm \
	  Tk/DummyEncode.pm $(INST_LIB)/Tk/DummyEncode.pm \
	  Tk/Credits $(INST_LIB)/Tk/Credits \
	  Tk/ItemStyle.pm $(INST_LIB)/Tk/ItemStyle.pm \
	  Tk/Menu.pm $(INST_LIB)/Tk/Menu.pm \
	  Tk/IconList.pm $(INST_LIB)/Tk/IconList.pm \
	  tkGlue.def $(INST_ARCHLIBDIR)/Tk/tkGlue.def \
	  Tk/ROText.pm $(INST_LIB)/Tk/ROText.pm \
	  Tk/win.xbm $(INST_LIB)/Tk/win.xbm \
	  Tk/Labelframe.pm $(INST_LIB)/Tk/Labelframe.pm \
	  tkGlue_f.h $(INST_ARCHLIBDIR)/Tk/tkGlue_f.h \
	  Tk/Stats.pm $(INST_LIB)/Tk/Stats.pm \
	  Tk/anim.gif $(INST_LIB)/Tk/anim.gif \
	  Tk/Clipboard.pm $(INST_LIB)/Tk/Clipboard.pm \
	  Tk/openfile.xbm $(INST_LIB)/Tk/openfile.xbm \
	  Tk/ProgressBar.pm $(INST_LIB)/Tk/ProgressBar.pm \
	  TkXSUB.def $(INST_ARCHLIBDIR)/Tk/TkXSUB.def \
	  Tk/Menu/Item.pm $(INST_LIB)/Tk/Menu/Item.pm \
	  Tk/Animation.pm $(INST_LIB)/Tk/Animation.pm \
	  Tk/MMutil.pm $(INST_LIB)/Tk/MMutil.pm \
	  Tk/FBox.pm $(INST_LIB)/Tk/FBox.pm \
	  Tk/ColorEdit.xpm $(INST_LIB)/Tk/ColorEdit.xpm \
	  Tk/Pane.pm $(INST_LIB)/Tk/Pane.pm \
	  tkGlue.m $(INST_ARCHLIBDIR)/Tk/tkGlue.m \
	  Tk/Button.pm $(INST_LIB)/Tk/Button.pm \
	  Tk/Font.pm $(INST_LIB)/Tk/Font.pm \
	  Tk/MMtry.pm $(INST_LIB)/Tk/MMtry.pm \
	  Tk/Pretty.pm $(INST_LIB)/Tk/Pretty.pm \
	  Tk/textfile.xpm $(INST_LIB)/Tk/textfile.xpm \
	  Tk/Camel.xpm $(INST_LIB)/Tk/Camel.xpm \
	  Tk/Trace.pm $(INST_LIB)/Tk/Trace.pm \
	  Tk/MainWindow.pm $(INST_LIB)/Tk/MainWindow.pm \
	  Tk/srcfile.xpm $(INST_LIB)/Tk/srcfile.xpm \
	  Tk/Image.pm $(INST_LIB)/Tk/Image.pm \
	  Tk/Radiobutton.pm $(INST_LIB)/Tk/Radiobutton.pm \
	  Tk/openfolder.xpm $(INST_LIB)/Tk/openfolder.xpm \
	  Tk/Derived.pm $(INST_LIB)/Tk/Derived.pm \
	  Tk/act_folder.xbm $(INST_LIB)/Tk/act_folder.xbm \
	  Tk/Xcamel.gif $(INST_LIB)/Tk/Xcamel.gif \
	  Tk/Bitmap.pm $(INST_LIB)/Tk/Bitmap.pm \
	  Tk/Spinbox.pm $(INST_LIB)/Tk/Spinbox.pm \
	  Tk/Label.pm $(INST_LIB)/Tk/Label.pm \
	  Tk/English.pm $(INST_LIB)/Tk/English.pm \
	  Tk/Region.pm $(INST_LIB)/Tk/Region.pm \
	  Tk/license.terms $(INST_LIB)/Tk/license.terms \
	  Tk/ErrorDialog.pm $(INST_LIB)/Tk/ErrorDialog.pm \
	  Tk/CmdLine.pm $(INST_LIB)/Tk/CmdLine.pm \
	  lib/Tie/Watch.pm blib/lib/Tie/Watch.pm \
	  Tk/Table.pm $(INST_LIB)/Tk/Table.pm \
	  Tk.pm $(INST_LIB)/Tk.pm \
	  Tk/icon.gif $(INST_LIB)/Tk/icon.gif 
	$(NOECHO) $(TOUCH) pm_to_blib


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
	cd pTk && $(MAKE) DEFINE="$(DEFINE)" $(PASTHRU)

perlmain.c : config Makefile

pTk/tk.res : $(MYEXTLIB)

basic      : $(INST_DYNAMIC) pm_to_blib

MANIFEST : MANIFEST.SKIP $(FIRST_MAKEFILE)
	$(MAKE) manifest



# End.

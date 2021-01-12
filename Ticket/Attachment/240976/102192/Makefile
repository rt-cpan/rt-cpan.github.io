# This Makefile is for the Wx extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.30_03 (Revision: 17783) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: (q[INC=/sw/include], q[LIBS=/sw/lib])
#
#   MakeMaker Parameters:

#     ABSTRACT_FROM => q[Wx.pm]
#     AUTHOR => q[Mattia Barbon <mbarbon@cpan.org>]
#     CCFLAGS => q[]
#     CONFIGURE => CODE(...)
#     EXE_FILES => [q[script/wx_xspp.pl], q[script/wx_overload.pl]]
#     LIBS => q[  -L/usr/local/lib/site_perl/5.8.8/darwin-thread-multi-2level/Alien/wxWidgets/mac_2_6_3/lib -lwx_mac_adv-2.6 -lwx_mac_media-2.6 -lwx_mac_html-2.6 -lwx_mac_core-2.6 -lwx_base_carbon-2.6]
#     NAME => q[Wx]
#     NO_META => q[1]
#     OBJECT => q[Wx.o Constant.o Controls.o Event.o Frames.o GDI.o Window.o ]
#     PMLIBDIRS => [q[lib], q[build]]
#     PREREQ_PM => { Alien::wxWidgets=>q[0.15], Test::Harness=>q[2.26], Test::More=>q[0.45], ExtUtils::MakeMaker=>q[6.17], Data::Dumper=>q[0], File::Spec::Functions=>q[0.82] }
#     VERSION_FROM => q[Wx.pm]
#     XSOPT => q[ -nolinenumbers -noprototypes ]

#   MakeMaker 'CONFIGURE' Parameters:

#     ABSTRACT_FROM => q[Wx.pm]
#     AUTHOR => q[Mattia Barbon <mbarbon@cpan.org>]
#     CC => q[g++]
#     CCFLAGS => q[ -UWX_PRECOMP  ]
#     CONFIGURE => CODE(...)
#     DEFINE => q[-D__WXMAC__ -D_FILE_OFFSET_BITS=64 -D_LARGE_FILES -DNO_GCC_PRAGMA  ]
#     EXE_FILES => [q[script/wx_xspp.pl], q[script/wx_overload.pl]]
#     INC => q[-I. -I. -I/usr/local/lib/site_perl/5.8.8/darwin-thread-multi-2level/Alien/wxWidgets/mac_2_6_3/lib/wx/include/mac-ansi-release-2.6 -I/usr/local/lib/site_perl/5.8.8/darwin-thread-multi-2level/Alien/wxWidgets/mac_2_6_3/include/wx-2.6 ]
#     LD => q[g++]
#     LIBS => q[  -L/usr/local/lib/site_perl/5.8.8/darwin-thread-multi-2level/Alien/wxWidgets/mac_2_6_3/lib -lwx_mac_adv-2.6 -lwx_mac_media-2.6 -lwx_mac_html-2.6 -lwx_mac_core-2.6 -lwx_base_carbon-2.6]
#     NAME => q[Wx]
#     NO_META => q[1]
#     OBJECT => q[Wx.o Constant.o Controls.o Event.o Frames.o GDI.o Window.o ]
#     PMLIBDIRS => [q[lib], q[build]]
#     PREREQ_PM => { Alien::wxWidgets=>q[0.15], Test::Harness=>q[2.26], Test::More=>q[0.45], ExtUtils::MakeMaker=>q[6.17], Data::Dumper=>q[0], File::Spec::Functions=>q[0.82] }
#     VERSION_FROM => q[Wx.pm]
#     WX => { wx_core_lib=>undef, wx_overload=>{ source=>q[cpp/ovl_const.cpp], header=>q[cpp/ovl_const.h] }, wx_top=>q[Wx.pm] }
#     XSOPT => q[ -nolinenumbers -noprototypes ]
#     clean => { FILES=>q[cpp/ovl_const.cpp cpp/ovl_const.h exists overload Opt copy_files files.lst cpp/setup.h cpp/plwindow.h cpp/artprov.h cpp/popupwin.h fix_alien wxPerl cpp/wxPerl.osx/build cpp/wxPerl.osx/wxPerl.c cpp/wxPerl.osx/wxPerl.r] }
#     depend => { $(INST_DYNAMIC)=>q[ wxPerl], $(INST_STATIC)=>q[ wxPerl] }
#     dynamic_lib => { OTHERLDFLAGS=>q[ ] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/local/perl/5.8.8/lib/darwin-thread-multi-2level/Config.pm)

# They may have been overridden via Makefile.PL or on the command line
AR = ar
CC = g++
CCCDLFLAGS =  
CCDLFLAGS =  
DLEXT = bundle
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = g++
LDDLFLAGS = -L/sw/lib -bundle -undefined dynamic_lookup 
LDFLAGS = -L/sw/lib 
LIBC = /usr/lib/libc.dylib
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = darwin
OSVERS = 8.7.1
RANLIB = ranlib
SITELIBEXP = /usr/local/lib/site_perl/5.8.8
SITEARCHEXP = /usr/local/lib/site_perl/5.8.8/darwin-thread-multi-2level
SO = dylib
VENDORARCHEXP = 
VENDORLIBEXP = 


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = Wx
NAME_SYM = Wx
VERSION = 0.57
VERSION_MACRO = VERSION
VERSION_SYM = 0_57
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.57
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
PREFIX = $(SITEPREFIX)
PERLPREFIX = /usr/local/perl/5.8.8
SITEPREFIX = /usr/local
VENDORPREFIX = 
INSTALLPRIVLIB = /usr/local/perl/5.8.8/lib
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = /usr/local/lib/site_perl/5.8.8
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = 
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = /usr/local/perl/5.8.8/lib/darwin-thread-multi-2level
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = /usr/local/lib/site_perl/5.8.8/darwin-thread-multi-2level
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = 
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = /usr/local/perl/5.8.8/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = /usr/local/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = 
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = /usr/local/perl/5.8.8/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = /usr/local/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = 
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = /usr/local/perl/5.8.8/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = /usr/local/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = 
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = /usr/local/perl/5.8.8/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = /usr/local/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = 
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /usr/local/perl/5.8.8/lib
PERL_ARCHLIB = /usr/local/perl/5.8.8/lib/darwin-thread-multi-2level
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/local/perl/5.8.8/lib/darwin-thread-multi-2level/CORE
PERL = /usr/local/bin/perl
FULLPERL = /usr/local/bin/perl
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/local/perl/5.8.8/lib/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.30_03
MM_REVISION = 17783

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = Wx
BASEEXT = Wx
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = Wx.pm
INC = /sw/include
DEFINE = -D__WXMAC__ -D_FILE_OFFSET_BITS=64 -D_LARGE_FILES -DNO_GCC_PRAGMA  
OBJECT = Wx$(OBJ_EXT) Constant$(OBJ_EXT) Controls$(OBJ_EXT) Event$(OBJ_EXT) Frames$(OBJ_EXT) GDI$(OBJ_EXT) Window$(OBJ_EXT) 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = Constant.xs \
	Controls.xs \
	Event.xs \
	Frames.xs \
	GDI.xs \
	Window.xs \
	Wx.xs
C_FILES  = Constant.c \
	Controls.c \
	Event.c \
	Frames.c \
	GDI.c \
	Window.c \
	Wx.c
O_FILES  = Constant.o \
	Controls.o \
	Event.o \
	Frames.o \
	GDI.o \
	Window.o \
	Wx.o
H_FILES  = 
MAN1PODS = script/wx_xspp.pl
MAN3PODS = Wx.pm \
	build/Wx/XSP/Node.pm \
	build/Wx/XSP/Parser.pm \
	build/Wx/XSP/Typemap.pm \
	build/Wx/XSP/XSpp.pod \
	build/Wx/build/MakeMaker.pm \
	build/Wx/build/Options.pm \
	build/Wx/build/Utils.pm \
	lib/Wx/Api.pod

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


TO_INST_PM = Wx.pm \
	build/Wx/Overload/Driver.pm \
	build/Wx/Overload/Handle.pm \
	build/Wx/XSP/Driver.pm \
	build/Wx/XSP/Grammar.pm \
	build/Wx/XSP/Node.pm \
	build/Wx/XSP/Parser.pm \
	build/Wx/XSP/Typemap.pm \
	build/Wx/XSP/XSP.yp \
	build/Wx/XSP/XSpp.pod \
	build/Wx/build/MakeMaker.pm \
	build/Wx/build/MakeMaker/Any_OS.pm \
	build/Wx/build/MakeMaker/Any_wx_config.pm \
	build/Wx/build/MakeMaker/Core.pm \
	build/Wx/build/MakeMaker/Hacks.pm \
	build/Wx/build/MakeMaker/MacOSX_GCC.pm \
	build/Wx/build/MakeMaker/Win32.pm \
	build/Wx/build/MakeMaker/Win32_MSVC.pm \
	build/Wx/build/MakeMaker/Win32_MinGW.pm \
	build/Wx/build/Options.pm \
	build/Wx/build/Utils.pm \
	lib/Wx/Api.pod \
	lib/Wx/App.pm \
	lib/Wx/ArtProvider.pm \
	lib/Wx/Event.pm \
	lib/Wx/Locale.pm \
	lib/Wx/Menu.pm \
	lib/Wx/Mini.pm \
	lib/Wx/RadioBox.pm \
	lib/Wx/Region.pm \
	lib/Wx/Timer.pm

PM_TO_BLIB = build/Wx/XSP/XSpp.pod \
	$(INST_LIB)/Wx/XSP/XSpp.pod \
	build/Wx/XSP/XSP.yp \
	$(INST_LIB)/Wx/XSP/XSP.yp \
	build/Wx/build/MakeMaker/Win32_MinGW.pm \
	$(INST_LIB)/Wx/build/MakeMaker/Win32_MinGW.pm \
	lib/Wx/Event.pm \
	blib/lib/Wx/Event.pm \
	build/Wx/build/MakeMaker.pm \
	$(INST_LIB)/Wx/build/MakeMaker.pm \
	build/Wx/Overload/Handle.pm \
	$(INST_LIB)/Wx/Overload/Handle.pm \
	build/Wx/Overload/Driver.pm \
	$(INST_LIB)/Wx/Overload/Driver.pm \
	lib/Wx/Region.pm \
	blib/lib/Wx/Region.pm \
	build/Wx/build/MakeMaker/Hacks.pm \
	$(INST_LIB)/Wx/build/MakeMaker/Hacks.pm \
	lib/Wx/App.pm \
	blib/lib/Wx/App.pm \
	lib/Wx/Mini.pm \
	blib/lib/Wx/Mini.pm \
	build/Wx/build/MakeMaker/Any_wx_config.pm \
	$(INST_LIB)/Wx/build/MakeMaker/Any_wx_config.pm \
	build/Wx/XSP/Typemap.pm \
	$(INST_LIB)/Wx/XSP/Typemap.pm \
	build/Wx/build/MakeMaker/Core.pm \
	$(INST_LIB)/Wx/build/MakeMaker/Core.pm \
	lib/Wx/Timer.pm \
	blib/lib/Wx/Timer.pm \
	build/Wx/build/Options.pm \
	$(INST_LIB)/Wx/build/Options.pm \
	lib/Wx/Locale.pm \
	blib/lib/Wx/Locale.pm \
	build/Wx/build/Utils.pm \
	$(INST_LIB)/Wx/build/Utils.pm \
	build/Wx/XSP/Grammar.pm \
	$(INST_LIB)/Wx/XSP/Grammar.pm \
	lib/Wx/Api.pod \
	blib/lib/Wx/Api.pod \
	build/Wx/XSP/Parser.pm \
	$(INST_LIB)/Wx/XSP/Parser.pm \
	build/Wx/build/MakeMaker/MacOSX_GCC.pm \
	$(INST_LIB)/Wx/build/MakeMaker/MacOSX_GCC.pm \
	lib/Wx/ArtProvider.pm \
	blib/lib/Wx/ArtProvider.pm \
	build/Wx/XSP/Node.pm \
	$(INST_LIB)/Wx/XSP/Node.pm \
	build/Wx/build/MakeMaker/Any_OS.pm \
	$(INST_LIB)/Wx/build/MakeMaker/Any_OS.pm \
	build/Wx/XSP/Driver.pm \
	$(INST_LIB)/Wx/XSP/Driver.pm \
	lib/Wx/RadioBox.pm \
	blib/lib/Wx/RadioBox.pm \
	lib/Wx/Menu.pm \
	blib/lib/Wx/Menu.pm \
	build/Wx/build/MakeMaker/Win32_MSVC.pm \
	$(INST_LIB)/Wx/build/MakeMaker/Win32_MSVC.pm \
	build/Wx/build/MakeMaker/Win32.pm \
	$(INST_LIB)/Wx/build/MakeMaker/Win32.pm \
	Wx.pm \
	$(INST_LIB)/Wx.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 1.50_02
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:

XSUBPPDIR = /usr/local/perl/5.8.8/lib/ExtUtils
XSUBPP = $(XSUBPPDIR)$(DFSEP)xsubpp
XSUBPPRUN = $(PERLRUN) $(XSUBPP)
XSPROTOARG = 
XSUBPPDEPS = /usr/local/perl/5.8.8/lib/ExtUtils/typemap typemap $(XSUBPP)
XSUBPPARGS =  -nolinenumbers -noprototypes  -typemap /usr/local/perl/5.8.8/lib/ExtUtils/typemap -typemap typemap
XSUBPP_EXTRA_ARGS = 


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(SHELL) -c true
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) "-MExtUtils::Command" -e mkpath
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) "-MExtUtils::Command" -e eqtime
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install({@ARGV}, '\''$(VERBINST)'\'', 0, '\''$(UNINST)'\'');' --
DOC_INSTALL = $(ABSPERLRUN) "-MExtUtils::Command::MM" -e perllocal_install
UNINSTALL = $(ABSPERLRUN) "-MExtUtils::Command::MM" -e uninstall
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) "-MExtUtils::Command::MM" -e warn_if_old_packlist
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(PERLRUN) "-MExtUtils::MY" -e "MY->fixin(shift)"


# --- MakeMaker makemakerdflt section:
makemakerdflt: all
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
DISTNAME = Wx
DISTVNAME = Wx-0.57


# --- MakeMaker macro section:


# --- MakeMaker depend section:
Event.c :  Event.xs XS/EvtHandler.xs
Window.o :  Window.c cpp/chkconfig.h cpp/compat.h cpp/helpers.h cpp/overload.h cpp/ovl_const.h cpp/scrolledwindow.h cpp/setup.h cpp/sizer.h cpp/v_cback.h cpp/validators.h cpp/window.h cpp/wxapi.h cpp/wxsizer.h
$(INST_DYNAMIC) :  wxPerl fix_alien blib/lib/Wx/Wx_Exp.pm
Controls.c :  Controls.xs XS/BitmapButton.xs XS/BookCtrl.xsp XS/Button.xs XS/CheckBox.xs XS/CheckListBox.xs XS/Choice.xs XS/Choicebook.xsp XS/ComboBox.xs XS/Gauge.xs XS/HyperlinkCtrl.xsp XS/ListBox.xs XS/ListCtrl.xs XS/Listbook.xsp XS/Notebook.xs XS/RadioBox.xs XS/RadioButton.xs XS/ScrollBar.xs XS/Slider.xs XS/SpinButton.xs XS/SpinCtrl.xs XS/StaticBitmap.xs XS/StaticBox.xs XS/StaticLine.xs XS/StaticText.xs XS/TextCtrl.xs XS/ToggleButton.xs XS/Toolbook.xsp XS/TreeCtrl.xs XS/Treebook.xsp
Wx.o :  Wx.c cpp/app.h cpp/artprov.h cpp/chkconfig.h cpp/compat.h cpp/helpers.cpp cpp/helpers.h cpp/log.h cpp/overload.cpp cpp/overload.h cpp/ovl_const.cpp cpp/ovl_const.h cpp/process.h cpp/setup.h cpp/streams.cpp cpp/streams.h cpp/timer.h cpp/tipprovider.h cpp/v_cback.cpp cpp/v_cback.h cpp/wxapi.h
Constant.c :  Constant.xs 
Constant.o :  Constant.c cpp/chkconfig.h cpp/compat.h cpp/constants.h cpp/e_cback.h cpp/helpers.h cpp/setup.h cpp/wxapi.h
Wx.c :  Wx.xs XS/App.xs XS/ArtProvider.xsp XS/Caret.xs XS/ClassInfo.xs XS/Config.xs XS/FontEnumerator.xs XS/FontMapper.xs XS/Geom.xs XS/Locale.xs XS/Log.xs XS/Menu.xs XS/MimeTypes.xsp XS/Power.xsp XS/Process.xs XS/Sound.xsp XS/Stream.xs XS/TaskBarIcon.xs XS/Timer.xs XS/ToolTip.xs XS/Utils.xs XS/Wave.xs
Window.c :  Window.xs XS/Accelerators.xs XS/Constraint.xs XS/GridBagSizer.xsp XS/PlWindow.xsp XS/SashWindow.xs XS/ScrolledWindow.xs XS/Sizer.xs XS/SplitterWindow.xs XS/Validators.xs
Frames.c :  Frames.xs XS/ColourDialog.xs XS/Dialog.xs XS/DirDialog.xs XS/FileDialog.xs XS/FindReplaceDialog.xs XS/FontDialog.xs XS/Frame.xs XS/IconBundle.xsp XS/MessageDialog.xs XS/MultiChoiceDialog.xs XS/Panel.xs XS/PopupWindow.xsp XS/ProgressDialog.xs XS/SingleChoiceDialog.xs XS/StatusBar.xs XS/TextEntryDialog.xs XS/ToolBar.xs XS/TopLevelWindow.xsp XS/Wizard.xs
pm_to_blib :  copy_files
copy_files :  cpp/wxapi.h cpp/overload.h cpp/helpers.h cpp/constants.h cpp/setup.h cpp/streams.h cpp/chkconfig.h cpp/v_cback.h Opt cpp/compat.h typemap cpp/event.h cpp/e_cback.h
blibdirs.ts :  copy_files
blibdirs :  copy_files
Frames.o :  Frames.c cpp/chkconfig.h cpp/compat.h cpp/dialog.h cpp/frame.h cpp/helpers.h cpp/overload.h cpp/ovl_const.h cpp/panel.h cpp/setup.h cpp/singlechoicedialog.h cpp/v_cback.h cpp/wizard.h cpp/wxapi.h
cpp/ovl_const.cpp :  overload
$(INST_STATIC) :  wxPerl fix_alien blib/lib/Wx/Wx_Exp.pm
Controls.o :  Controls.c cpp/chkconfig.h cpp/compat.h cpp/constants.h cpp/controls.cpp cpp/controls.h cpp/helpers.h cpp/overload.h cpp/ovl_const.h cpp/setup.h cpp/v_cback.h cpp/wxapi.h
fix_alien :  pm_to_blib
GDI.c :  GDI.xs XS/Bitmap.xs XS/Brush.xs XS/Colour.xs XS/Cursor.xs XS/DC.xs XS/Font.xs XS/Icon.xs XS/Image.xs XS/ImageList.xs XS/Palette.xs XS/Pen.xs
blib/lib/Wx/Wx_Exp.pm :  ./Constant.xs ./blib/lib/Wx/Calendar.pm ./blib/lib/Wx/DND.pm ./blib/lib/Wx/Event.pm ./blib/lib/Wx/Media.pm ./blib/lib/Wx/STC.pm ./cpp/controls.cpp ./ext/calendar/Calendar.pm ./ext/calendar/cpp/calendar.h ./ext/calendar/cpp/datectrl.h ./ext/calendar/XS/CalendarCtrl.xsp ./ext/calendar/XS/DatePickerCtrl.xsp ./ext/dnd/cpp/dn_constants.cpp ./ext/dnd/lib/Wx/DND.pm ./ext/docview/cpp/dv_constants.cpp ./ext/grid/cpp/gr_constants.cpp ./ext/html/cpp/ht_constants.cpp ./ext/media/cpp/me_constants.cpp ./ext/media/lib/Wx/Media.pm ./ext/print/cpp/pr_constants.cpp ./ext/socket/cpp/sk_constants.cpp ./ext/stc/cpp/st_constants.cpp ./ext/stc/lib/Wx/STC.pm ./ext/xrc/cpp/xr_constants.cpp ./lib/Wx/Event.pm
Event.o :  Event.c cpp/chkconfig.h cpp/compat.h cpp/e_cback.cpp cpp/e_cback.h cpp/event.h cpp/helpers.h cpp/setup.h cpp/v_cback.h cpp/wxapi.h
GDI.o :  GDI.c cpp/chkconfig.h cpp/compat.h cpp/helpers.h cpp/overload.h cpp/ovl_const.h cpp/setup.h cpp/streams.h cpp/wxapi.h wxpl.xpm
cpp/ovl_const.h :  cpp/ovl_const.cpp


# --- MakeMaker cflags section:

CCFLAGS =  -UWX_PRECOMP  
OPTIMIZE = -O3
PERLTYPE = 
MPOLLUTE = 


# --- MakeMaker const_loadlibs section:

# Wx might depend on some other libraries:
# See ExtUtils::Liblist for details
#


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

.C$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.C

.cpp$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cpp

.cxx$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cxx

.cc$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cc


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
	$(NOECHO) $(CHMOD) 755 $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) 755 $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) 755 $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) 755 $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) 755 $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) 755 $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) 755 $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) 755 $(INST_MAN3DIR)
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
	$(LD)  $(LDDLFLAGS) $(LDFROM) $(OTHERLDFLAGS) -o $@ $(MYEXTLIB)	\
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
	script/wx_xspp.pl \
	build/Wx/XSP/Node.pm \
	build/Wx/XSP/XSpp.pod \
	lib/Wx/Api.pod \
	build/Wx/XSP/Typemap.pm \
	build/Wx/build/MakeMaker.pm \
	build/Wx/XSP/Parser.pm \
	build/Wx/build/Options.pm \
	Wx.pm \
	build/Wx/build/Utils.pm \
	build/Wx/XSP/Node.pm \
	build/Wx/XSP/XSpp.pod \
	lib/Wx/Api.pod \
	build/Wx/XSP/Typemap.pm \
	build/Wx/build/MakeMaker.pm \
	build/Wx/XSP/Parser.pm \
	build/Wx/build/Options.pm \
	Wx.pm \
	build/Wx/build/Utils.pm
	$(NOECHO) $(POD2MAN) --section=1 --perm_rw=$(PERM_RW) \
	  script/wx_xspp.pl $(INST_MAN1DIR)/wx_xspp.pl.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  build/Wx/XSP/Node.pm $(INST_MAN3DIR)/build::Wx::XSP::Node.$(MAN3EXT) \
	  build/Wx/XSP/XSpp.pod $(INST_MAN3DIR)/build::Wx::XSP::XSpp.$(MAN3EXT) \
	  lib/Wx/Api.pod $(INST_MAN3DIR)/Wx::Api.$(MAN3EXT) \
	  build/Wx/XSP/Typemap.pm $(INST_MAN3DIR)/build::Wx::XSP::Typemap.$(MAN3EXT) \
	  build/Wx/build/MakeMaker.pm $(INST_MAN3DIR)/build::Wx::build::MakeMaker.$(MAN3EXT) \
	  build/Wx/XSP/Parser.pm $(INST_MAN3DIR)/build::Wx::XSP::Parser.$(MAN3EXT) \
	  build/Wx/build/Options.pm $(INST_MAN3DIR)/build::Wx::build::Options.$(MAN3EXT) \
	  Wx.pm $(INST_MAN3DIR)/Wx.$(MAN3EXT) \
	  build/Wx/build/Utils.pm $(INST_MAN3DIR)/build::Wx::build::Utils.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = script/wx_xspp.pl script/wx_overload.pl

pure_all :: $(INST_SCRIPT)/wx_xspp.pl $(INST_SCRIPT)/wx_overload.pl
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/wx_xspp.pl $(INST_SCRIPT)/wx_overload.pl 

$(INST_SCRIPT)/wx_xspp.pl : script/wx_xspp.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/wx_xspp.pl
	$(CP) script/wx_xspp.pl $(INST_SCRIPT)/wx_xspp.pl
	$(FIXIN) $(INST_SCRIPT)/wx_xspp.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/wx_xspp.pl

$(INST_SCRIPT)/wx_overload.pl : script/wx_overload.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/wx_overload.pl
	$(CP) script/wx_overload.pl $(INST_SCRIPT)/wx_overload.pl
	$(FIXIN) $(INST_SCRIPT)/wx_overload.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/wx_overload.pl



# --- MakeMaker subdirs section:
subdirs :: overload


# The default clean, realclean and test targets in this Makefile
# have automatically been given entries for each subdir.


subdirs ::
	$(NOECHO) cd ext && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)


# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(ABSPERLRUN)  -e 'chdir '\''ext'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  Controls.c Constant.c \
	  core.[0-9] $(BASEEXT).bso \
	  Wx.c pm_to_blib.ts \
	  core.[0-9][0-9][0-9][0-9] perl$(EXE_EXT) \
	  tmon.out *$(OBJ_EXT) \
	  pm_to_blib blibdirs.ts \
	  *perl.core core.*perl.*.? \
	  $(BASEEXT).def core.[0-9][0-9][0-9] \
	  mon.out lib$(BASEEXT).def \
	  perl.exe perlmain.c \
	  GDI.c so_locations \
	  $(BASEEXT).exp Event.c \
	  *$(LIB_EXT) core \
	  $(INST_ARCHAUTODIR)/extralibs.all core.[0-9][0-9] \
	  Window.c $(BOOTSTRAP) \
	  $(BASEEXT).x Frames.c \
	  $(INST_ARCHAUTODIR)/extralibs.ld core.[0-9][0-9][0-9][0-9][0-9] \
	  $(MAKE_APERL_FILE) perl 
	- $(RM_RF) \
	  cpp/setup.h cpp/wxPerl.osx/wxPerl.c \
	  cpp/wxPerl.osx/build cpp/artprov.h \
	  cpp/wxPerl.osx/wxPerl.r files.lst \
	  copy_files cpp/popupwin.h \
	  overload cpp/ovl_const.cpp \
	  wxPerl fix_alien \
	  Opt cpp/plwindow.h \
	  exists cpp/ovl_const.h \
	  blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	- $(ABSPERLRUN)  -e 'chdir '\''ext'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''ext'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(OBJECT) $(MAKEFILE_OLD) \
	  $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile:
	$(NOECHO) $(NOOP)


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
	$(RM_F) *~ *.orig */*~ */*.orig



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

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL "INC=/sw/include" "LIBS=/sw/lib"
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

install :: all pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: all pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: all pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: all pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install ::
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


pure_site_install ::
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

pure_vendor_install ::
	$(NOECHO) $(MOD_INSTALL) \
		read $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLVENDORARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_site_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_vendor_install ::
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


install :: install_wxperl



# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE:
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
	$(PERL_INC)/thrdvar.h		\
	$(PERL_INC)/thread.h		\
	$(PERL_INC)/unixish.h		\
	$(PERL_INC)/util.h

$(OBJECT) : $(PERL_HDRS)

Event.c Wx.c GDI.c Constant.c Window.c Frames.c Controls.c : $(XSUBPPDEPS)


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
	$(PERLRUN) Makefile.PL "INC=/sw/include" "LIBS=/sw/lib"
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	false



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/local/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR=ext \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS= \
		INC=/sw/include \
		LIBS=/sw/lib


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE)
	$(NOECHO) $(ABSPERLRUN)  -e 'chdir '\''ext'\'';  ' \
	  -e 'system '\''$(MAKE) test $(PASTHRU)'\'' ' \
	  -e '    if -f '\''$(FIRST_MAKEFILE)'\'';' --

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
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="0,57,0,0">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <TITLE>$(DISTNAME)</TITLE>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>interface to the wxWidgets cross-platform GUI toolkit</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Mattia Barbon &lt;mbarbon@cpan.org&gt;</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Alien-wxWidgets" VERSION="0,15,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Data-Dumper" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="ExtUtils-MakeMaker" VERSION="6,17,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="File-Spec-Functions" VERSION="0,82,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Test-Harness" VERSION="2,26,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Test-More" VERSION="0,45,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <OS NAME="$(OSNAME)" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="darwin-thread-multi-2level" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  build/Wx/XSP/XSpp.pod $(INST_LIB)/Wx/XSP/XSpp.pod \
	  build/Wx/XSP/XSP.yp $(INST_LIB)/Wx/XSP/XSP.yp \
	  build/Wx/build/MakeMaker/Win32_MinGW.pm $(INST_LIB)/Wx/build/MakeMaker/Win32_MinGW.pm \
	  lib/Wx/Event.pm blib/lib/Wx/Event.pm \
	  build/Wx/build/MakeMaker.pm $(INST_LIB)/Wx/build/MakeMaker.pm \
	  build/Wx/Overload/Handle.pm $(INST_LIB)/Wx/Overload/Handle.pm \
	  build/Wx/Overload/Driver.pm $(INST_LIB)/Wx/Overload/Driver.pm \
	  lib/Wx/Region.pm blib/lib/Wx/Region.pm \
	  build/Wx/build/MakeMaker/Hacks.pm $(INST_LIB)/Wx/build/MakeMaker/Hacks.pm \
	  lib/Wx/App.pm blib/lib/Wx/App.pm \
	  lib/Wx/Mini.pm blib/lib/Wx/Mini.pm \
	  build/Wx/build/MakeMaker/Any_wx_config.pm $(INST_LIB)/Wx/build/MakeMaker/Any_wx_config.pm \
	  build/Wx/XSP/Typemap.pm $(INST_LIB)/Wx/XSP/Typemap.pm \
	  build/Wx/build/MakeMaker/Core.pm $(INST_LIB)/Wx/build/MakeMaker/Core.pm \
	  lib/Wx/Timer.pm blib/lib/Wx/Timer.pm \
	  build/Wx/build/Options.pm $(INST_LIB)/Wx/build/Options.pm \
	  lib/Wx/Locale.pm blib/lib/Wx/Locale.pm \
	  build/Wx/build/Utils.pm $(INST_LIB)/Wx/build/Utils.pm \
	  build/Wx/XSP/Grammar.pm $(INST_LIB)/Wx/XSP/Grammar.pm \
	  lib/Wx/Api.pod blib/lib/Wx/Api.pod \
	  build/Wx/XSP/Parser.pm $(INST_LIB)/Wx/XSP/Parser.pm \
	  build/Wx/build/MakeMaker/MacOSX_GCC.pm $(INST_LIB)/Wx/build/MakeMaker/MacOSX_GCC.pm \
	  lib/Wx/ArtProvider.pm blib/lib/Wx/ArtProvider.pm \
	  build/Wx/XSP/Node.pm $(INST_LIB)/Wx/XSP/Node.pm \
	  build/Wx/build/MakeMaker/Any_OS.pm $(INST_LIB)/Wx/build/MakeMaker/Any_OS.pm \
	  build/Wx/XSP/Driver.pm $(INST_LIB)/Wx/XSP/Driver.pm \
	  lib/Wx/RadioBox.pm blib/lib/Wx/RadioBox.pm \
	  lib/Wx/Menu.pm blib/lib/Wx/Menu.pm \
	  build/Wx/build/MakeMaker/Win32_MSVC.pm $(INST_LIB)/Wx/build/MakeMaker/Win32_MSVC.pm \
	  build/Wx/build/MakeMaker/Win32.pm $(INST_LIB)/Wx/build/MakeMaker/Win32.pm \
	  Wx.pm $(INST_LIB)/Wx.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:

blib/lib/Wx/Wx_Exp.pm :
	$(PERL) script/make_exp_list.pl blib/lib/Wx/Wx_Exp.pm ./Constant.xs ./blib/lib/Wx/Calendar.pm ./blib/lib/Wx/DND.pm ./blib/lib/Wx/Event.pm ./blib/lib/Wx/Media.pm ./blib/lib/Wx/STC.pm ./cpp/controls.cpp ./ext/calendar/Calendar.pm ./ext/calendar/cpp/calendar.h ./ext/calendar/cpp/datectrl.h ./ext/calendar/XS/CalendarCtrl.xsp ./ext/calendar/XS/DatePickerCtrl.xsp ./ext/dnd/cpp/dn_constants.cpp ./ext/dnd/lib/Wx/DND.pm ./ext/docview/cpp/dv_constants.cpp ./ext/grid/cpp/gr_constants.cpp ./ext/html/cpp/ht_constants.cpp ./ext/media/cpp/me_constants.cpp ./ext/media/lib/Wx/Media.pm ./ext/print/cpp/pr_constants.cpp ./ext/socket/cpp/sk_constants.cpp ./ext/stc/cpp/st_constants.cpp ./ext/stc/lib/Wx/STC.pm ./ext/xrc/cpp/xr_constants.cpp ./lib/Wx/Event.pm

copy_files :
	$(PERL) script/copy_files.pl files.lst
	$(TOUCH) copy_files

fix_alien : lib/Wx/Mini.pm
	$(PERL) script/fix_alien_path.pl lib/Wx/Mini.pm blib/lib/Wx/Mini.pm
	$(TOUCH) fix_alien

parser :
	yapp -v -s -m Wx::XSP::Grammar -o build/Wx/XSP/Grammar.pm build/Wx/XSP/XSP.yp

overload :
	$(PERL) script/wx_overload.pl cpp/ovl_const.cpp cpp/ovl_const.h ./Controls.xs ./Window.xs ./Wx.xs ./blib/lib/Wx/DropSource.pm ./blib/lib/Wx/Grid.pm ./blib/lib/Wx/Locale.pm ./blib/lib/Wx/Menu.pm ./blib/lib/Wx/RadioBox.pm ./blib/lib/Wx/Region.pm ./blib/lib/Wx/Timer.pm ./blib/lib/Wx/build/Utils.pm ./blib/lib/Wx/Overload/Driver.pm ./build/Wx/build/Utils.pm ./build/Wx/Overload/Driver.pm ./ext/calendar/XS/CalendarCtrl.xsp ./ext/calendar/XS/DatePickerCtrl.xsp ./ext/dnd/lib/Wx/DropSource.pm ./ext/grid/lib/Wx/Grid.pm ./ext/grid/XS/Grid.xs ./ext/media/XS/MediaCtrl.xsp ./ext/xrc/XS/XmlResource.xs ./lib/Wx/Locale.pm ./lib/Wx/Menu.pm ./lib/Wx/RadioBox.pm ./lib/Wx/Region.pm ./lib/Wx/Timer.pm ./XS/Bitmap.xs ./XS/BitmapButton.xs ./XS/Brush.xs ./XS/Button.xs ./XS/Caret.xs ./XS/CheckBox.xs ./XS/CheckListBox.xs ./XS/Choice.xs ./XS/Choicebook.xsp ./XS/Colour.xs ./XS/ComboBox.xs ./XS/Cursor.xs ./XS/DC.xs ./XS/Dialog.xs ./XS/Font.xs ./XS/Frame.xs ./XS/Gauge.xs ./XS/Geom.xs ./XS/GridBagSizer.xsp ./XS/HyperlinkCtrl.xsp ./XS/Icon.xs ./XS/IconBundle.xsp ./XS/Image.xs ./XS/ImageList.xs ./XS/Listbook.xsp ./XS/ListBox.xs ./XS/ListCtrl.xs ./XS/Notebook.xs ./XS/Panel.xs ./XS/Pen.xs ./XS/PlWindow.xsp ./XS/PopupWindow.xsp ./XS/RadioBox.xs ./XS/RadioButton.xs ./XS/SashWindow.xs ./XS/ScrollBar.xs ./XS/ScrolledWindow.xs ./XS/Sizer.xs ./XS/Slider.xs ./XS/Sound.xsp ./XS/SpinButton.xs ./XS/SpinCtrl.xs ./XS/SplitterWindow.xs ./XS/StaticBitmap.xs ./XS/TextCtrl.xs ./XS/ToggleButton.xs ./XS/ToolBar.xs ./XS/Toolbook.xsp ./XS/TopLevelWindow.xsp ./XS/Treebook.xsp ./XS/TreeCtrl.xs ./XS/Wizard.xs
	$(TOUCH) overload


wxPerl : Makefile
	echo '#include <Carbon.r>' > cpp/wxPerl.osx/wxPerl.r
	cd cpp/wxPerl.osx && xcodebuild -project wxPerl.xcode
	cp -p $(PERL) `find cpp -name wxPerl.app`/Contents/MacOS/wxPerl
	mkdir -p $(INST_ARCHLIB)/auto/Wx
	cp -rp `find cpp -name wxPerl.app` $(INST_ARCHLIB)/auto/Wx
	$(CC) cpp/wxPerl.osx/wxPerl.c -o wxPerl

install_wxperl :
	mkdir -p $(DESTINSTALLBIN)
	cp -p wxPerl $(DESTINSTALLBIN)



# End.

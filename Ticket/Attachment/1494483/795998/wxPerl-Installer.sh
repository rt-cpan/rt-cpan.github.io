#!/bin/bash
#
# wxPerl Installation Script for Ubuntu 14.04LTS 64bit
#
# Author:		Steve Cookson (Kbuntu 14.04LTS 64bit Version)
# Modified By:		James M. Lynes, Jr.
# Last Modified:	October 9, 2014
#
# To Install:	Save this file as ~/Perl/wxPerl-Installer.sh
#		Open a Terminal window
#		cd ~/Perl
#		sudo -s
#		sh -v wxPerl-Installer.sh > ~/Perl/wxPerl-Installer.log
#
#		(sh wxPerl-Installer.sh if you don't want the log file created, about 2MB)
#		(all output will then go only to your screen) 
#
# Notes:	This script uses your system Perl(v5.18.2 in 14.04LTS).
#		The wxPerl Demo program installs into /usr/local/bin/wxperl_demo.pl
#		Installation log saved in ~/Perl/wxPerl-Installer.log.
#		Installation script run time saved in ~/Perl/wxPerl-Installer.runtime.
#		Installs wxWidgets 3.0.1 below your home directory.
#			see the --wxWidgets-version=3.0.1 line below.
#		Modify this script to add any libraries or Perl Modules you require.
#		Modify this script to put log files in other than ~/Perl/.
#		Uncomment optional git sections below to create local
#			repositories for wxWidgets and wxPerl.
#		Comment out the rm -rf Alien-wxWidgets and rm -rf wxPerl
#			to leave previous downloads intact.
#		root owns the files created by this script. Must be su to delete.
#		See below for creating a Launcher for wxperl_demo.pl
#		This script takes approximately 1 hour and 30 minutes to run
#			the first time on an HP 15 with Intel 2.16 GHz Quadcore.
#			Approximately 45 minutes there after since system libraries
#			and cpan modules were installed/updated the first time.
#
#

date					# Note the start date/time
date > ~/Perl/wxPerl-Installer.runtime	# Log the start date/time
#
cd ~					# Install into your home directory
#
# Clean up prior installation(optional)
#
rm -rf Alien-wxWidgets								# Optional clean install
rm -rf wxPerl									# |
find /usr | grep -i wx | grep -v -i python | grep -v -i soffice > rm_wx.sh	# | Collect wx files. Exclude wxpython, and soffice files
sed -i -e 's/\/usr\//rm -rf \/usr\//g' rm_wx.sh					# | Build a rm command
sh rm_wx.sh									# | Remove them
#
# Reset packages in case there was a previous crash.
#
dpkg --configure -a			# Configure all unpacked packages
apt-get -y update			# Resync package indexes
apt-get -y upgrade			# Install newest version of packages
#
# Install the dependencies first
#
# Install the Development Environment
#
apt-get -y install make                 # Needed for cpan
apt-get -y install g++
apt-get -y install gcc
apt-get -y install subversion        	# Needed for proper Alien-wxWidgets and wxPerl
apt-get -y install git                  # Needed for custom install Alien-wxWidgets and wxPerl
apt-get -y install libgconf2-dev	# Needed as wxMediaCtrl dependency
apt-get -y install libgtk-3-dev		# Needed as wxMediaCtrl dependency
apt-get -y install libexpat1-dev
apt-get -y install libtiff4-dev
apt-get -y install libpng12-dev
apt-get -y install libjpeg-dev
apt-get -y install libcairo2-dev
apt-get -y install libxmu-dev
apt-get -y install libwebkitgtk-dev
#
# Install the Video environment (wxMediaCtrl dependencies)
#
apt-get -y install libgstreamer0.10-dev			# Needed for Alien-wxWidgets and wxPerl
apt-get -y install libgstreamer-plugins-base0.10-dev	# Needed for Alien-wxWidgets and wxPerl
#
apt-get -y install cups-pdf                             # Needed for PDF printing
apt-get -y install apparmor-utils			# Confine an application's resources
aa-complain cupsd					# Report resource policy violations
#
# Install Perl modules
#
cpan -i ExtUtils::XSpp					# Needed by wxPerl/Alien install
cpan -i ExtUtils::ParseXS				# Needed by wxPerl Makefile.PL
cpan -i XSLoader					# Needed by wxPerl/Alien install
cpan -i Encode						# Needed for utf-8
cpan -i Test::Pod					# ?
cpan -i ExtUtils::MakeMaker				# ?
cpan -i Pod::Coverage					# ?
cpan -i Test::Pod::Coverage				# ?
#
# Install OpenGL and Dependencies
#
apt-get -y install libglu1-mesa-dev
apt-get -y install freeglut3-dev
apt-get -y install mesa-common-dev			# Needed by OpenGL
apt-get -y install libsdl1.2-dev			# ?
apt-get -y remove libwxgtk2.8-dev
apt-get -y install libwxgtk3.0-dev
apt-get autoremove					# Remove packages no longer needed
cpan -i OpenGL
#
# Download Alien-wxWidgets(wxWidgets)
#
cd ~
svn co https://svn.code.sf.net/p/wxperl/code/Alien-wxWidgets/trunk Alien-wxWidgets
#git clone https://github.com/SteveBz/Alien-wxWidgets 	# Optional location
#
# Compile wxWidgets
#
cd ~/Alien-wxWidgets
perl Build.PL \
    --wxWidgets-build=1 \
    --wxWidgets-graphicscontext \
    --wxWidgets-build-opengl=1 \
    --wxWidgets-version=3.0.1 \
    --wxWidgets-source=tar.bz2 \
    --wxWidgets-unicode=1 \
    --wx-unicode='yes' \
    --wxWidgets-extraflags="--enable-graphics_ctx \
                        --disable-compat26 \
                        --enable-mediactrl \
                        --with-libjpeg=builtin \
                        --with-libpng=builtin \
                        --with-regex=builtin \
                        --with-libtiff=builtin \
                        --with-zlib=builtin \
                        --with-expat=builtin \
                        --with-libxpm=builtin \
                        --with-gtk=2\
                        --with-gtkprint"
#
# Build wxWidgets
#
perl Build
# Baseline Alien-wxWidgets on git.			# Optional local wxWidgets repository
#git init						# |
#git add *						# |
#git commit -am "Adding Alien-wxWidgets baseline"	# |
perl Build install
ldconfig						# Configure dynamic linker run-time bindings
#
# Download wxPerl
#				
cd ~
svn co https://svn.code.sf.net/p/wxperl/code/wxPerl/trunk wxPerl
#git clone https://github.com/SteveBz/wxPerl 		# Optional location
#
# Build wxPerl
#
cd ~/wxPerl
perl Makefile.PL
make
# Baseline wxPerl on git.				# Optional local wxPerl repository
#git init						# |
#git add ~/wxPerl					# |
#git commit -am "Adding wxPerl baseline"		# |
make install
#
# Install predecessors for Wx::PdfDocuments
#
cd ~
cpan -i Wx::GLCanvas
cpan -i Text::Patch
cpan -i Wx::PdfDocument
#
# Install wxDemo					# Installs into /usr/local/bin/wxperl_demo.pl
#
cpan -i Wx::Demo
#
# Install Locally Needed Modules(modify for your environment)
#
cpan -i App::cpanminus
cpan -i Device::SerialPort
apt-get -y install php5-gd				# Needed for GD
apt-get -y install libgd2-xpm-dev			# Needed for GD
cpan -i GD
cpan -i GD::Text
cpan -i GD::Graph
#
# Done
#
date							# Note the ending date/time
date >> ~/Perl/wxPerl-Installer.runtime			# Log the ending date/time
#
#
#	To create a Launcher for wxperl_demo.pl
#
#	Copy the lines below into ~/Perl/wxperl_demo.desktop
#		(Without the leading # and tab)
#	Make the file executable
#		(icon changes to wxpl.ico)
#	Drag the icon to the Launcher
#	Click on the icon to Launch wxperl_demo.pl
#
#
#	[Desktop Entry]
#	Name=wxPerl_Demo
#	Type=Application
#	Terminal=false
#	Icon=/home/your-user-name/wxPerl/wxpl.ico
#	Exec=perl /usr/local/bin/wxperl_demo.pl
#


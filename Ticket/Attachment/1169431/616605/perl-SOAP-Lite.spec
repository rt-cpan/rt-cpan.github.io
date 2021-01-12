Name:       perl-SOAP-Lite
Version:    0.716
Release:    1%{?dist}
Summary:    Client and server side SOAP implementation
License:    GPL+ or Artistic
Group:      Development/Libraries
URL:        http://search.cpan.org/dist/SOAP-Lite/
Source0:    http://search.cpan.org/CPAN/authors/id/M/MK/MKUTTER/SOAP-Lite-%{version}.tar.gz
#Patch0:     perl-SOAP-Lite-0.715-IO-modules.patch
BuildArch:  noarch

# Core package
BuildRequires:  perl(Class::Inspector)
BuildRequires:  perl(constant)
BuildRequires:  perl(MIME::Base64)
BuildRequires:  perl(Scalar::Util)
BuildRequires:  perl(Task::Weaken)
BuildRequires:  perl(Test::More)
BuildRequires:  perl(URI)
BuildRequires:  perl(XML::Parser) >= 2.23
# Optional
BuildRequires:  perl(LWP::UserAgent)
BuildRequires:  perl(Crypt::SSLeay)
BuildRequires:  perl(MIME::Lite)
BuildRequires:  perl(HTTP::Daemon)
BuildRequires:  perl(Apache)
BuildRequires:  perl(FCGI)
BuildRequires:  perl(MIME::Parser)
BuildRequires:  perl(Net::POP3)
BuildRequires:  perl(IO::File)
BuildRequires:  perl(IO::Socket::SSL)
BuildRequires:  perl(Compress::Zlib)

Requires:       perl(:MODULE_COMPAT_%(eval "`perl -V:version`"; echo $version))
Requires:       perl(Compress::Zlib)
Requires:       perl(Encode)
Requires:       perl(Errno)
Requires:       perl(HTTP::Daemon)
Requires:       perl(HTTP::Headers)
Requires:       perl(HTTP::Request)
Requires:       perl(LWP::UserAgent)
Requires:       perl(MIME::Base64)
Requires:       perl(MIME::Entity)
Requires:       perl(MIME::Parser)
Requires:       perl(POSIX)
Requires:       perl(URI)
Requires:       perl(XML::Parser)
Requires:       perl(XML::Parser::Lite)

# RPM 4.8 filters
%{?filter_setup:
%filter_from_requires /perl(My::/d
%filter_from_provides /perl(My::/d
%filter_from_provides /perl(LWP::Protocol)/d
%?perl_default_filter
}
# RPM 4.9 filters
%global __provides_exclude %{?__provides_exclude:%__provides_exclude|}perl\\(My::.*\\)
%global __provides_exclude %__provides_exclude|perl\\(LWP::Protocol\\)
%global __requires_exclude %{?_requires_exclude:%__requires_exclude|}perl\\(My::\\)

%description
SOAP::Lite is a collection of Perl modules which provides a simple and
lightweight interface to the Simple Object Access Protocol (SOAP) both on
client and server side.

%prep
%setup -q -n SOAP-Lite-%{version}
#%patch0 -p1 -b .IO
find examples -type f -exec chmod ugo-x {} \;

%build
perl Makefile.PL --noprompt INSTALLDIRS=vendor
make %{?_smp_mflags}

%install
make pure_install PERL_INSTALL_ROOT=%{buildroot}
find %{buildroot} -type f -name .packlist -exec rm -f {} ';'
find %{buildroot} -type d -depth -exec rmdir {} 2>/dev/null ';'
chmod -R u+w %{buildroot}/*

%check
make test

%files
%doc Changes README ReleaseNotes.txt examples
%{_bindir}/*pl
%{perl_vendorlib}/SOAP
%{perl_vendorlib}/Apache
%{perl_vendorlib}/IO
%{perl_vendorlib}/UDDI
%{perl_vendorlib}/XML
%{perl_vendorlib}/XMLRPC
%{_mandir}/man3/*
%{_mandir}/man1/*

%changelog
* Thu Aug 02 2012 Petr .abata <contyk@redhat.com> - 0.715-2
- Bundle 0.714 IO modules to fix dependency breakage
  (confirmed as unintentional by upstream)

* Thu Jul 19 2012 Petr .abata <contyk@redhat.com> - 0.715-1
- 0.715 bump
- Drop command macros

* Fri Jun 29 2012 Petr Pisar <ppisar@redhat.com> - 0.714-3
- Perl 5.16 rebuild

* Fri Jan 13 2012 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.714-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_17_Mass_Rebuild

* Mon Aug 22 2011 Petr Sabata <contyk@redhat.com> - 0.714-1
- 0.714 bump

* Wed Aug 17 2011 Petr Sabata <contyk@redhat.com> - 0.713-1
- 0.713 bump
- Drop all patches (included upstream)
- Remove now obsolete defattr

* Fri Jul 22 2011 Petr Sabata <contyk@redhat.com> - 0.712-8
- RPM 4.9 dependency filtering added
- Add patch for XML::Parser::Lite from rt#68088; perl5.14 fix

* Thu Jul 21 2011 Petr Sabata <contyk@redhat.com> - 0.712-7
- Perl mass rebuild

* Wed Jul 20 2011 Petr Sabata <contyk@redhat.com> - 0.712-6
- Perl mass rebuild

* Tue May 31 2011 Petr Sabata <contyk@redhat.com> - 0.712-5
- Filter LWP::Protocol from Provides (#709269)

* Tue May 17 2011 Petr Sabata <psabata@redhat.com> - 0.712-4
- Do not require Apache2::*; this introduces mod_perl/httpd dependencies
  This is optional and needed only when running under mod_perl which provides
  those modules. (#705084)
- Use read() instead of sysread() under mod_perl (#663931), mod_perl patch

* Fri Apr  8 2011 Petr Sabata <psabata@redhat.com> - 0.712-3
- BuildArch: noarch

* Wed Apr  6 2011 Petr Sabata <psabata@redhat.com> - 0.712-2
- Fix Requires typos

* Tue Apr  5 2011 Petr Sabata <psabata@redhat.com> - 0.712-1
- 0.712 bump
- Removing clean section
- Removing 'defined hash' patch (included upstream)
- Fixing BRs/Rs; hopefully I didn't omit anything

* Wed Feb 09 2011 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.711-3
- Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild

* Tue Nov 23 2010 Marcela Ma.lávámmaslano@redhat.com> - 0.711-2
- add R: LWP::UserAgent and clean spec from buildroot

* Thu Jun  3 2010 Marcela Ma.lávámmaslano@redhat.com> - 0.711-1
- update and apply fix from https://rt.cpan.org/Public/Bug/Display.html?id=52015

* Thu May 13 2010 Ralf Corséus <corsepiu@fedoraproject.org> - 0.710.10-4
- BR: perl(version) (Fix perl-5.12.0 build breakdown).

* Thu May 06 2010 Marcela Maslanova <mmaslano@redhat.com> - 0.710.10-3
- Mass rebuild with perl-5.12.0

* Mon Jan 18 2010 Stepan Kasal <skasal@redhat.com> - 0.710.10-2
- limit BR perl(FCGI) to Fedora

* Wed Oct  7 2009 Stepan Kasal <skasal@redhat.com> - 0.710.10-1
- new upstream release
- drop upstreamed patch
- add missing build requires
- use %%filter-* macros

* Sun Jul 26 2009 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.710.08-4
- Rebuilt for https://fedoraproject.org/wiki/Fedora_12_Mass_Rebuild

* Fri May  8 2009 Michael Schwendt <mschwendt@fedoraproject.org> - 0.710.08-3
- Filter out perl(LWP::Protocol) Provides, which comes from a file
  not stored in Perl's search path for modules (#472359).

* Thu Feb 26 2009 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.710.08-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_11_Mass_Rebuild

* Thu Dec 11 2008 Lubomir Rintel <lkundrak@v3.sk> - 0.710.08-1
- New upstream release
- Enable tests
- Include examples in documentation
- Don't grab in dependencies of exotic transports (for the sake
  of consistency with existing practice of Jabber transport)

* Tue Sep 09 2008 Lubomir Rintel <lkundrak@v3.sk> - 0.710.07-2
- Re-add the nil patch

* Tue Jun 24 2008 Mike McGrath <mmcgrath@redhat.com> - 0.710.07-1
- Upstream released new version

* Mon Mar  3 2008 Tom "spot" Callaway <tcallawa@redhat.com> - 0.68-6
- rebuild for new perl

* Thu Oct 18 2007 Mike McGrath <mmcgrath@redhat.com> - 0.68-5
- Fixed build requires

* Tue Oct 16 2007 Tom "spot" Callaway <tcallawa@redhat.com> - 0.68-4.1
- correct license tag
- add BR: perl(ExtUtils::MakeMaker)

* Mon Mar 03 2007 Mike McGrath <mmcgrath@redhat.com> - 0.68-4
- bogus reqs diff

* Sat Jan 2 2007 Mike McGrath <imlinux@gmail.com> - 0.68-3
- Changed the way this package removes bogus reqs for EL4

* Sun Sep 10 2006 Mike McGrath <imlinux@gmail.com> - 0.68-1
- Rebuild

* Tue Jul 18 2006 Mike McGrath <imlinux@gmail.com> - 0.68-1
- New upstream source
- Patch provided for <value><nil/></value> issues

* Mon Mar 20 2006 Mike McGrath <imlinux@gmail.com> - 0.67-2
- Removed perl requirements that do not yet exist in Extras

* Sat Mar 18 2006 Mike McGrath <imlinux@gmail.com> - 0.67-1
- New Owner and new spec file

* Wed Oct 26 2005 Ville Skyttäville.skytta at iki.fi> - 0.60a-3
- Fix build, doc permissions (#169821).

* Wed Apr 06 2005 Hunter Matthews <thm@duke.edu> 0.60a-2
- Review suggestions from Joséedro Oliveira

* Fri Mar 18 2005 Hunter Matthews <thm@duke.edu> 0.60a-1
- Initial packaging.

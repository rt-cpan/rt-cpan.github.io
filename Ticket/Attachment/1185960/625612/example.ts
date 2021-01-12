Script started on Tue Feb 26 21:04:48 2013
bash: parse_git_branch: command not found
[?1034h[01;31mspaceinvaders [01;34m~ $ [00msource ~/.profile
[01;31mspaceinvaders [01;34m~ $ [00mcatalyst.pl TestApp
Name "Catalyst::Exception::Base::OVERLOAD" used only once: possible typo at /Users/t0m/perl5/perlbrew/perls/perl-5.17.6/lib/site_perl/5.17.6/darwin-2level/Class/MOP/Package.pm line 243.
Name "Catalyst::Exception::Basic::OVERLOAD" used only once: possible typo at /Users/t0m/perl5/perlbrew/perls/perl-5.17.6/lib/site_perl/5.17.6/darwin-2level/Class/MOP/Package.pm line 243.
created "TestApp"
created "TestApp/script"
created "TestApp/lib"
created "TestApp/root"
created "TestApp/root/static"
created "TestApp/root/static/images"
created "TestApp/t"
created "TestApp/lib/TestApp"
created "TestApp/lib/TestApp/Model"
created "TestApp/lib/TestApp/View"
created "TestApp/lib/TestApp/Controller"
created "TestApp/testapp.conf"
created "TestApp/testapp.psgi"
created "TestApp/lib/TestApp.pm"
created "TestApp/lib/TestApp/Controller/Root.pm"
created "TestApp/README"
created "TestApp/Changes"
created "TestApp/t/01app.t"
created "TestApp/t/02pod.t"
created "TestApp/t/03podcoverage.t"
created "TestApp/root/static/images/catalyst_logo.png"
created "TestApp/root/static/images/btn_120x50_built.png"
created "TestApp/root/static/images/btn_120x50_built_shadow.png"
created "TestApp/root/static/images/btn_120x50_powered.png"
created "TestApp/root/static/images/btn_120x50_powered_shadow.png"
created "TestApp/root/static/images/btn_88x31_built.png"
created "TestApp/root/static/images/btn_88x31_built_shadow.png"
created "TestApp/root/static/images/btn_88x31_powered.png"
created "TestApp/root/static/images/btn_88x31_powered_shadow.png"
created "TestApp/root/favicon.ico"
created "TestApp/Makefile.PL"
created "TestApp/script/testapp_cgi.pl"
created "TestApp/script/testapp_fastcgi.pl"
created "TestApp/script/testapp_server.pl"
created "TestApp/script/testapp_test.pl"
created "TestApp/script/testapp_create.pl"
Change to application directory and Run "perl Makefile.PL" to make sure your install is complete
[01;31mspaceinvaders [01;34m~ $ [00mcd TestApp/
[01;31mspaceinvaders [01;34mTestApp $ [00mPerl Ma[K[K[K[K[K[K[Kperl Makefile.PL 
include /Users/t0m/TestApp/inc/Module/Install.pm
include inc/Module/Install/Metadata.pm
include inc/Module/Install/Base.pm
include inc/Module/Install/Makefile.pm
Cannot determine perl version info from lib/TestApp.pm
include inc/Module/Install/Catalyst.pm
include inc/Module/Install/Include.pm
include inc/File/Copy/Recursive.pm
*** Module::Install::Catalyst
Please run "make catalyst_par" to create the PAR package!
*** Module::Install::Catalyst finished.
include inc/Module/Install/Scripts.pm
include inc/Module/Install/AutoInstall.pm
include inc/Module/AutoInstall.pm
*** Module::AutoInstall version 1.06
*** Checking for Perl dependencies...
[Core Features]
- Test::More                       ...loaded. (0.98 >= 0.88)
- Catalyst::Runtime                ...loaded. (5.90019 >= 5.90019)
- Catalyst::Plugin::ConfigLoader   ...loaded. (0.30)
- Catalyst::Plugin::Static::Simple ...loaded. (0.30)
- Catalyst::Action::RenderView     ...loaded. (0.16)
- Moose                            ...loaded. (2.0604)
- namespace::autoclean             ...loaded. (0.13)
- Config::General                  ...loaded. (2.51)
*** Module::AutoInstall configuration finished.
include inc/Module/Install/WriteAll.pm
include inc/Module/Install/Win32.pm
include inc/Module/Install/Can.pm
include inc/Module/Install/Fetch.pm
Writing Makefile for TestApp
Writing MYMETA.yml and MYMETA.json
Writing META.yml
[01;31mspaceinvaders [01;34mTestApp $ [00mperl -Ilib ./script/my[K[Ktestapp_server.pl -d
[debug] Debug messages enabled
[debug] Statistics enabled
[debug] Loaded plugins:
.----------------------------------------------------------------------------.
| Catalyst::Plugin::ConfigLoader  0.30                                       |
'----------------------------------------------------------------------------'

[debug] Loaded dispatcher "Catalyst::Dispatcher"
[debug] Loaded engine "Catalyst::Engine"
[debug] Found home "/Users/t0m/TestApp"
[debug] Loaded Config "/Users/t0m/TestApp/testapp.conf"
[debug] Loaded components:
.-----------------------------------------------------------------+----------.
| Class                                                           | Type     |
+-----------------------------------------------------------------+----------+
| TestApp::Controller::Root                                       | instance |
'-----------------------------------------------------------------+----------'

[debug] Loaded Private actions:
.----------------------+--------------------------------------+--------------.
| Private              | Class                                | Method       |
+----------------------+--------------------------------------+--------------+
| /index               | TestApp::Controller::Root            | index        |
| /end                 | TestApp::Controller::Root            | end          |
| /default             | TestApp::Controller::Root            | default      |
'----------------------+--------------------------------------+--------------'

[debug] Loaded Path actions:
.-------------------------------------+--------------------------------------.
| Path                                | Private                              |
+-------------------------------------+--------------------------------------+
| /                                   | /index                               |
| /...                                | /default                             |
'-------------------------------------+--------------------------------------'

[info] TestApp powered by Catalyst 5.90019
HTTP::Server::PSGI: Accepting connections at http://0:3000/
[info] *** Request 1 (0.111/s) [14177] [Tue Feb 26 21:05:33 2013] ***
[debug] Path is "/"
[debug] "GET" request for "/" from "127.0.0.1"
[debug] Response Code: 200; Content-Type: text/html; charset=utf-8; Content-Length: 5480
[info] Request took 0.003056s (327.225/s)
.------------------------------------------------------------+-----------.
| Action                                                     | Time      |
+------------------------------------------------------------+-----------+
| /index                                                     | 0.000213s |
| /end                                                       | 0.000176s |
'------------------------------------------------------------+-----------'

^C
[01;31mspaceinvaders [01;34mTestApp $ [00m## ^^ That was a full load, including all graphics
[01;31mspaceinvaders [01;34mTestApp $ [00mexit

Script done on Tue Feb 26 21:05:53 2013

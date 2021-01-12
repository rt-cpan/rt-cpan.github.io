package TestModPerlHandler_pp;

use strict;
use warnings;

use Locale::Messages qw (:locale_h :libintl_h nl_putenv bind_textdomain_filter select_package gettext);
use POSIX qw (setlocale);
use Encode;

use Locale::gettext_pp;

sub handler {
    my $r = shift;

    $r->content_type ("text/html; charset=utf-8");

    # Guido: Workaround for a bug in libintl-perl 1.16: Call select_package()
    # as a class method.  This will work with future versions, too.
    # See http://rt.cpan.org/Ticket/Display.html?id=37762 for details.
    my $res = Locale::Messages->select_package("gettext_pp");
    print "<p>Will call module: $res</p>";
    my $language = 'de_DE';
    my $locale_prefix = '/usr/local/share/locale';
    my $loc = "${language}.UTF-8";
    
    # Guido: You must _always_ check the return value of setlocale(),
    # when you try to change the locale.  In nine out of ten cases
    # the call fails.
    my $lc_messages = POSIX::setlocale(&POSIX::LC_MESSAGES, $loc);
    my $lc_time = POSIX::setlocale(&POSIX::LC_TIME,     $loc);
    my $today = POSIX::strftime ("%A", localtime);
    my $lc_all = POSIX::setlocale(&POSIX::LC_ALL,      $loc);

    $r->print (<<EOF);
<pre>
Did setlocale succeed?
LC_MESSAGES: $lc_messages
LC_TIME: $lc_time
LC_ALL: $lc_all
Today: $today
</pre>
EOF

    if (0) {
    # Guido: This entire block of code is useless, because the environment is
    # irrelevant here.  The environment is _only_ used, when you call
    # setlocale() with an empty (empty! not undefined) second argument.
    # In that case, the locale is set according to the corresponding
    # environment variable, for example:
    # 
    #     nl_putenv("LC_MESSAGES=bg_BG.utf8");
    #     setlocale (LC_MESSAGES, '');
    #
    # In other words: Modifying the environment is too late here, and
    # besides it is not needed.  You always pass a second argument to
    # setlocale, so there is no need for changing the environment.
    #
    # There is one exception to the above: The environment variable
    # LANGUAGE overrides all locales settings set with setlocale(),
    # at least in gettext_pp.  Furthermore, its format differs from
    # the other envariables, in that it is a colon separated list of
    # languages (languages! not locale identifiers).  See the comment
    # on it in ABOUT-NLS that comes with all internationalized software
    # packages.
    Locale::Messages::nl_putenv("LC_MESSAGES=$loc");
    Locale::Messages::nl_putenv("LC_TIME=$loc");
    Locale::Messages::nl_putenv("LC_ALL=$loc");
    Locale::Messages::nl_putenv("LANG=$loc");
    Locale::Messages::nl_putenv("LANGUAGE=$loc");

    my $eall = $ENV{'LC_ALL'};
    my $emessages = $ENV{'LC_MESSAGES'};
    my $elang = $ENV{'LANG'};
    my $elanguage = $ENV{'LANGUAGE'};

    print "<p>Before script works</p>";
    print "<p>LC_ALL: $eall</p>";
    print "<p>LC_MESSAGES: $emessages</p>";
    print "<p>LANG: $elang</p>";
    print "<p>LANGUAGE: $elanguage</p>";
    }

    Locale::Messages::textdomain("openxpki");
    Locale::Messages::bindtextdomain("openxpki", $locale_prefix);
    Locale::Messages::bind_textdomain_codeset("openxpki", "UTF-8");
## This line calls gettext_pp via Messages::gettext and works ok with Apache-2.x on FreeBSD
    my $data = Locale::Messages::gettext("I18N_OPENXPKI_CLIENT_HTML_MASON_API_CERT_INFO_TITLE");
    Encode::_utf8_on($data);
    $r->print ("Perl gettext from Messages: $data<br/>");

    Locale::gettext_pp::textdomain("openxpki");
    Locale::gettext_pp::bindtextdomain("openxpki", $locale_prefix);
    Locale::gettext_pp::bind_textdomain_codeset("openxpki", "UTF-8");
## This line calls explicitly gettext_pp and works ok on FreeBSD Apache-2.x and mod_perl2
    my $data2 = Locale::gettext_pp::gettext("I18N_OPENXPKI_CLIENT_HTML_MASON_API_CERT_INFO_TITLE");
    my $data3 = Locale::gettext_xs::gettext("I18N_OPENXPKI_CLIENT_HTML_MASON_API_CERT_INFO_TITLE");
## The next line calls gettext from CL
    my $data_cmd = `export LANG=de_DE.UTF-8 && export LANGUAGE=de_DE.UTF-8 && /usr/local/bin/gettext -d openxpki I18N_OPENXPKI_CLIENT_HTML_MASON_API_CERT_INFO_TITLE`;

    # Guido: If you want the utf-8 flag (brrrr) set on output from libintl-perl
    # you should use an output filter:
    
    use Locale::Messages qw (turn_utf_8_on bind_textdomain_filter);
    bind_textdomain_filter openxpki => \&turn_utf_8_on;
    if (0) {
    Encode::_utf8_on($data2);
    Encode::_utf8_on($data3);
    }
    $r->print ("Pure Perl gettext: $data2<br/>Command_line: $data_cmd <br/>");
    $r->print ("XS gettext: $data3<br/>Command_line: $data_cmd <br/>");

    # Guido: See above: The environment is irrelevant.
    #print "<p>After script worked</p>";
    #print "<p>LC_ALL: $eall</p>";
    #print "<p>LC_MESSAGES: $emessages</p>";
    #print "<p>LANG: $elang</p>";
    #print "<p>LANGUAGE: $elanguage</p>";

    return 0;
}

1;

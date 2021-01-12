package OpenXPKI::TestModPerlHandler;

use strict;
use warnings;

use Locale::Messages qw (:locale_h :libintl_h nl_putenv bind_textdomain_filter select_package gettext);
use Locale::gettext_pp;
use POSIX qw (setlocale);
use Encode;
use Data::Dumper;

sub handler {
    my $r = shift;

    select_package("gettext_pp");
    my $language = 'de_DE';
    my $locale_prefix = '/Users/klink/usr/local/share/locale';
    my $loc = "${language}.UTF-8";
    setlocale('LC_MESSAGES', $loc);
    setlocale('LC_TIME',     $loc);
    setlocale('LC_ALL',      $loc);
    Locale::Messages::nl_putenv("LC_MESSAGES=$loc");
    Locale::Messages::nl_putenv("LC_TIME=$loc");
    Locale::Messages::nl_putenv("LC_ALL=$loc");
    Locale::Messages::nl_putenv("LANG=$loc");
    Locale::Messages::nl_putenv("LANGUAGE=$loc");

    my $eall = $ENV{'LC_ALL'};
    my $emessages = $ENV{'LC_MESSAGES'};
    my $elang = $ENV{'LANG'};
    my $elanguage = $ENV{'LANGUAGE'};

    Locale::Messages::textdomain("openxpki");
    Locale::Messages::bindtextdomain("openxpki", $locale_prefix);
    Locale::Messages::bind_textdomain_codeset("openxpki", "UTF-8");
## This line fails with Apache-2.x on FreeBSD
    my $data = gettext("I18N_OPENXPKI_CLIENT_HTML_MASON_API_CERT_INFO_TITLE");
    my $data_pp = Locale::gettext_pp::gettext('I18N_OPENXPKI_CLIENT_HTML_MASON_API_CERT_INFO_TITLE');
## The next line is an example of suggested workaround
    my $data_cmd = `export LANG=de_DE.UTF-8 && export LANGUAGE=de_DE.UTF-8 && /opt/local/bin/gettext -d openxpki I18N_OPENXPKI_CLIENT_HTML_MASON_API_CERT_INFO_TITLE`;
    Encode::_utf8_on($data);
    print "Perl gettext: $data\nCommandline: $data\nPerl gettext_pp: $data_pp\n";

    $Data::Dumper::Sortkeys = 1;
    print Dumper \%ENV;
    return 0;
}

1;

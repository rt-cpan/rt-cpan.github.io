#!/usr/bin/perl
#modil PBo #!/usr/bin/perl -Tw
#
# $Id: login.pl,v 1.3 2003/10/10 22:33:31 jacob Exp $
#
# Display a login form with hidden fields corresponding to the page they
# wanted to see.

use strict;
use 5.004;
use Text::TagTemplate;
#use Apache;

use Apache2::RequestUtil();
#use Apache2::RequestRec();

my $t = new Text::TagTemplate;
# my $r = Apache->request();
my $r = Apache2::RequestUtil->request();

my $destination;
my $authcookiereason;
if ($r->prev()) { # we are called as a subrequest.
	$destination = $r->prev()->args()
	             ? $r->prev()->uri().'?'.$r->prev->args()
	             : $r->prev()->uri();
	$authcookiereason = $r->prev()->subprocess_env('AuthCookieReason');
} else {
       my %args = $r->args;
	$destination = $args{'destination'};
	$authcookiereason = $args{'AuthCookieReason'};
       # modif PBo $t->add_tag( CREDENTIAL_0 => $r->prev->args('credential_0'));
}
$t->add_tag(DESTINATION => $destination);

unless ($authcookiereason eq 'bad_cookie') {
	#modif PBo $t->template_file("../html/login.html");
	$t->template_file("/srv/www/cgi-bin/login.html");
} else {
	#modif PBo $t->template_file("../html/login-failed.html");
	$t->template_file("/srv/www/cgi-bin/login-failed.html");
}

#$r->send_http_header; #modif ne fonctionne pas sans "use Apache2::compat ();"
$r->content_type('text/plain'); 
print $t->parse_file unless $r->header_only;

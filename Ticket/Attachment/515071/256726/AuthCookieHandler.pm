package Sample::AuthCookieHandler;
use strict;
use base qw(Apache2::AuthCookie);
use Apache2::RequestRec;
use Apache2::RequestUtil;

use Digest::SHA1;

my $secret = "The Quick Brown Fox Jumps Over";


sub authen_cred {
	my($self,$r,$username,$password) = @_;
	my $session_key = $username.'::'.Digest::SHA1::sha1_hex($username,$secret);
	$r->log_error("cred: $username,$password -> $session_key");
# lots of stuff here
	return $session_key;
}
sub authen_ses_key {
	my ($self,$r,$session_key)=@_; 
	my ($username,$mac) = split(/::/,$session_key);
  $r->log_error("ses: $username -> $session_key");
# check mac
	return $username;
}

1;

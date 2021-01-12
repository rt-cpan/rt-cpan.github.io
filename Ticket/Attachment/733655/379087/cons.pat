--- Net/OpenID/Consumer-0-.pm	2010-02-12 20:49:39.000000000 -0800
+++ Net/OpenID/Consumer.pm	2010-02-14 05:10:47.323736639 -0800
@@ -22,6 +22,7 @@
     'last_errtext',    # last error code we got
     'debug',           # debug flag or codeblock
     'minimum_version', # The minimum protocol version to support
+    'assoc_options',   # options for Net::OpenID::Association->new_server_assoc
 );
 
 use Net::OpenID::ClaimedIdentity;
@@ -32,7 +33,7 @@
 use Net::OpenID::URIFetch;
 
 use MIME::Base64 ();
-use Digest::SHA1 ();
+use Digest::SHA ();
 use Crypt::DH 0.05;
 use Time::Local;
 use HTTP::Request;
@@ -50,6 +51,7 @@
     $self->consumer_secret ( delete $opts{consumer_secret} );
     $self->required_root   ( delete $opts{required_root}   );
     $self->minimum_version ( delete $opts{minimum_version} );
+    $self->assoc_options   ( delete $opts{assoc_options}   );
 
     $self->{debug} = delete $opts{debug};
 
@@ -85,6 +87,32 @@
     return $self->{$param};
 }
 
+sub assoc_options {
+    my Net::OpenID::Consumer $self = shift;
+    my $v;
+    if (scalar(@_) == 1) {
+        $v = shift;
+        unless (defined $v && !$v) {
+            $v = [];
+        }
+        elsif (ref $v eq 'ARRAY') { }
+        elsif (ref $v) {
+            # assume HASH and hope for the best
+            $v = [%$v];
+        }
+        else {
+            Carp::croak("single argument must be HASH or ARRAY reference");
+        }
+        $self->{assoc_options} = $v;
+    }
+    elsif (@_) {
+        Carp::croak("odd number of parameters?") 
+            if scalar(@_)%2;
+        $self->{assoc_options} = [@_];
+    }
+    return $self->{assoc_options};
+}
+
 sub _debug {
     my Net::OpenID::Consumer $self = shift;
     return unless $self->{debug};
@@ -809,7 +864,7 @@
             $signed_fields{$param} = $val;
         }
 
-        my $good_sig = OpenID::util::b64(OpenID::util::hmac_sha1($token, $assoc->secret));
+        my $good_sig = $assoc->generate_signature($token);
         return $self->_fail("signature_mismatch") unless $sig64 eq $good_sig;
 
     } else {
@@ -896,6 +951,10 @@
 use constant VERSION_1_NAMESPACE => "http://openid.net/signon/1.1";
 use constant VERSION_2_NAMESPACE => "http://specs.openid.net/auth/2.0";
 
+# allow above reference to OpenID::util::hmac_sha1_hex
+# which should maybe go away?
+use Digest::SHA qw(hmac_sha1_hex); 
+
 # I guess this is a bit daft since constants are subs anyway,
 # but whatever.
 sub version_1_namespace {
@@ -917,23 +976,6 @@
     return "http://specs.openid.net/auth/2.0/identifier_select";
 }
 
-# From Digest::HMAC
-sub hmac_sha1_hex {
-    unpack("H*", &hmac_sha1);
-}
-sub hmac_sha1 {
-    hmac($_[0], $_[1], \&Digest::SHA1::sha1, 64);
-}
-sub hmac {
-    my($data, $key, $hash_func, $block_size) = @_;
-    $block_size ||= 64;
-    $key = &$hash_func($key) if length($key) > $block_size;
-
-    my $k_ipad = $key ^ (chr(0x36) x $block_size);
-    my $k_opad = $key ^ (chr(0x5c) x $block_size);
-
-    &$hash_func($k_opad, &$hash_func($k_ipad, $data));
-}
 
 sub parse_keyvalue {
     my $reply = shift;

diff -ruN CGI.pm-3.28/CGI/Util.pm CGI.pm-3.28_01/CGI/Util.pm
--- CGI.pm-3.28/CGI/Util.pm	2006-12-07 00:18:18.000000000 +0900
+++ CGI.pm-3.28_01/CGI/Util.pm	2007-04-07 15:37:09.000000000 +0900
@@ -7,7 +7,7 @@
 @EXPORT_OK = qw(rearrange make_attributes unescape escape 
 		expires ebcdic2ascii ascii2ebcdic);
 
-$VERSION = '1.5';
+$VERSION = '1.5_01';
 
 $EBCDIC = "\t" ne "\011";
 # (ord('^') == 95) for codepage 1047 as on os390, vmesa
@@ -141,8 +141,12 @@
 
 sub utf8_chr {
         my $c = shift(@_);
-	return chr($c) if $] >= 5.006;
-
+	if ($] >= 5.006){
+	    require utf8;
+	    my $u = chr($c);
+	    utf8::encode($u); # drop utf8 flag
+	    return $u;
+	}
         if ($c < 0x80) {
                 return sprintf("%c", $c);
         } elsif ($c < 0x800) {
@@ -189,6 +193,17 @@
     if ($EBCDIC) {
       $todecode =~ s/%([0-9a-fA-F]{2})/chr $A2E[hex($1)]/ge;
     } else {
+	# handle surrogate pairs first -- dankogai
+	$todecode =~ s{
+			%u([Dd][89a-bA-B][0-9a-fA-F]{2}) # hi
+		        %u([Dd][c-fC-F][0-9a-fA-F]{2})   # lo
+		      }{
+			  utf8_chr(
+				   0x10000 
+				   + (hex($1) - 0xD800) * 0x400 
+				   + (hex($2) - 0xDC00)
+				  )
+		      }gex;
       $todecode =~ s/%(?:([0-9a-fA-F]{2})|u([0-9a-fA-F]{4}))/
 	defined($1)? chr hex($1) : utf8_chr(hex($2))/ge;
     }
diff -ruN CGI.pm-3.28/t/percent-u.t CGI.pm-3.28_01/t/percent-u.t
--- CGI.pm-3.28/t/percent-u.t	1970-01-01 09:00:00.000000000 +0900
+++ CGI.pm-3.28_01/t/percent-u.t	2007-04-07 14:55:25.000000000 +0900
@@ -0,0 +1,27 @@
+#
+# This tests %uXXXX notation
+# -- dankogai
+BEGIN {
+    if ($] < 5.008) {
+       print "1..0 # \$] == $] < 5.008\n";
+       exit(0);
+    }
+}
+use strict;
+use warnings;
+use Encode;
+use Test::More tests => 6;
+use utf8;
+use CGI::Util;
+
+my %escaped = (
+	       encode_utf8(chr(0x61))    => '%u0061',
+	       encode_utf8(chr(0x5F3E))  => '%u5F3E',
+	       encode_utf8(chr(0x2A6B2)) => '%uD869%uDEB2',
+);
+
+for my $chr (keys %escaped){
+    is  !utf8::is_utf8($chr), 1;
+    is CGI::Util::unescape($escaped{$chr}), $chr, "$escaped{$chr} => $chr";
+}
+__END__

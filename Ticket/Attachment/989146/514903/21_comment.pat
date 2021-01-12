--- t/21_comment.old	2008-04-26 16:25:00.000000000 -0400
+++ t/21_comment.t	2011-10-18 13:13:42.000000000 -0400
@@ -1,7 +1,7 @@
 #!/usr/bin/perl -w
 
 use strict;
-use Test::More tests => 7;
+use Test::More tests => 8;
 
 use Module::ExtractUse;
 
@@ -73,3 +73,16 @@
 require Apache::DBI
 CODE
 }
+
+# Handle trailing comments which become comment lines after the split on
+# ';'.
+{
+my $p = Module::ExtractUse->new;
+is $p->extract_use(\(<<'CODE'))->string, '5.008 strict warnings';
+use 5.008; # Because we want to
+# Another comment
+
+use strict;
+use warnings;
+CODE
+}

--- lib/Module/ExtractUse.old	2008-04-26 16:25:00.000000000 -0400
+++ lib/Module/ExtractUse.pm	2011-10-18 12:59:39.000000000 -0400
@@ -114,6 +114,13 @@
     my @statements=split(/;/,$podless);
 
     foreach my $statement (@statements) {
+
+	# Handle trailing comments which become comment lines after the
+	# split on ';'. See same-commented test in t/21_comment.t for an
+	# example.
+	1 while $statement=~s/\A\s+#[^\n]*\n//s;
+
+	# Now make the remainder into a single line.
         $statement=~s/\n+/ /gs;
         my $result;
 

--- t/1.old	Mon Jul 15 09:53:24 2002
+++ t/1.t	Sun Dec 30 12:28:35 2007
@@ -124,7 +124,8 @@
 ok(@$tables, 2, @_);
 
 ## and three headers for each table
-for $t (0..$#{@$tables}) {
+my $last_tbl = @$tables - 1;
+for $t (0..$last_tbl) {
 	for (0..$#hdrs) {
 		ok($tables->[$t]->{headers}->[$_]->{data}, $hdrs[$_], $@);
 	}
@@ -132,7 +133,7 @@
 
 
 ## and three rows of three cells each, for each table.. (18 total).
-for $t (0..$#{@$tables}) {
+for $t (0..$last_tbl) {
 	for $r (0..$#rows) {
 		for (0..2) {
 			ok($tables->[$t]->{rows}->[$r]->{cells}->[$_]->{data}, $rows[$r]->[$_], $@);

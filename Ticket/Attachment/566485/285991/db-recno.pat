--- t/db-recno.old	2009-02-14 13:31:29.000000000 -0500
+++ t/db-recno.t	2009-02-14 13:45:03.000000000 -0500
@@ -1477,7 +1477,7 @@
 
     foreach ($ms_error, @ms_warnings) {
 	chomp;
-	s/ at \S+ line \d+\.?.*//s;
+	s/ at \S+(?:\s+\S+)*? line \d+\.?.*//s;
     }
 
     return "different errors: '$s_error' vs '$ms_error'"

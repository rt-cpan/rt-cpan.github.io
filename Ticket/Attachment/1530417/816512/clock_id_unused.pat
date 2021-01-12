diff --git a/HiRes.xs.save b/HiRes.xs
index 3bbf5eb..48cbf3e 100644
--- a/HiRes.xs.save
+++ b/HiRes.xs
@@ -1160,6 +1160,7 @@ NV
 clock_gettime(clock_id = 0)
 	int clock_id
     CODE:
+	PERL_UNUSED_VAR(clock_id);
         croak("Time::HiRes::clock_gettime(): unimplemented in this platform");
         RETVAL = 0.0;
     OUTPUT:
@@ -1192,6 +1193,7 @@ NV
 clock_getres(clock_id = 0)
 	int clock_id
     CODE:
+	PERL_UNUSED_VAR(clock_id);
         croak("Time::HiRes::clock_getres(): unimplemented in this platform");
         RETVAL = 0.0;
     OUTPUT:

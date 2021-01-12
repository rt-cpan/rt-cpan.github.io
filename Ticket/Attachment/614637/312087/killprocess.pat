diff -ruN Win32-Process-0.14.orig/Process.xs Win32-Process-0.14/Process.xs
--- Win32-Process-0.14.orig/Process.xs	2008-06-03 23:18:20.000000000 +0100
+++ Win32-Process-0.14/Process.xs	2009-05-27 17:56:35.117203200 +0100
@@ -444,7 +444,12 @@
     unsigned int exitcode
 CODE:
     {
-	HANDLE ph = OpenProcess(PROCESS_ALL_ACCESS, 0, pid);
+	HANDLE ph = OpenProcess(PROCESS_DUP_HANDLE         |
+				 PROCESS_QUERY_INFORMATION |
+				 PROCESS_SET_INFORMATION   |
+				 PROCESS_TERMINATE         |
+                                 SYNCHRONIZE,
+                                 0, pid);
 	if (ph) {
 	    RETVAL = TerminateProcess(ph, exitcode);
 	    if (RETVAL)

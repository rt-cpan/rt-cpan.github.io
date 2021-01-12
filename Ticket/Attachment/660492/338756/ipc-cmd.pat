diff -ruN IPC-Cmd-0.46.orig/t/01_IPC-Cmd.t IPC-Cmd-0.46/t/01_IPC-Cmd.t
--- IPC-Cmd-0.46.orig/t/01_IPC-Cmd.t	2009-01-08 12:34:02.000000000 +0000
+++ IPC-Cmd-0.46/t/01_IPC-Cmd.t	2009-09-07 15:55:20.047390000 +0100
@@ -45,7 +45,7 @@
 
 ### can_run tests
 {
-    ok( can_run('perl'),                q[Found 'perl' in your path] );
+    ok( can_run("$^X"),                 q[Found 'perl' in your path] );
     ok( !can_run('10283lkjfdalskfjaf'), q[Not found non-existant binary] );
 }
 

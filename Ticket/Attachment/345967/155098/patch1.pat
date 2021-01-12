Index: lib/Text/Restructured/PrestConfig.pm.PL
===================================================================
--- lib/Text/Restructured/PrestConfig.pm.PL	(revision 5363)
+++ lib/Text/Restructured/PrestConfig.pm.PL	(working copy)
@@ -19,10 +19,10 @@
 __END__
 package Text::Restructured::PrestConfig;
 
-$DEFAULTCSS = "${CONFIG{defaultcss}}";
-$SAFE_PERL = "${^X}";
-$TAINT = "${CONFIG{taint}}";
-$VERSION = "${CONFIG{version}}";
-$DOCURL = "${CONFIG{docurl}}";
+$DEFAULTCSS = q[${CONFIG{defaultcss}}];
+$SAFE_PERL = q[${^X}];
+$TAINT = q[${CONFIG{taint}}];
+$VERSION = q[${CONFIG{version}}];
+$DOCURL = q[${CONFIG{docurl}}];
 
 1;

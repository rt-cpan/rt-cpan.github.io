commit 9bdbb2bdbd72d8d02cb8bcb0d27e7eeeacd415af
Author: Jarkko Hietaniemi <jhi@iki.fi>
Date:   Sun Jun 22 18:05:41 2014 -0400

    version distribution dVAR updates.

diff --git a/t/porting/customized.dat b/t/porting/customized.dat
index 90e31fa..e71e6a6 100644
--- a/t/porting/customized.dat
+++ b/t/porting/customized.dat
@@ -17,4 +17,4 @@ podlators cpan/podlators/scripts/pod2man.PL f81acf53f3ff46cdcc5ebdd661c5d13eb35d
 podlators cpan/podlators/scripts/pod2text.PL b4693fcfe4a0a1b38a215cfb8985a65d5d025d69
 version cpan/version/lib/version.pm fa9931d4db05aff9a0a6ef558610b1a472d9306e
 version vutil.c 717e9ac72d3cec7a65639f07fc46c18b847a9fee
-version vxs.inc 9064aacbdfe42bb584a068f62b505dd11dbb4dc4
+version vxs.inc 1775019d08decbf8f9faedd0f986e376fd848eba
diff --git a/vutil.c b/vutil.c
index 91e9ea4..8b899c0 100644
--- a/vutil.c
+++ b/vutil.c
@@ -463,7 +463,6 @@ Perl_new_version2(pTHX_ SV *ver)
 Perl_new_version(pTHX_ SV *ver)
 #endif
 {
-    dVAR;
     SV * const rv = newSV(0);
     PERL_ARGS_ASSERT_NEW_VERSION;
     if ( ISA_VERSION_OBJ(ver) ) /* can just copy directly */
diff --git a/vxs.inc b/vxs.inc
index 4d74adb..28c8ef6 100644
--- a/vxs.inc
+++ b/vxs.inc
@@ -86,7 +86,6 @@ typedef char HVNAME;
 
 VXS(universal_version)
 {
-    dVAR;
     dXSARGS;
     HV *pkg;
     GV **gvp;
@@ -185,7 +184,6 @@ VXS(universal_version)
 
 VXS(version_new)
 {
-    dVAR;
     dXSARGS;
     SV *vs;
     SV *rv;
@@ -267,7 +265,6 @@ VXS(version_new)
 
 VXS(version_stringify)
 {
-     dVAR;
      dXSARGS;
      if (items < 1)
 	 croak_xs_usage(cv, "lobj, ...");
@@ -282,7 +279,6 @@ VXS(version_stringify)
 
 VXS(version_numify)
 {
-     dVAR;
      dXSARGS;
      if (items < 1)
 	 croak_xs_usage(cv, "lobj, ...");
@@ -296,7 +292,6 @@ VXS(version_numify)
 
 VXS(version_normal)
 {
-     dVAR;
      dXSARGS;
      if (items != 1)
 	 croak_xs_usage(cv, "ver");
@@ -311,7 +306,6 @@ VXS(version_normal)
 
 VXS(version_vcmp)
 {
-     dVAR;
      dXSARGS;
      if (items < 1)
 	 croak_xs_usage(cv, "lobj, ...");
@@ -347,7 +341,6 @@ VXS(version_vcmp)
 
 VXS(version_boolean)
 {
-    dVAR;
     dXSARGS;
     SV *lobj;
     if (items < 1)
@@ -368,7 +361,6 @@ VXS(version_boolean)
 
 VXS(version_noop)
 {
-    dVAR;
     dXSARGS;
     if (items < 1)
 	croak_xs_usage(cv, "lobj, ...");
@@ -383,7 +375,6 @@ static
 void
 S_version_check_key(pTHX_ CV * cv, const char * key, int keylen)
 {
-    dVAR;
     dXSARGS;
     if (items != 1)
 	croak_xs_usage(cv, "lobj");
@@ -408,7 +399,6 @@ VXS(version_is_alpha)
 
 VXS(version_qv)
 {
-    dVAR;
     dXSARGS;
     PERL_UNUSED_ARG(cv);
     SP -= items;

--- /Library/Perl/5.10.0/AppConfig/Sys.pm	2007-05-30 05:24:26.000000000 -0600
+++ /opt/local/lib/perl5/vendor_perl/5.8.9/AppConfig/Sys.pm	2011-04-19 10:45:33.000000000 -0600
@@ -17,7 +17,7 @@
 package AppConfig::Sys;
 use strict;
 use warnings;
-use POSIX qw( getpwnam getpwuid );
+use POSIX;
 
 our $VERSION = '1.65';
 our ($AUTOLOAD, $OS, %CAN, %METHOD);
@@ -38,10 +38,10 @@
     else
     {
         $METHOD{ getpwuid } = sub { 
-            getpwuid( defined $_[0] ? shift : $< ); 
+            POSIX::getpwuid( defined $_[0] ? shift : $< ); 
         };
         $METHOD{ getpwnam } = sub { 
-            getpwnam( defined $_[0] ? shift : '' );
+            POSIX::getpwnam( defined $_[0] ? shift : '' );
         };
     }
     

--- cpan/Socket/t/getaddrinfo.t.dist	Wed Jul  2 04:15:25 2014
+++ cpan/Socket/t/getaddrinfo.t	Wed Jul  2 04:48:24 2014
@@ -101,10 +101,26 @@
 }
 
 # Numeric addresses with AI_NUMERICHOST should pass (RT95758)
-{
-    ( $err, @res ) = getaddrinfo( "127.0.0.1", 80, { flags => AI_NUMERICHOST } );
-    ok( $err == 0, "\$err == 0 for 127.0.0.1/80/flags=AI_NUMERICHOST" ) or
-	diag( "\$err is $err" );
+AI_NUMERICHOST: {
+  # Here we need a port that is open to the world.
+  # Not all places have all the ports.  For example Solaris
+  # by default doesn't have http/80 in /etc/services, and
+  # that would fail.  Let's try a couple of commonly open
+  # ports, and hope one of them will succeed.  Conversely
+  # this means that sometimes this will fail.
+  #
+  # An alternative method would be to manually parse /etc/services
+  # and look for enabled services but that's kind of yuck, too.
+  #
+  my @port = (80, 7, 22, 25, 88, 123, 110, 389, 443, 445, 873, 2049, 3306);
+  for my $port (@port) {
+        ( $err, @res ) = getaddrinfo( "127.0.0.1", $port, { flags => AI_NUMERICHOST } );
+      if ($err == 0) { 	
+          ok( $err == 0, "\$err == 0 for 127.0.0.1/$port/flags=AI_NUMERICHOST" );
+	  last AI_NUMERICHOST;
+      }
+  }
+  fail( "$err for 127.0.0.1/$port[-1]/flags=AI_NUMERICHOST (failed for ports @port)" );
 }
 
 # Now check that names with AI_NUMERICHOST fail

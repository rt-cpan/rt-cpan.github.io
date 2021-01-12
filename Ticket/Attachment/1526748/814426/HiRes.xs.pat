--- HiRes.xs.dist	2015-08-18 08:08:31.000000000 -0400
+++ HiRes.xs	2015-08-18 08:08:59.000000000 -0400
@@ -1247,7 +1247,7 @@
 	clock_t clocks;
     CODE:
 	clocks = clock();
-	RETVAL = clocks == -1 ? -1 : (NV)clocks / (NV)CLOCKS_PER_SEC;
+	RETVAL = clocks == (clock_t) -1 ? (clock_t) -1 : (NV)clocks / (NV)CLOCKS_PER_SEC;
 
     OUTPUT:
 	RETVAL

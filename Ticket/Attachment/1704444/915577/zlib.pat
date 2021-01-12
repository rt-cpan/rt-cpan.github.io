--- Compress-Raw-Zlib-2.071/zlib-src/inflate.c.dist	2017-02-11 09:02:23.000000000 -0500
+++ Compress-Raw-Zlib-2.071/zlib-src/inflate.c	2017-02-11 09:02:55.000000000 -0500
@@ -1490,10 +1490,11 @@
 
     if (strm == Z_NULL || strm->state == Z_NULL) return Z_STREAM_ERROR;
     state = (struct inflate_state FAR *)strm->state;
-    state->sane = !subvert;
 #ifdef INFLATE_ALLOW_INVALID_DISTANCE_TOOFAR_ARRR
+    state->sane = !subvert;
     return Z_OK;
 #else
+    (void)subvert;
     state->sane = 1;
     return Z_DATA_ERROR;
 #endif

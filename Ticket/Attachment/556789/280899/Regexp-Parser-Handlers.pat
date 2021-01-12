--- lib/Regexp/Parser/Handlers.old	2004-07-06 09:38:26.000000000 -0400
+++ lib/Regexp/Parser/Handlers.pm	2009-01-20 12:34:16.000000000 -0500
@@ -1,5 +1,10 @@
 package Regexp::Parser;
 
+my $nest_eval;
+$nest_eval = qr[ (?> [^\\{}]+ | \\. | { (??{ $nest_eval }) } )* ]x;
+my $nest_logical;
+$nest_logical = qr[ (?> [^\\{}]+ | \\. | { (??{ $nest_logical }) } )* ]x;
+
 sub init {
   my ($self) = @_;
 
@@ -696,9 +701,7 @@
   # eval
   $self->add_handler('(?{' => sub {
     my ($S) = @_;
-    my $nest;
-    $nest = qr[ (?> [^\\{}]+ | \\. | { (??{ $nest }) } )* ]x;
-    if (${&Rx} =~ m{ \G ($nest) \} \) }xgc) {
+    if (${&Rx} =~ m{ \G ($nest_eval) \} \) }xgc) {
       push @{ $S->{flags} }, &Rf;
       return $S->object(eval => $1);
     }
@@ -721,9 +724,7 @@
   # logical
   $self->add_handler('(??{' => sub {
     my ($S) = @_;
-    my $nest;
-    $nest = qr[ (?> [^\\{}]+ | \\. | { (??{ $nest }) } )* ]x;
-    if (${&Rx} =~ m{ \G ($nest) \} \) }xgc) {
+    if (${&Rx} =~ m{ \G ($nest_logical) \} \) }xgc) {
       push @{ $S->{flags} }, &Rf;
       return $S->object(logical => $1);
     }

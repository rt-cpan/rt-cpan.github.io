Index: lib/Perl/Critic/Policy/RegularExpressions/ProhibitUnusedCapture.pm
===================================================================
--- lib/Perl/Critic/Policy/RegularExpressions/ProhibitUnusedCapture.pm	(revision 4057)
+++ lib/Perl/Critic/Policy/RegularExpressions/ProhibitUnusedCapture.pm	(working copy)
@@ -19,7 +19,8 @@
 
 use Perl::Critic::Exception::Fatal::Internal qw{ throw_internal };
 use Perl::Critic::Utils qw{
-    :booleans :severities hashify precedence_of split_nodes_on_comma
+    :booleans :characters :severities hashify precedence_of
+    split_nodes_on_comma
 };
 use base 'Perl::Critic::Policy';
 
@@ -515,7 +516,8 @@
     if ( $elem->isa( 'PPI::Token::HereDoc' ) ) {
         $elem->content() =~ m/ \A << \s* ' /sxm
             or _mark_magic_in_content(
-            $elem->heredoc(), $re, $captures, $named_captures, $doc );
+            join( $EMPTY, $elem->heredoc() ), $re, $captures,
+            $named_captures, $doc );
         return;
     }
 

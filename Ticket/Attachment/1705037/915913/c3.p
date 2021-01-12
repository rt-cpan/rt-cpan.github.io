commit 3d01b264a4a104eaa0bb4c9a54ff630232bba1e7
Author: Reini Urban <rurban@cpan.org>
Date:   Tue Feb 14 14:38:11 2017 +0100

    Fix multiple inheritance for c3
    
    cperl switched to c3 already (perl5 might do later evtl.)
    and fails with "Inconsistent hierarchy during C3 merge".
    
    With multiple inheritance (@ISA>1), the c3 mro
    refuses to load the most specific after the least specific base class.
    The general rule to avoid inconsistency for @ISA is
    from most specific to least specific. I.e. Exporter needs to be the last

diff --git t/Math/BigFloat/Subclass.pm t/Math/BigFloat/Subclass.pm
index f35e267..c9ec01e 100644
--- t/Math/BigFloat/Subclass.pm
+++ t/Math/BigFloat/Subclass.pm
@@ -14,9 +14,9 @@ use Math::BigFloat 1.38;
 
 our ($accuracy, $precision, $round_mode, $div_scale);
 
-our @ISA = qw(Exporter Math::BigFloat);
+our @ISA = qw(Math::BigFloat Exporter);
 
-our $VERSION = "0.06";
+our $VERSION = "0.07";
 
 use overload;                   # inherit overload from BigInt
 
diff --git t/Math/BigInt/Subclass.pm t/Math/BigInt/Subclass.pm
index 8876a83..5acdf1c 100644
--- t/Math/BigInt/Subclass.pm
+++ t/Math/BigInt/Subclass.pm
@@ -14,10 +14,10 @@ use Math::BigInt 1.64;
 our $lib;
 our ($accuracy, $precision, $round_mode, $div_scale);
 
-our @ISA = qw(Exporter Math::BigInt);
+our @ISA = qw(Math::BigInt Exporter);
 our @EXPORT_OK = qw(bgcd objectify);
 
-our $VERSION = "0.05";
+our $VERSION = "0.06";
 
 use overload;                   # inherit overload from BigInt
 
diff --git t/upgradef.t t/upgradef.t
index d208890..0663cda 100644
--- t/upgradef.t
+++ t/upgradef.t
@@ -10,7 +10,7 @@ package Math::BigFloat::Test;
 
 use Math::BigFloat;
 require Exporter;
-our @ISA = qw/Exporter Math::BigFloat/;
+our @ISA = qw/Math::BigFloat Exporter/;
 
 use overload;
 

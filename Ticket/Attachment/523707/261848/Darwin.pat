--- Darwin.old	2008-10-14 02:42:41.000000000 -0400
+++ Darwin.pm	2008-10-24 00:02:02.000000000 -0400
@@ -11,7 +11,7 @@
 
 use vars qw{$VERSION @ISA};
 BEGIN {
-	$VERSION = '0.82';
+	$VERSION = '0.82_01';
 	@ISA     = 'File::HomeDir::Unix';
 }
 
@@ -112,7 +112,7 @@
 sub users_home {
 	my $class = shift;
 	my $home  = $class->SUPER::users_home(@_);
-	return Cwd::abs_path($home);
+	return defined $home ? Cwd::abs_path($home) : undef;
 }
 
 # in theory this can be done, but for now, let's cheat, since the
@@ -141,7 +141,8 @@
 	my ($class, $path, $name) = @_;
 	my $my_home    = $class->my_home;
 	my $users_home = $class->users_home($name);
-	$path =~ s/^Q$my_home/$users_home/;
+	defined $users_home or return undef;
+	$path =~ s/^\Q$my_home/$users_home/;
 	return $path;
 }
 

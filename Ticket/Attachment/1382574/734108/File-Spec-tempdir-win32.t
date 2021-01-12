#!perl

use Test::More;

use strict;
use warnings;

require_ok('File::Spec');

use File::Spec;
my $temp = File::Spec->tmpdir;
diag("\nDEBUG: Tempdir is: '$temp'");

# ### single \ is a fault
# ### valid temporary dir should be:
# %LOCALAPPDATA%\Temp   as user temporary dir
# C:\TMP                system wide
# C:\TEMP               system wide
#
# fails because %TEMP%, %TMPDIR% or %TEMP% are not used with taint mode!
# see line 53 in file File\Spec\Win32.pm
ok( $temp !~ /^\\/, 'tmpdir is not like \\' );

done_testing();

1;

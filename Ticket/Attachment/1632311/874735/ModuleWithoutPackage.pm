use strict;
use warnings;

# Yes, I know... There is no line like this in the file...
# packge ModuleWithoutPackage;

sub foo {
    open I, '/etc/passwd';
    close I;
}

1;


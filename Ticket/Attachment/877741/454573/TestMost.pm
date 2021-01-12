package TestMost;

# Import Test::Most's symbols and re-export them
require Test::Most;
Test::Most->import;
    Test::Most->import;

sub import {
    Test::Most->import;
}

1;

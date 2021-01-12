#!/usr/bin/perl -w
#use strict;
BEGIN {
    sub CONST () { 0x80000000 }
}
use Win32::API;
$| = 1;
$Win32::API::DEBUG = 1;
print "Win32::API $Win32::API::VERSION\n";
my $o = Win32::API->new( 'testdll.dll',
                        'DWORD __stdcall _DWORDCall@0()'
                        );
my $ret = $o->Call();
die "return (val=$ret) should be equal to CONST (val=".CONST.") but isnt"
    if $ret != CONST;
print "exiting\n";

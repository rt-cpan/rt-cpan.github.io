#!/usr/bin/perl -w
#use strict;
use Win32::API;
$| = 1;
$Win32::API::DEBUG = 1;
print "Win32::API $Win32::API::VERSION\n";
my $o = Win32::API->new( 'testdll.dll', 'DWORD __stdcall _PtrUShortCall@8 (DWORD_PTR ptr, USHORT num)');
my $ret = $o->Call(1, 2);
print "exiting\n";

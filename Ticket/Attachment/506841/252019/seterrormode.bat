@echo off
if exist C:\Smokes\perl5\bin\perl.exe (
  C:\Smokes\perl5\bin\perl.exe -x -S %0 %*
) else (
  echo Could not find perl.exe in C:\Smokes\perl5\bin
)
goto endofperl
#!perl
#line 10
use strict;
use warnings;

my $Registry;
use Win32::TieRegistry (TiedRef => \$Registry, Delimiter => '/', ':REG_');

MAIN: {
    my $ae_debug_key = 'HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/Windows NT/CurrentVersion/AeDebug';
    my $dr_watson_key = 'HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/DrWatson';
    my $error_reporting_key = 'HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/PCHealth/ErrorReporting';

    my $auto_val = "$ae_debug_key//Auto";
    my $debugger_val = "$ae_debug_key//Debugger";
    my $visual_notification_val = "$dr_watson_key//VisualNotification";
    my $do_report_val = "$error_reporting_key//DoReport";
    my $show_ui_val = "$error_reporting_key//ShowUI";

    if (@ARGV == 1 and $ARGV[0] =~ /^(?:off|0)$/io) {
        $Registry->{$auto_val} = 1;
        $Registry->{$debugger_val} = 'drwtsn32 -p %ld -e %ld -g';
        $Registry->{$visual_notification_val} = [ pack('L', 0), REG_DWORD ];
        $Registry->{$do_report_val} = [ pack('L', 0), REG_DWORD ];
        $Registry->{$show_ui_val} = [ pack('L', 0), REG_DWORD ];
        }
    elsif (@ARGV == 1 and $ARGV[0] =~ /^(?:on|1)$/io) {
        $Registry->{$auto_val} = 0;
        $Registry->{$debugger_val} = '"C:\\Program Files\\Microsoft Visual Studio\\Common\\MSDev98\\Bin\\msdev.exe" -p %ld -e %ld';
        $Registry->{$visual_notification_val} = [ pack('L', 0), REG_DWORD ];
        $Registry->{$do_report_val} = [ pack('L', 1), REG_DWORD ];
        $Registry->{$show_ui_val} = [ pack('L', 1), REG_DWORD ];
    }
    elsif (@ARGV == 1 and $ARGV[0] =~ /^vc8$/io) {
        $Registry->{$auto_val} = 0;
        $Registry->{$debugger_val} = '"C:\\WINDOWS\\system32\\VsJITDebugger.exe" -p %ld -e %ld';
        $Registry->{$visual_notification_val} = [ pack('L', 0), REG_DWORD ];
        $Registry->{$do_report_val} = [ pack('L', 1), REG_DWORD ];
        $Registry->{$show_ui_val} = [ pack('L', 1), REG_DWORD ];
    }
    else {
        die "Invalid arguments.\nUsage: $0 {off|on|vc8}\n";
    }
}

__END__
:endofperl

#!/usr/bin/perl -w

use strict;
use Win32::GuiTest qw( :ALL );

foreach (0..50)
{
    MouseMoveAbsPix(100+$_, 100);
    SendLButtonDown();
    SendLButtonUp();
    MouseMoveAbsPix(100, 100+$_);
    SendLButtonDown();
    SendLButtonUp();
}

foreach (0..50)
{
    MouseMoveAbsPix_fixed(100+$_, 200);
    SendLButtonDown();
    SendLButtonUp();
    MouseMoveAbsPix_fixed(100, 200+$_);
    SendLButtonDown();
    SendLButtonUp();
}

sub MouseMoveAbsPix_fixed
{
    my ($x1, $y1) = @_;

    # Round UP!
    my $x2 = int(65536 / 1280 * $x1 + 0.999999);
    my $y2 = int(65536 / 1024 * $y1 + 0.999999);

    SendMouseMoveAbs($x2, $y2);
}
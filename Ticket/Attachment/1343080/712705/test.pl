#!/usr/bin/perl -w
use strict;

use Linux::Smaps;

sub _linux_size_check_old {
    my $class = shift;

    my ($size, $share) = (0, 0);

    if (open my $fh, '<', '/proc/self/statm') {
        ($size, $share) = (split /\s/, scalar <$fh>)[0,2];
        close $fh;
    }
    else {
        $class->_error_log("Fatal Error: couldn't access /proc/self/status");
    }

    # linux on intel x86 has 4KB page size...
    return ($size * 4, $share * 4);
}

sub _linux_size_check {
    my $class = shift;

    my ($size, $data) = (0, 0);

    if (open my $fh, '<', '/proc/self/statm') {
        ($size, $data) = (split /\s/, scalar <$fh>)[0,5];
        close $fh;
    }
    else {
        $class->_error_log("Fatal Error: couldn't access /proc/self/status");
    }

    # linux on intel x86 has 4KB page size...
	$size <<= 2;
	$data <<= 2;
	return ($size, $data, $size - $data);
}

sub _linux_smaps_size_check {
    my $class = shift;

    my $s = Linux::Smaps->new($$)->all;
    return ($s->size,
	    $s->shared_clean + $s->shared_dirty,
	    $s->private_clean + $s->private_dirty);
}

my $size;
my $share;
my $unshared;

($size, $share, $unshared) = _linux_size_check_old;
$unshared = ($size - $share);
printf "Legacy check old: SIZE=%d, SHARE=%d, UNSHARED=%d\n", $size, $share, $unshared;

($size, $share, $unshared) = _linux_size_check;
printf "Legacy check new: SIZE=%d, SHARE=%d, UNSHARED=%d\n", $size, $share, $unshared;

($size, $share, $unshared) = _linux_smaps_size_check;
printf "Smaps check     : SIZE=%d, SHARE=%d, UNSHARED=%d\n", $size, $share, $unshared;

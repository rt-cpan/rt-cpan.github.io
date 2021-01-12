#! /usr/bin/env perl

use strict;
use warnings;
use Statistics::R;   

my $out = '';
my $R = Statistics::R->new();
$R->startR;
$R->send(q`library(fitdistrplus)`);
$out .= $R->read;
$R->send(qq`x1 <- c(6.4, 13.3, 4.1, 1.3, 14.1, 10.6, 9.9, 9.6, 15.3, 22.1, 13.4, 13.2, 8.4, 6.3, 8.9, 5.2, 10.9, 14.4)`);
$out .= $R->read;
$R->send(q`f1l <- fitdist(x1, "norm")`);
$out .= $R->read;
$R->send(q`gofstat(f1l, print.test = TRUE)`);
$out .= $R->read;
$R->send(q`mean <- f1l$estimate[1]`);
$out .= $R->read;
$R->send(q`print(mean)`);
$out .= $R->read;
$R->send(q`write.table(mean, file="", row.names=FALSE, col.names=FALSE)`);
$out .= $R->read;
$R->stopR();
print $out;

exit;

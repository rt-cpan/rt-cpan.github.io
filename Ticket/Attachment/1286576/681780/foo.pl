use strict;
use Prima;
use Prima::Buttons;
use Prima 'Application';

my $main = Prima::MainWindow->new (size => [100,100]);
$main->insert ('Button',
               text => 'Maximize',
               pack => { side => 'top' },
               onClick  => sub {
                 my ($button) = @_;
                 print "maximize\n";
                 $main->maximize;
               });
$main->insert ('Button',
               text => 'Restore',
               pack => { side => 'top' },
               onClick  => sub {
                 my ($button) = @_;
                 print "restore\n";
                 $main->restore;
               });
Prima->run;
exit 0;

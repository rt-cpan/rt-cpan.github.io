# jjgbug.pl - ActiveState Perl, Build 813
#             Windows XP 5.1
#
# Bug is that the text field portion of the combobox
# is always white and ignores system (windows background) 
# default
#

use strict;
use Tk;
use Tk::JComboBox;

my @Type = ( 'Apple', 'Orange', 'Lemon', 'Peach' );

my $mw = MainWindow->new;
$mw->geometry('100x100+100+100');

my $jcb = $mw->JComboBox(
            -relief => 'sunken',
            -mode => 'editable',
            -choices => \@Type, 
          )->pack(-anchor => 'w'); 

MainLoop;


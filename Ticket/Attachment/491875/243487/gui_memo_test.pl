use strict;
use Win32::GUI();


my $mw = Win32::GUI::Window->new(
    -text=>"Memory Test",
    -pos=>[200,200],
    -width=>200,-height=>200,
    -onTerminate=>sub{-1;},
);

$mw->AddButton(
    -pos=>[70,100],
    -width=>60,
    -height=>22,
    -text=>"Button"
);

$mw->Show();
Win32::GUI::Dialog();

sub Main_Minimize{
    $mw->Hide();
    1;
}





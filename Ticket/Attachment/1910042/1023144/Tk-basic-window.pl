#! /usr/bin/perl

use strict;
use warnings;
use 5.010;
use utf8;
use Tk;
use Tk::Frame;
use Tk::HList;

#   Tk::CmdLine::SetArguments (-font => "Ubuntu");
#   Tk::CmdLine::SetResources ('*Label*font: Ubuntu 12 normal', 'widgetDefault');

   my ($w_post, @posten);
   my (@opt_dis, @opt_dis_e, @opt_dis_w, @opt_pos);

   @posten = qw (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16);
   @opt_dis = (-relief => 'sunken');
   @opt_dis_e = (-anchor => 'e', @opt_dis);
   @opt_dis_w = (-anchor => 'w', @opt_dis);
   @opt_pos = (-sticky => 'ew');

   my $mw = MainWindow -> new (-title => "Mutaties");
   my %window = ();
   ($window{F1} = $mw -> Frame ()) -> pack ();
   ($window{F1} -> Label (-text => 'Bedrag')) -> grid (-column => 0, -row => 0, @opt_pos);
   ($window{Vbedrag} = $window{F1} -> Label (-text => '0.00', -width => 12, @opt_dis_e)) ->
                                                                                          grid (-column => 0, -row => 1, @opt_pos);
   ($window{F1} -> Label (-text => 'Datum')) -> grid (-column => 1, -row => 0, @opt_pos);
   ($window{F1} -> Label (-text => 'Volgnummer')) -> grid (-column => 2, -row => 0, @opt_pos);
   ($window{F1} -> Label (-text => 'Tegenrekening')) -> grid (-column => 3, -row => 0, -columnspan => 2, @opt_pos);
   ($window{Vtegen} = $window{F1} -> Label (-text => '', -width => 31, @opt_dis_w)) ->
                                                                     grid (-column => 3, -row => 1, -columnspan => 2, @opt_pos);
   ($window{F2} = $mw -> Frame ()) -> pack (-fill => 'x');
   ($window{F2} -> Label (-text => 'Mutatie', -width => 31)) -> pack (-fill => 'x');
   ($window{Vsoort} = $window{F2} -> Label (-text => 'Mutatie', -width => 31, @opt_dis_w)) -> pack (-fill => 'x');
   ($window{F2} -> Label (-text => 'Naam', -width => 24)) -> pack (-fill => 'x');
   ($window{F2} -> Label (-text => 'Mededelingen', -width => 50)) -> pack (-fill => 'x');
   ($window{Vmede} = $window{F2} -> Scrolled ('ROText', -scrollbars => 'oe', -width => 31, -height => 5, -wrap => 'word',
                                              @opt_dis)) -> pack (-fill => 'x');
   ($window{F3} = $mw -> Frame ()) -> pack (-fill => 'x');
   $window{F3} -> gridColumnconfigure ([0, 1], -weight => 1);
   ($window{F3} -> Label (-text => 'Post:')) -> grid (-column => 0, -row => 0, @opt_pos);
   ($window{Vpost} = $window{F3} -> BrowseEntry (-variable => \$w_post, -autolistwidth => 1, -choices => \@posten,
                                                 -browsecmd => \&change_color, -state => 'readonly')) ->
                                                                                          grid (-column => 0, -row => 1, @opt_pos);
   ($window{Vpost} -> Subwidget ('slistbox')) -> configure (-height => scalar (@posten));
   ($window{Vpost} -> Subwidget ('entry')) -> configure (-disabledbackground => '', -disabledforeground => '');
MainLoop;
__END__
# Balloon, pop up help window when mouse lingers over widget.



#my $lmsg = "";
#
#my $top = MainWindow->new;
#my $f = $top->Frame;
#
## status bar widget
#
## create the widgets to be explained
#my $xxx = 0;
#
#my $b1 = $top->Button(-text => "Something Unexpected",
#		      -command => sub {$top->destroy;});
#my $b2 = $top->Button(-text => "Something Else Unexpected");
#$b2->configure(-command => sub {$b2->destroy;});
#
## Pack the created widgets:
#$b1->pack(-side => "top", -expand => 1);
#$b2->pack(-side => "top", -expand => 1);
#
#
## create the balloon widget
#my $b = $top->Balloon(-initwait => 1000, -state => 'balloon');
#
#$b->attach($b1,
#	   -balloonmsg => "Close Window",
#	   -statusmsg => "Press this button to close this window",
##      -balloonposition => 'mouse'
#      );
#$b->attach($b2,
#	   -balloonmsg => "Self-destruct\nButton",
#	   -statusmsg => "Press this button and it will get rid of itself");
#
#my $msg = '';
#my @word = ('', '');  # Indicies surrounding the current word.
#my @last = ('', '');  # Same for last word.
#
#MainLoop;
#
#
#
#__END__
#my (@posten, @posten_main, @posten_uitleg);
#
#@posten_main = ('',             'Nog niet gerubriceerd',
#                'ABONNEMENTEN', 'Incl. EWEtel, NFN, XS4ALL',
#                'AH',           'AH, C1000 en andere supermarkten',
#                'AUTOKOSTEN',   'Ook verkeersverzekeringen',
#                'CC',           'Creditcard afrekeningen',
#                'DIVERSEN',     'Diversen, incl. staatsloterij, postbank kosten, Binck kosten',
#                'GIFTEN',       'Niet-verplichte betalingen',
#                'HUIS',         'Uitgaven i.v.m. ons huis, incl. hypotheek, OZB, Grundsteuer',
#                'INTERN',       'Overboekingen tussen Jaap, Renée en Motor',
#                'LUXE',         'Luxe (niet noodzakelijke) uitgaven, incl. T-Mobile, CanalDigitaal',
#                'MEDISCH',      'Medische uitgaven en vergoedingen (GEEN zorgverzekering!)',
#                'NOOD',         'Noodzakelijke kosten die niet vallen onder een andere post, EWE, TAV, GEZ',
#                'OPNAME',       'Opnames en kasstortingen',
#                'SALARIS',      'Salaris, pensioen, uitkeringen, inkomstenbelasting',
#                'VERZEKERING',  'Incl. zorgverzekering, exclusief verkeersverzekeringen',
#                'VLIEG',        'Vliegkosten incl. AOPA',
#                'ZELF',         'Overboekingen tussen eigen rekeningen, rente');
## Unravel name of posts and explanation.
#for (my $i=0; $i<=$#posten_main; $i=$i+2) {push (@posten, $posten_main[$i])};
#for (my $i=1; $i<=$#posten_main; $i=$i+2) {push (@posten_uitleg, $posten_main[$i])};
#
#my ($response);
#my ($w_bedrag, $w_dat, $w_volg, $w_tegen);
#my (%window);
my ($m, $mw, $mw1, $list, $color, $header, $entry, %blad, @opt_header);
#@Show_Message ('info', ['OK', 'Gesnopen', 'Prut'], 'Test', 'Dit is een test', 'Prut');

$m = MainWindow -> new (title => 'Test');
#($mw = $m -> Frame ()) -> pack ();
#   ($blad{0} = $mw -> Label (-text => "Bladnummer: 123", -font => [-weight => 'bold'],
#                                           -relief => 'flat')) -> pack (-side => 'left');
#   ($blad{jaar} = $mw -> Label (-text => "Blad begint in jaar: 2020", -font => [-weight => 'bold'], -background => 'grey90',
#                                           -relief => 'flat')) -> pack (-side => 'right');
#   ($blad{midden} = $mw -> Label (-text => '                                                                            ', -relief => 'flat',  -background => 'grey90')) -> pack ();
#   ($m -> Label (-height => 4, -bitmap => 'transparent', -relief => 'flat', -borderwidth => 0, -background => 'grey70')) -> pack (-fill => 'x');
#
($mw1 = $m -> Frame ()) -> pack ();
$color = $mw1 -> cget (-background);
#($mw1 -> Label (-text => 'regel 2')) -> pack;
#($list = $mw1 -> Scrolled ('HList', -scrollbars => 'oe', -itemtype => 'text', -header => 1, -columns => 8, -width => 137, -selectmode => 'none')) -> pack ();
#$header = $list -> ItemStyle ('text', -stylename => 'header', -font => [-weight => 'bold']);
#$entry = $list -> ItemStyle ('text', -stylename => 'entry', -background => 'white');
#@opt_header = (-headerbackground => $color, -style => $header);
#$list -> columnWidth (0, -char, 9);
#$list -> columnWidth (1, -char, 50);
#foreach (2 .. 7) {
#   $list -> columnWidth ($_, -char, 13);
#}
#$list -> headerCreate (0, -text => 'Datum', @opt_header);
#$list -> headerCreate (1, -text => 'Omschrijving', @opt_header);
#$list -> headerCreate (2, -text => 'Kas', @opt_header);
#$list -> headerCreate (3, -text => 'Huishouden', @opt_header);
#$list -> headerCreate (4, -text => 'Jaap', @opt_header);
#$list -> headerCreate (5, -text => 'Renée', @opt_header);
#$list -> headerCreate (6, -text => 'Huis', @opt_header);
#$list -> headerCreate (7, -text => 'Motor/auto', @opt_header);
   my (@opt_dis, @opt_dis_e, @opt_dis_w, @opt_pos, %window, $w_bedrag, $w_dat, $w_volg, $w_tegen, $w_soort, $w_naam, $w_post, @posten);

   @opt_dis = (-relief => 'sunken');
   @opt_dis_e = (-anchor => 'e', @opt_dis);
   @opt_dis_w = (-anchor => 'w', @opt_dis);
   @opt_pos = (-sticky => 'ew');
@posten = qw (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16);

   $mw = MainWindow -> new ();
   %window = ();
   ($window{F1} = $mw -> Frame ()) -> pack (-fill => 'x');
   $window{F1} -> gridColumnconfigure ([0, 1, 2], -weight => 1, -uniform => 'F1eq');
   ($window{F1} -> Label (-text => 'Bedrag')) -> grid (-column => 0, -row => 0, @opt_pos);
   ($window{Vbedrag} = $window{F1} -> Label (-textvariable => \$w_bedrag, -width => 12, @opt_dis_e)) ->
                                                                                          grid (-column => 0, -row => 1, @opt_pos);
   ($window{F1} -> Label (-text => 'Datum')) -> grid (-column => 1, -row => 0, @opt_pos);
   ($window{Vdatum} = $window{F1} -> Label (-textvariable => \$w_dat, -width => 12, -anchor => 'center', @opt_dis)) ->
                                                                                          grid (-column => 1, -row => 1, @opt_pos);
   ($window{F1} -> Label (-text => 'Volgnummer')) -> grid (-column => 2, -row => 0, @opt_pos);
   ($window{Vvolg} = $window{F1} -> Label (-textvariable => \$w_volg, -width => 12, @opt_dis_e)) ->
                                                                                          grid (-column => 2, -row => 1, @opt_pos);
   ($window{F1} -> Label (-text => 'Tegenrekening')) -> grid (-column => 3, -row => 0, -columnspan => 2, @opt_pos);
   ($window{Vtegen} = $window{F1} -> Label (-textvariable => \$w_tegen, -width => 31, @opt_dis_w)) ->
                                                                        grid (-column => 3, -row => 1, -columnspan => 2, @opt_pos);
   ($window{F2} = $mw -> Frame ()) -> pack (-fill => 'x');
   ($window{F2} -> Label (-text => 'Mutatie', -width => 31)) -> pack (-fill => 'x');
   ($window{Vsoort} = $window{F2} -> Label (-textvariable => \$w_soort, -width => 31, @opt_dis_w)) -> pack (-fill => 'x');
   ($window{F2} -> Label (-text => 'Naam', -width => 24)) -> pack (-fill => 'x');
   ($window{Vnaam} = $window{F2} -> Label (-textvariable => \$w_naam, -width => 24, @opt_dis_w)) -> pack (-fill => 'x');
   ($window{F2} -> Label (-text => 'Mededelingen', -width => 50)) -> pack (-fill => 'x');
   ($window{Vmede} = $window{F2} -> Scrolled ('ROText', -scrollbars => 'oe', -width => 31, -height => 5, -wrap => 'word',
                                              @opt_dis)) -> pack (-fill => 'x');
   ($window{F3} = $mw -> Frame ()) -> pack (-fill => 'x');
   $window{F3} -> gridColumnconfigure ([0, 1], -weight => 1);
   ($window{F3} -> Label (-text => 'Post:')) -> grid (-column => 0, -row => 0, @opt_pos);
   ($window{Vpost} = $window{F3} -> BrowseEntry (-variable => \$w_post, -autolistwidth => 1, -choices => \@posten,
                                                 -browsecmd => \&change_color, -state => 'readonly')) ->
                                                                                          grid (-column => 0, -row => 1, @opt_pos);
   ($window{Vpost} -> Subwidget ('slistbox')) -> configure (-height => scalar (@posten));
   ($window{Vpost} -> Subwidget ('entry')) -> configure (-disabledbackground => '', -disabledforeground => '');
#
#$list -> configure (-height => 30);
#$list -> add ('0', -state => 'disabled');
#$list -> itemCreate ('0', 0, -text => '20200828', -style => $entry);
#$list -> itemCreate ('0', 1, -text => 'Dit is een test', -style => $entry);
#


MainLoop;

#
##$mw = MainWindow -> new (title => 'Test', -background => 'black');
#Show_Message ('info', ['OK', 'Cancel', 'Prut', 'Gesnopen'], 'Test', "Dit is een test\n" .
#                                                                    "met meerdere regels\n" .
#                                                                    "waarvan ik me afvraag hoe dat er uit ziet\n" .
#                                                                    "laatste regel");
#Error_And_Wait ("Dit is het einde.");
#Show_Message ('info', ['OK', 'Cancel', 'Prut', 'Gesnopen'], 'Test', 'Dit is een test');
#$mw -> geometry ('200x200');
#$mw -> Label (-text => 'Hello, world!') -> pack;
#$mw -> Button (-text => 'Quit', -command => sub {$mw -> destroy}) -> pack;
#MainLoop;
#$mw = MainWindow -> new (title => 'Test2', -height => 100, -width => 100, -background => 'red');

#$dialog = $mw -> Dialog (-text => 'Dit is een test', -bitmap => 'info', -title => 'Test Dialog', -default_button => 'Close', -buttons => [qw/Close/]);
#$response = $dialog -> Show ();
#$response = $mw -> messageBox (-default => 'ok', -icon => 'info', -message => 'Dit is een test', -type => 'ok');

#$mw -> Label (-text => 'Hello, world!') -> pack;
#$mw -> Button (-text => 'Quit', -command => sub {$mw -> destroy}) -> pack;

#sub create_window {
#
#   my (@opt_dis, @opt_dis_e, @opt_dis_w, @opt_pos, @opt_data_c, @opt_data_e, @opt_data_w, @opt_data_text, @pad, @stick_ew);
#   my ($Parrow, $Plabel, $Plist, $Flower, $PLw, $Fradio, $Fswitches, $vsb);
#
##   @opt_dis = (-background => 'palegreen1', -relief => 'sunken', -font => [-family => 'Ubuntu', -size => 12]);
#   @opt_dis = (-background => 'palegreen1', -relief => 'sunken');
#   @opt_dis_e = (-anchor => 'e', @opt_dis);
#   @opt_dis_w = (-anchor => 'w', @opt_dis);
#   
#   @opt_pos = (-sticky => 'ew');
#
#
#
#   #@opt_data_e = (@opt_displ, @pad, -sticky => 'e');
#   #@opt_data_w = (@opt_displ, @pad, -sticky => 'w');
#   #@opt_data_c = (@opt_displ, @pad, -anchor => 'center');
#   #@opt_data_text = (@opt_displ, -state => 'disabled', -wrap => 'word');
#
#   @stick_ew = (-sticky => 'ew');
#
##   $mw = MainWindow -> new (-title => "Mutaties op rekening $rekeningnamen{$reknr} ($reknr)");
#   $mw = MainWindow -> new (-title => "Mutaties op rekening testtest");
##   $mw -> Font (-family => 'Ubuntu');
#
#
#   #$mw = $mw0 -> new_toplevel;
#   #$mw -> g_wm_resizable (0, 0);
#   %window = ();
#   ($window{F1} = $mw -> Frame ()) -> pack (-fill => 'x');
#   $window{F1} -> gridColumnconfigure ([0, 1, 2], -weight => 1, -uniform => 'F1eq');
#   ($window{F1} -> Label (-text => 'Bedrag', @opt_dis)) -> grid (-column => 0, -row => 0, @opt_pos);
#   ($window{Vbedrag} = $window{F1} -> Label (-textvariable => \$w_bedrag, -width => 12, @opt_dis_w)) ->
#                                                                                          grid (-column => 0, -row => 1, @opt_pos);
#   ($window{F1} -> Label (-text => 'Datum')) -> grid (-column => 1, -row => 0, @opt_pos);
#   ($window{Vdatum} = $window{F1} -> Label (-textvariable => \$w_dat, -width => 12, @opt_dis_e)) ->
#                                                                                          grid (-column => 1, -row => 1, @opt_pos);
#   ($window{F1} -> Label (-text => 'Volgnummer')) -> grid (-column => 2, -row => 0, @opt_pos);
#   ($window{Vvolg} = $window{F1} -> Label (-textvariable => \$w_volg, -width => 12, @opt_dis_e)) ->
#                                                                                          grid (-column => 2, -row => 1, @opt_pos);
#   ($window{F1} -> Label (-text => 'Tegenrekening')) -> grid (-column => 3, -row => 0, -columnspan => 2, @opt_pos);
#   ($window{Vtegen} = $window{F1} -> Label (-textvariable => \$w_tegen, -width => 31, @opt_dis_w)) ->
#                                                                        grid (-column => 3, -row => 1, -columnspan => 2, @opt_pos);
#
#   MainLoop;
#
__END__
$mw = MainWindow -> new (title => 'Test', -background => 'black');
Error_And_Wait ("Dit is het einde.");
Show_Message ('info', ['OK', 'Cancel', 'Prut', 'Gesnopen'], 'Test', 'Dit is een test');

__END__

# exercise Content.pm as much as possible
# subset of Content.pm to exercise text "cr" routines
# outputs cr.pdf
# author: Phil M Perry

use warnings;
use strict;
use Math::Trig;
use List::Util qw(min max);

#use constant in => 1 / 72;
#use constant cm => 2.54 / 72; 
#use constant mm => 25.4 / 72;
#use constant pt => 1;

use PDF::API2;

use constant OLD_CV => 0;
use constant NEW_CV => 1;
my $ContentVersion = 1;

my $pdf = PDF::API2->new();
my ($page, $grfx, $text); # objects for page, graphics, text
my (@base, @styles, @points, $i, $lw, $angle, @npts);
#$pdf->{forcecompress} = 0;  # don't compress, so we can see what's happening
my (@cellLoc, @cellSize, $font, $width, $d1, $d2, $d3, $d4);
my @axisOffset = (5, 5); # clear the edge of the cell
my $pageNo = 0;
nextPage();
# next (first) page of output, 523pt wide x 720pt high

my $fontR = $pdf->corefont('Times-Roman');
my $fontI = $pdf->corefont('Times-Italic');
my $fontC = $pdf->corefont('Courier');

# ----------------------------------------------------
# 50. cr(): show 3 modes
$grfx->save();

@cellLoc = (212, 625);   # X: 36, 212, 388  Y: 625, 458, 281, 104
@cellSize = (170, 131); 
makeCell(@cellLoc, @cellSize);
@base=@cellLoc;
#$base[0] += 10;
#$base[1] += 10;
$text->font($fontR, 12);
$text->strokecolor('black');
$text->fillcolor('black');
$text->lead(15);

$text->translate($base[0]+15, $base[1]+100);
$text->text('cr()');
$text->cr();
$text->text('goes to the next line');

$text->translate($base[0]+15, $base[1]+60);
$text->text('cr(-8) goes down ');
$text->cr(-8);
$text->text('8pts to start next line');

$text->translate($base[0]+15, $base[1]+20);
$text->text('cr(0)');
$text->cr(0);
$text->text('will     overprint next line');

# caption
drawCaption(['cr() carriage return'], 'LC');

$grfx->restore();

# ----------------------------------------------------
$pdf->saveas('cr.pdf');

# =====================================================================
sub colors {
  my $color = shift;
  $grfx->strokecolor($color);
  $grfx->fillcolor($color);
  $text->strokecolor($color);
  $text->fillcolor($color);
}

# ---------------------------------------
# if a single coordinate pair, produces a green dot
# if two or more pairs, produces a green dot at each pair, and connects 
#   with a green line
sub greenLine {
  my $pointsRef = shift;
    my @points = @{ $pointsRef };

  my $i;

  $grfx->linewidth(1);
  $grfx->strokecolor('green');
  $grfx->poly(@points);
  $grfx->stroke();

  # draw green dot at each point
  $grfx->linewidth(3);
  $grfx->linecap(1);  # round
  for ($i=0; $i<@points; $i+=2) {
    $grfx->poly($points[$i],$points[$i+1], $points[$i],$points[$i+1]);
  }
  $grfx->stroke();
}

# ---------------------------------------
sub nextPage {
  $pageNo++;
  $page = $pdf->page();
  $grfx = $page->gfx();
  $text = $page->text();
  $page->mediabox('Universal');
  $font = $pdf->corefont('Times-Roman');
  $text->translate(595/2,15);
  $text->font($font, 10);
  $text->fillcolor('black');
  $text->text_center($pageNo);
}

# ---------------------------------------
sub makeCell {
  my ($cellLocX, $cellLocY, $cellSizeW, $cellSizeH) = @_;

  # outline and clip of cell
  $grfx->strokecolor('#CCC');
  $grfx->linewidth(2);
  $grfx->rect($cellLocX,$cellLocY, $cellSizeW,$cellSizeH);
  $grfx->stroke();

 #$grfx->linewidth(1);
 #$grfx->rect($cellLocX,$cellLocY, $cellSizeW,$cellSizeH);
 #$grfx->clip(1);
 #$text->linewidth(1);
 #$text->rect($cellLocX,$cellLocY, $cellSizeW,$cellSizeH);
 #$text->clip(1);
}

# ---------------------------------------
# draw a set of axes at current origin
sub drawAxes {

  # draw 75-long axes, at offset 
  $grfx->linejoin(0);  
  $grfx->linewidth(1);
  $grfx->poly($axisOffset[0]+0, $axisOffset[1]+75, 
	      $axisOffset[0]+0, $axisOffset[1]+0, 
	      $axisOffset[0]+75,$axisOffset[1]+0);
  $grfx->stroke();
  # 36x36 box
 #$grfx->rect(0,0, 36,36);  # draw a square
 #$grfx->stroke();

  # X axis arrowhead draw
  $grfx->poly($axisOffset[0]+75-2, $axisOffset[1]+0+2, 
	      $axisOffset[0]+75+0, $axisOffset[1]+0+0, 
	      $axisOffset[0]+75-2, $axisOffset[1]+0-2);
  $grfx->stroke();

  # Y axis arrowhead draw
  $grfx->poly($axisOffset[0]+0-2, $axisOffset[1]+75-2, 
  	      $axisOffset[0]+0+0, $axisOffset[1]+75+0, 
 	      $axisOffset[0]+0+2, $axisOffset[1]+75-2);
  $grfx->stroke();

}

# ---------------------------------------
# label the X and Y axes, and draw a sample 'n'
sub drawLabels {
  my ($Xlabel, $Ylabel) = @_;

  my $fontI = $pdf->corefont('Times-Italic');
  my $fontR = $pdf->corefont('Times-Roman');

  # outline "n"
  $text->distance($axisOffset[0]+0, $axisOffset[1]+0);
  $text->font($fontR, 72);
  $text->render(1);
  $text->text('n');

  $text->render(0);
  $text->font($fontI, 12);

  # X axis label
  $text->distance(75+2, 0-3);
  $text->text($Xlabel);

  # Y axis label
  $text->distance(-75-2+0-4, 0+3+75+2);
  $text->text($Ylabel);

}

# ---------------------------------------
# write out a 1 or more line caption             
sub drawCaption {
  my $captionsRef = shift;
    my @captions = @$captionsRef;
  my $just = shift;  # 'LC' = left justified (centered on longest line)

  my ($width, $i, $y);

  $text->font($fontC, 12);
  $text->fillcolor('black');

  # find longest line width
  $width = 0;
  foreach (@captions) {
    $width = max($width, $text->advancewidth($_));
  }

  for ($i=0, $y=20; $i<@captions; $i++, $y+=13) {
    # $just = LC
    $text->translate($cellLoc[0]+$cellSize[0]/2-$width/2, $cellLoc[1]-$y);
    $text->text($captions[$i]);
  }
}

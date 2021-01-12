
  use locale;
  use POSIX;
 #use PDF::Report;
  use PDF::API2;

 #my $encoding = 'cp1251';
  my $encoding = 'cp1254';

  POSIX::setlocale($encoding)
    or die 'cannot set locale';

  my $pdf = new PDF::API2(  );
  $pdf->mediabox( 'A4' );

  my $page = $pdf->page();
  my $txt = $page->text;

  my ($r,$c);
  my $row4567 = '';
    for ($r = 4; $r < 8; $r++) {
      for ($c = 0; $c < 16; $c++) {
	$row4567 .= chr($r*16 + $c);
      }
      $row4567 .= ' ';
    }
  my $row89AB = '';
    for ($r = 8; $r < 12; $r++) {
      for ($c = 0; $c < 16; $c++) {
	$row89AB .= chr($r*16 + $c);
      }
      $row89AB .= ' ';
    }
  my $rowCDEF = '';
    for ($r = 12; $r < 16; $r++) {
      for ($c = 0; $c < 16; $c++) {
	$rowCDEF .= chr($r*16 + $c);
      }
      $rowCDEF .= ' ';
    }

  my $font = $pdf->ttfont('Times.ttf', '-encode' => $encoding );
  my $fontsize = 12;
  $txt->font($font,$fontsize);
  $txt->translate(10,700);
  $txt->text($row4567);
  $txt->translate(10,650);
  $txt->text($row89AB);
  $txt->translate(10,600);
  $txt->text($rowCDEF);

  my $font = $pdf->corefont('Times', '-encode' => $encoding );
  my $fontsize = 12;
  $txt->font($font,$fontsize);
  $txt->translate(10,400);
  $txt->text($row4567);
  $txt->translate(10,350);
  $txt->text($row89AB);
  $txt->translate(10,300);
  $txt->text($rowCDEF); 

  my $font = $pdf->corefont('Times', '-encode' => $encoding );
  my $fontsize = 12;
  $txt->font($font,$fontsize);
  $txt->translate(10,750);
  $txt->text("Using true type font, $encoding encoding:");
  $txt->translate(10,450);
  $txt->text("Using core font, $encoding encoding:");

  $pdf->saveas( "$encoding.pdf" );

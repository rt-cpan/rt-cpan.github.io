
  use locale;
  use POSIX;
  use PDF::Report;

  my $encoding = 'cp1251';

  POSIX::setlocale($encoding)
    or die 'cannot set locale';

  my $pdf = new PDF::API2(  );
  $pdf->mediabox( 'A4' );

  my $page = $pdf->page();
  my $txt = $page->text;

  my $font = $pdf->ttfont('Times.ttf', '-encode' => $encoding );
  my $fontsize = 12;
  $txt->font($font,$fontsize);
  $txt->translate(10,700);
  $txt->text("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
  $txt->translate(10,650);
  $txt->text("abcdefghijklmnopqrstuvwxyz");
  $txt->translate(10,600);
  $txt->text("àáâãäå¸æçèéêëìíîïğñòóôõö÷øùüûúışÿ");
  $txt->translate(10,550);
  $txt->text("ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÜÛÚİŞß");

  my $font = $pdf->corefont('Times', '-encode' => $encoding );
  my $fontsize = 12;
  $txt->font($font,$fontsize);
  $txt->translate(10,400);
  $txt->text("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
  $txt->translate(10,350);
  $txt->text("abcdefghijklmnopqrstuvwxyz");
  $txt->translate(10,300);
  $txt->text("àáâãäå¸æçèéêëìíîïğñòóôõö÷øùüûúışÿ");
  $txt->translate(10,250);
  $txt->text("ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÜÛÚİŞß");

  my $font = $pdf->corefont('Times', '-encode' => $encoding );
  my $fontsize = 12;
  $txt->font($font,$fontsize);
  $txt->translate(10,750);
  $txt->text("Using true type font:");
  $txt->translate(10,450);
  $txt->text("Using core font:");

  $pdf->saveas( 'test.pdf' );
#!/usr/bin/perl -w
use strict;

my @er = 
(
	  '0001',
	  10,
	  '0002',
	  12,
	  '0003',
	  14,
	  '0004',
	  16,
	  '0005',
	  18,
	  '0006',
	  20,
	  '0007',
	  22,
	  '0008',
	  24,
	  '0009',
	  26,
	  '0010',
	  28,
	  '0011',
	  30,
	  '0012',
	  32,
	  '0012',
	  34,
	  '0013',
	  36,
	  '0014',
	  38,
	  '0015',
	  40,
	  '0016',
	  42,
	  '0017',
	  44,
	  '0018',
	  46,
	  '0019',
	  48,
	  '0020',
	  50,
	  '0021',
	  52,
	  '0022',
	  54,
	  '0023',
	  56,
	  '0024',
	  58,
	  '0025',
	  60,
	  '0026',
	  62,
	  '0026',
	  64,
	  '0027',
	  66,
	  '0028',
	  68,
	  '0029',
	  70,
	  '0030',
	  72,
	  '0031',
	  74,
	  '0032',
	  76,
	  '0033',
	  78,
	  '0034',
	  80,
	  '0035',
	  82,
	  '0036',
	  84,
	  '0037',
	  86,
	  '0037',
	  88,
	  '0038',
	  90,
	  '0038',
	  92,
	  '0039',
	  94,
	  '0040',
	  96,
	  '0041',
	  98,
	  '0042',
	  100,
	  '0042',
	  102,
	  '0043',
	  104,
	  '0044',
	  106,
	  '0045',
	  108,
	  '0046',
	  110,
	  '0048',
	  112,
	  '0049',
	  114,
	  '0050',
	  116,
	  '0051',
	  118,
	  '0052',
	  120,
	  '0052',
	  122,
	  '0053',
	  124,
	  '0054',
	  126,
	  '0055',
	  128,
	  '0056',
	  130,
	  '0057',
	  132,
	  '0058',
	  134,
	  '0059',
	  136,
	  '0060',
	  138,
	  '0061',
	  140,
	  '0062',
	  142,
	  '0063',
	  144,
	  '0064',
	  146,
	  '0064',
	  148,
	  '0064',
	  150,
	  '0065',
	  152,
	  '0066',
	  154,
	  '0067',
	  156,
	  '0068',
	  158,
	  '0069',
	  160,
	  '0070',
	  162,
	  '0071',
	  164,
	  '0072',
	  166,
	  '0073',
	  168,
	  '0073',
	  170,
	  '0074',
	  172,
	  '0075',
	  174,
	  '0076',
	  176,
	  '0076',
	  178,
	  '0077',
	  180,
	  '0078',
	  182,
	  '0079',
	  184,
	  '0080',
	  186,
	  '0081',
	  188,
	  '0082',
	  190,
	  '0082',
	  192,
	  '0082',
	  194,
	  '0083',
	  196,
	  '0084',
	  198,
	  '0084',
	  200,
	  '0085',
	  202,
	  '0086',
	  204,
	  '0087',
	  206,
	  '0088',
	  208,
	  '0089',
	  210,
	  '0090',
	  212,
	  '0091',
	  214,
	  '0091',
	  216
	);


my $pdfstring = '';
open my $fd_gs, '<', 'blank217.pdf';
while (<$fd_gs>)
{ $pdfstring .= $_;
}
close $fd_gs;

my $gaseiten = 7;
my $deckblatt = 8;

my $out = $pdfstring;
use PDF::API2;
my $pdf = PDF::API2->openScalar ($pdfstring);
undef $pdfstring;
$pdf->preferences (-outlines => 1,
 ($gaseiten + ($deckblatt? 2: 0)) & 1? -twocolumnrigth:
 -twocolumnleft => 1);
my $outlines = $pdf->outlines ();
$outlines->open ();
if ($gaseiten)
{ my $ga = $outlines->outline ();
  $ga->title ('X');
  $ga->dest ($pdf->openpage (1), -fit => 1);
  if ($gaseiten > 1)
  { for (my $i = 1; $i <= $gaseiten; ++$i)
    { my $g = $ga->outline ();
      $g->dest ($pdf->openpage ($i), -fit => 1);
      $g->title ("p $i");
    }
  }
}
if ($deckblatt)
{ my $d = $outlines->outline ();
  $d->dest ($pdf->openpage ($deckblatt), -fit => 1);
  $d->title ('Y');
}

# Default-Sortierung
my $er = $outlines->outline ();
$er->dest ($pdf->openpage ($er[1]), -fit => 1);
$er->title ('Z');
for (my $i = 0; $i < @er;)
{ my $name = $er[$i++];
  my $seite = $er[$i++];
  my $e = $er->outline ();
  $e->dest ($pdf->openpage ($seite), -fit => 1);
  $e->title ("$name");
}

$out = $pdf->stringify ();
$pdf->end;

open my $pdf_out, '>', 'out.pdf';
print $pdf_out $out;
close $pdf_out;

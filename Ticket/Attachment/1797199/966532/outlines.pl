use warnings;
use strict;
use PDF::API2;

use Tie::IxHash;
tie my %pages, 'Tie::IxHash';

# Create a blank PLF file
my $pdf = PDF::API2->new(-file => 'test7.pdf');
$pdf->preferences(-outlines => 1, -fitwindow => 1);

my $content = $pdf->page(); #new page for ToC

#------- Don't call new from PDF::API2::Outline directly...
my $otls = $pdf->outlines();

# Add a built-in font to the PDF
my $font = $pdf->corefont('Helvetica-Bold');
my $pnum=1;

foreach my $section ( 1..3 ){
    my $otl = $otls->outline;
    $otl->title("Section $section");
    
    foreach my $pagenumber (1..4) {
        #add blank page...
        my $page = $pdf->page();
		$pages{"Hello world, s$section, p$pagenumber"}=++$pnum;
        
        # Set the page size
        $page->mediabox('Letter');
        my $text = $page->text();
        $text->translate(225,600);
        $text->font($font, 20);
        $text->text("Hello world, s$section, p$pagenumber");
        
        # add suboutline.
        my $sotl = $otl->outline();
        $sotl->title("Page $pagenumber");
        $sotl->dest($page);
    }
}

my $h = 752;
my $contentpage = $pdf->openpage(1);
my $txt  = $contentpage->text;
$txt->textlabel(20, $h, $pdf->corefont('Helvetica-Bold'), 14, "Content");
foreach my $section (keys %pages) {
	$h -= 20;
	$txt->textlabel(40, $h, $pdf->corefont('Helvetica'), 12, $section);
	$txt->textlabel(470, $h, $pdf->corefont('Helvetica'), 12, $pages{$section});
	my $annot = $contentpage->annotation;
	my $thispage = $pdf->openpage($pages{$section});
	$annot->link($thispage, 
				-rect   => [40, $h-2, 490, $h+12],
				-border => [1,1,1],
				-dest => $thispage,
				);
}
$pdf->save();
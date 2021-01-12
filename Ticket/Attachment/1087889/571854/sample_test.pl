    use lib qw(. lib);
    use PDF::API2;

    # Create a blank PDF file
    $pdf = PDF::API2->new();

    # Add a blank page
    $page = $pdf->page();

    # Retrieve an existing page
    $page = $pdf->openpage(1);

    # Set the page size
    $page->mediabox('Letter');

    my $f =  $pdf->ttfont('DejaVuSans.ttf', -encode=>'utf8', -dokern=>'1');

    my %text_options;
    $text_options{'-underline'} = 1;

    # Add some text to the page
    $text = $page->text();
    $text->font($f, 20);
    $text->translate(200, 200);
    $text->text('Hello World!', %text_options);

    # Save the PDF
    $pdf->saveas('new.pdf');

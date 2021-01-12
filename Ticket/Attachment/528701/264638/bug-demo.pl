#!/usr/bin/perl -w

use PDF::API2;
use strict;

gen_pdf("$0.pdf");

sub gen_pdf {
    my($save_as) =  @_;
    my $api = PDF::API2->new();
    my $uf = unifont($api, 'Times', 1);

    $api->mediabox(595,842);
    my $page = $api->page;

    my $text = $page->text;
    $text->font( $uf, 18 );
    $text->translate( 190, 400 );
    $text->paragraph("Centrum Us\x{0142}ug Ksi\x{0119}gowych", 220, 25);

    $api->saveas($save_as);
    $api->end;
}

sub unifont {
    my($api, $fontname, @blk) = @_;
    return $api->unifont(
        $api->corefont($fontname, -encode=>'latin1'),
        map([ $api->corefont($fontname, -encode=>"uni$_"), [$_] ], @blk ),
        -encode => 'latin1'
    );
}

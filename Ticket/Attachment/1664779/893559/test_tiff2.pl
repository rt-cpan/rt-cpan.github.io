
use strict;
use warnings;

use Image::Info qw(image_info dim);

my $file = 'D:\work\EP\sample\EVE0002.TIF';
my $info = image_info($file);
my $width       = $info->{width};
my $height      = $info->{height};
my $resolution  = $info->{resolution};
my $samples_per_pixal = $info->{SamplesPerPixel};
my $interlace   = $info->{Interlace};
my $compression = $info->{Compression};
my $gamma       = $info->{Gamma};
my $last_mod    = $info->{LastModificationTime};
my $bitspsample = $info->{BitsPerSample};
my $color_type  = $info->{color_type};

print "width = $width\theight = $height\tresolution = $resolution\n";
print "SamplesPerPixel = $samples_per_pixal\n";
print "Interlace = $interlace\n";
print "Compression = $compression\n";
print "Gamma =  $gamma\n";
print "LastModificationTime =  $last_mod \n";
print "BitsPerSample = $bitspsample\n";
print "color_type = $color_type\n";



__END__

D:\work\EP\perl\trunk\perl>perl test_tiff2.pl
Use of uninitialized value $resolution in concatenation (.) or string at test_tiff2.pl line 12.
width = 3246    height = 4223   resolution =

D:\work\EP\perl\trunk\perl>


cpan> i Bundle::Image::Info::Everything
Database was generated on Sun, 04 Sep 2016 01:15:55 GMT

Bundle id = Bundle::Image::Info::Everything
    CPAN_USERID  SREZIC (Slaven Rezic <slaven@rezic.de>)
    CPAN_VERSION 0.01
    CPAN_FILE    S/SR/SREZIC/Image-Info-1.38.tar.gz
    UPLOAD_DATE  2015-04-20
    MANPAGE      Bundle::Image::Info::Everything - complete support for Image::Info
    CONTAINS     Image::Info Compress::Zlib XML::LibXML::Reader XML::Simple Image::Xbm Image::Xpm
    INST_FILE    C:\Strawberry32\perl\site\lib\Bundle\Image\Info\Everything.pm
    INST_VERSION 0.01



cpan> i Image::Info::TIFF
Module id = Image::Info::TIFF
    CPAN_USERID  SREZIC (Slaven Rezic <slaven@rezic.de>)
    CPAN_VERSION 0.04
    CPAN_FILE    S/SR/SREZIC/Image-Info-1.38.tar.gz
    UPLOAD_DATE  2015-04-20
    MANPAGE      Image::Info::TIFF - TIFF support for Image::Info
    INST_FILE    C:\Strawberry32\perl\site\lib\Image\Info\TIFF.pm
    INST_VERSION 0.04



cpan>
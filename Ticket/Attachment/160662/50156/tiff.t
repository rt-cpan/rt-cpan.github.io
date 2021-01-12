use lib qw(./blib/lib);
use Image::Info qw(image_info dim);
use Test::Simple tests => 9;

## This TIFF file has 3 images, in 24-bit colour, 1-bit mono and 8-bit grey.
my @i = image_info("img/test.tif");
ok ( @i, 'image_info ran ok');
ok ( @i == 3, 'Right number of images found' );

## First image
ok ( scalar @{$i[0]->{BitsPerSample}} == 3 , 'Three lots of BitsPerSample for full-colour image' );
ok ( $i[0]->{SamplesPerPixel} == 3, 'SamplesPerPixel is 3 for full-colour image' );
ok ( $i[0]->{width} == 60 && $i[0]->{height} == 50, 'Dimensions right for full-colour image' );

## Second image
ok ( $i[1]->{BitsPerSample} == 1, 'BitsPerSample right for 1-bit image' );
ok ( $i[1]->{SamplesPerPixel} == 1, 'BitsPerSample right for 1-bit image' );
ok ( $i[1]->{Compression} eq 'CCITT T6', 'Compression right for 1-bit image' );

## Third image
ok ( $i[2]->{BitsPerSample} == 8 && $i[2]->{SamplesPerPixel} == 1, 'Bit depth right for greyscale image' );
ok ( dim($i[2]) eq '60x50' , 'dim() function right' );

1;


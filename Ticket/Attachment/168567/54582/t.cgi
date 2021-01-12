#!perl
#
#	Test case
#
	use GD;
	GD::Image->trueColor(1);

	my	$a = new GD::Image( 100, 100 );	#	First Image
	my	$b = new GD::Image( 100, 100 );	#	Second Image

	my	$fg_r = 253;	#	Foreground -> Red
	my	$fg_g = 245;	#	Foreground -> Green
	my	$fg_b = 230;	#	Foreground -> Blue
	my	$bg_r = 205;	#	Background -> Red
	my	$bg_g = 192;	#	Background -> Green
	my	$bg_b = 176;	#	Background -> Blue
	my	@ax = ();		#	Keep track of how many dots according to X
	my	@ay = ();		#	Keep track of how many dots according to Y

	$fc = $a->colorAllocate( 255, 255, 255 );			#	Transparent color
	$fg = $a->colorExact( $fg_r, $fg_b, $fg_b );		#	Foreground color
	$bg = $a->colorExact( $bg_r, $bg_b, $bg_b );		#	Background color

	$a->filledRectangle( 0, 0, 99, 99, $fg );
	for( $i=0; $i<500; $i++ ){
		$f = 1;
		while( $f > 0 ){
			$x = int(rand(100));
			$y = int(rand(100));

			if( ($ax[$x] > 10) || ($ay[$y] > 10) ){ $f = 1; }
				else{ $f = 0; }
			}

		$a->setPixel($x, $y, $bg);
		$ox = $x;
		$oy = $y;
		$ax[$x]++;
		$ay[$y]++;
		}

	open( OUTFILE, ">TestPic1.gif" ) || die $!;
	binmode OUTFILE;
	print OUTFILE $a->gif;
	close( OUTFILE );

	open( OUTFILE, ">TestPic1.png" ) || die $!;
	binmode OUTFILE;
	print OUTFILE $a->png;
	close( OUTFILE );

	$fg_r = int(($fg_r * 2) / 3);	#	Adjust the colors
	$fg_g = int(($fg_g * 2) / 3);	#	Adjust the colors
	$fg_b = int(($fg_b * 2) / 3);	#	Adjust the colors
	$bg_r = int(($bg_r * 2) / 3);	#	Adjust the colors
	$bg_g = int(($bg_g * 2) / 3);	#	Adjust the colors
	$bg_b = int(($bg_b * 2) / 3);	#	Adjust the colors

	$fc = $b->colorAllocate( 255, 255, 255 );			#	Transparent color
	$fg = $b->colorExact( $fg_r, $fg_b, $fg_b );		#	Foreground color
	$bg = $b->colorExact( $bg_r, $bg_b, $bg_b );		#	Background color

	$b->filledRectangle( 0, 0, 99, 99, $fg );
	for( $i=0; $i<500; $i++ ){
		$f = 1;
		while( $f > 0 ){
			$x = int(rand(100));
			$y = int(rand(100));

			if( ($ax[$x] > 10) || ($ay[$y] > 10) ){ $f = 1; }
				else{ $f = 0; }
			}

		$b->setPixel($x, $y, $bg);
		$ox = $x;
		$oy = $y;
		$ax[$x]++;
		$ay[$y]++;
		}

	open( OUTFILE, ">TestPic2.gif" ) || die $!;
	binmode OUTFILE;
	print OUTFILE $b->gif;
	close( OUTFILE );

	open( OUTFILE, ">TestPic2.png" ) || die $!;
	binmode OUTFILE;
	print OUTFILE $b->png;
	close( OUTFILE );

	exit( 0 );


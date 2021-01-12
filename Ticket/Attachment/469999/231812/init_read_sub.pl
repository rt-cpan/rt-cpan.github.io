sub _init_read_sub {
    my $self = shift;
    my $details = $self -> {'data'};
    my $channels = $details -> {'channels'};
    my $bits_sample = $details -> {'bits_sample'};
    my $sub;
    if ( $bits_sample <= 8 ) {                               # Data in .wav-files with <= 8 bits is
        my $offset = 1 << ($bits_sample - 1);                # unsigned, for >8 bits it's signed
        $sub = sub { return map $_ - $offset, unpack( 'C'.$channels, shift() ) };
    } elsif ($bits_sample == 16 ) {  # 16 bits could be handled by he general case below but might be faster like this
        if ( $self -> {'tools'} -> is_big_endian() ) {
            $sub = sub
                   { return unpack 's' . $channels,          # 3. unpack native as signed short
                            pack   'S' . $channels,          # 2. pack native unsigned short
                            unpack 'v' . $channels, shift()  # 1. unpack little-endian unsigned short
                   };
        } else {
            $sub = sub { return unpack( 's' . $channels, shift() ) };
        }
    } elsif ($bits_sample <= 32 ) {
        my $bytes  = $details -> {'block_align'} / $channels;
        my $fill   = 4 - $bytes;
        my $limit  = 2 ** ($bits_sample-1);
        my $offset = 2 **  $bits_sample;
    warn "b: $bytes, f: $fill";    
        $sub = sub 
               { return  map    {$_ & $limit  ?          # 4. If sign bit is set
                                 $_ - $offset : $_}      #    convert to negative number
                         unpack 'V*',                    # 3. unpack as little-endian unsigned long
                         pack   "(a${bytes}x${fill})*",  # 2. fill with \0 to 4-byte-blocks and repack
                         unpack "(a$bytes)*", shift()    # 1. unpack to elements sized "$bytes"-bytes
               };
    } else {
        $sub = sub {$self->_error("Elements have $bits_sample bits per sample. Unpacking elements containing more than 32 bits per sample is not supported!")}
    }
    $self -> {'read_sub'} = $sub;
}
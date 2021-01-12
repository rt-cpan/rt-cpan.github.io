     37 sub putLine
     38 {
     39     my $self  = shift;
     40     my @lines = @_;
     41 
     42     StdOut( '>>>>>>>>>>>>>>>>>>>>>' );
     43 
     44     foreach my $line (@lines)
     45     {
     46         my $err = 0;
     47         my $doc;
     48         unless ( $self->{inpacket} )
     49         {
     50             next if( 0 == length($line) );
     51             ++$self->{inpacket};
     52             $self->{curmsg} = [];
     53         }
     54 
     55         StdOutf( q{'%s'}, $line );
     56 
     57         try
     58         {
     59             push( @{ $self->{curmsg} }, $line );
     60             $self->{parser}->init_push();
     61             $self->{parser}->push( @{ $self->{curmsg} } );
     62             $doc = $self->{parser}->finish_push();
     63             if( defined( $doc ) )
     64             {
     65                 StdOutf( q{doc '%s' ok}, $doc->documentElement()->nodeName() ) ;
     66                 StdOut('-' x 60);
     67             }
     68             else
     69             {
     70                 $err = 1;
     71             }
     72         }
     73         catch
     74         { 
     75             $err = 1;
     76         };
     77 
     78         unless ($err)
     79         { 
     80             --$self->{inpacket};
     81             $self->parseDoc($doc) if ( defined($doc) );
     82         }
     83     }
     84 
     85     StdOut( '<<<<<<<<<<<<<<<<<<<<' );
     86 
     87     return;
     88 }

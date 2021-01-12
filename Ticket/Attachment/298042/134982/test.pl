#!/opt/bin/perl

package Foo;

# a class which should be restricted

{ 
    use Object::InsideOut qw( :Restricted );
    
    my @response :Field
                 :Arg( 'response' )
                 ;
    
    sub respond { 
        my ( $self ) = @_;
        
        print "Foo responds \"", $response[ $$self ], "\"\n";
        return scalar 1;
    }

}

package Bar;

# inherits from Foo and attempts to define an object of class Foo, failing...

{
    use Object::InsideOut qw( :Public Foo );
    
    my @question :Field
                 :Arg( 'question' )
                 ;
             
    
    sub ask { 
        my ( $self ) = @_;
        
        print "Bar asks \"", $question[ $$self ], "\"\n";
        
        my $temp_object = Foo->new( 'response' => 'kapow!' );
        $temp_object->respond;
        
        return scalar 1;
        
    }

}


package main;

my $thing = Bar->new( 'question' => 'say wha?' );

$thing->ask;



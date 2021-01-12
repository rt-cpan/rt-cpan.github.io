package Derp;
{
  use Object::InsideOut;
  
  sub say_derp
  {
    my ( $self ) = @_;
    
    print 
      "Derp isa: "
      . ( join q{ }, $self->isa() )
      . "\n"
    ;
    
    return;
  }
}


package Baz;
{
  use Object::InsideOut;
  
  sub say_baz :Restricted
  {
    my ( $self ) = @_;
    
    print 
      "Baz isa: "
      . ( join q{ }, $self->isa() )
      . "\n"
    ;
    
    return;
  }
}


package Bar;
{
  use Object::InsideOut;
  
  sub say_bar :Restricted
  {
    my ( $self ) = @_;
    
    print 
      "Bar isa: "
      . ( join q{ }, $self->isa() )
      . "\n"
    ;
    
    # THIS WORKS
    # Say hello from a public method in one of the other parents 
    # in the hierarchy
    $self->say_derp();
    
    # THIS FAILS
    # Say hello from a restricted method in one of the other parents 
    # in the hierarchy
    $self->say_baz();
  }
}


package Foo;
{
  use Object::InsideOut qw|
    Bar
    Baz
    Derp
  |;
  
  sub say_foo
  {
    my ( $self ) = @_;
    
    print 
      "Foo isa: "
      . ( join q{ }, $self->isa() )
      . "\n"
    ;
    
    # Say hello from a restricted method in one of our parents, Bar
    $self->say_bar();
    
    return;
  }
}


package main;

my $foo = Foo->new();

$foo->say_foo();

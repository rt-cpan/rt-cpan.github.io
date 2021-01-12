use 5.8.8;
use strict;
use Data::Dumper 2.121;
use Exception::Class  1.26 (
  'Ex::TestExceptionClass',
  'Ex::TestExceptionClass::Test1'      => { isa => 'Ex::TestExceptionClass' },
  'Ex::TestExceptionClass::Test2'      => { isa => 'Ex::TestExceptionClass' },
  'Ex::TestExceptionClass::Test2Sub'   => { isa => 'Ex::TestExceptionClass' },
  'Ex::TestExceptionClass::Test3'      => { isa => 'Ex::TestExceptionClass' },
  'Ex::TestExceptionClass::Test3::Ex1' => { isa => 'Ex::TestExceptionClass::Test3' },
  'Ex::TestExceptionClass::Test3::Ex2' => { isa => 'Ex::TestExceptionClass::Test3' },
  'Ex::TestExceptionClass::Test3::Ex3' => { isa => 'Ex::TestExceptionClass::Test3' }
);
use Exception::Class::TryCatch 1.12; 

# Declare prototypes.
sub Test1();
sub Test2Sub();
sub Test2();
sub Test3();
sub ExitProgram($);

print "$0 started.\n";

select STDERR; $| = 1;  # make unbuffered
select STDOUT; $| = 1;  # make unbuffered

# Initialize global variables.
my $TestNr = 0;

# ****************
$TestNr++;
print("$TestNr.) Simple try/throw/catch.\n"); 
print "\$@ = $@\n";  
try eval {
  throw Ex::TestExceptionClass 
    'Ex::TestExceptionClass thrown!';
}; 
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  print($Ex->message, "\n");
}
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  print("I would expect, that no exception was caught!\n");
  print("Is exception still on stack?\n");
  $@ = "";
} else {
  print("No exception on stack.\n");  
}
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  print("Is exception still on stack?\n");
} else {
  print("No, but \$@ must be reset, too.\n");  
}

# ****************
$TestNr++;
print("\n");
print("$TestNr.) Simple try/catch without throw.\n"); 
print "\$@ = $@\n";  
try eval {
  die("Just a simple die.");
}; 
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  print($Ex->message, "\n");
  if($Ex->isa('Exception::Class::Base')) {
    print("Why is a die() of class 'Exception::Class::Base'?\n");
    print("I would expect something like 'Exception::Die'!\n");
  } else {
    print("Something unexpected happened (maybe a die).\n");    
  }  
}
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  print("I would expect, that no exception was caught!\n");
  print("Is exception still on stack?\n");
  $@ = "";
} else {
  print("No exception on stack.\n");  
}
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  print("Is exception still on stack?\n");
} else {
  print("No, but \$@ must be reset, too.\n");  
}

# ****************
$TestNr++;
print("\n");
print("$TestNr.) throw in a subroutine caught outside.\n");
print "\$@ = $@\n";  
Test1();
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  if($Ex->isa('Ex::TestExceptionClass::Test1')) {
    print($Ex->message, "\n");
  } else {
    print("Unexpected exception!\n");
  }
}
$@ = "";

# ****************
$TestNr++;
print("\n");
print("$TestNr.) throw and rethrow in subroutines caught outside, if not caught inside.\n");
print "\$@ = $@\n";  
try eval { 
  Test2(); 
};
print "\$@ = $@\n";  
if(catch my $Ex) {
  print("Caught ", ref($Ex), "\n");
  if($Ex->isa('Ex::TestExceptionClass::Test2')) {
    print($Ex->message, "\n");
  } else {
    print("Unknown exception!\n");
    print($Ex->message, "\n");
  }
} else {
  print("No further exceptions.\n"); 
}
$@ = "";

# ****************
$TestNr++;
print("\n");
print("$TestNr.) 3 throws and a die in a subroutine, stack cleaned up outside.\n");
print "\$@ = $@\n";  
Test3();
print "\$@ = $@\n";  
if(catch my $Ex) {             # I miss a simple boolean function indicating,  
  try eval { $Ex->rethrow() }; # that's something on the exception stack!
  $@ = ""; # Required to avoid endless loop.
  while (catch my $Ex){
    print("Caught ", ref($Ex), "\n");
    if($Ex->isa('Ex::TestExceptionClass::Test3')) {
      print($Ex->message, "\n");
    } else {
      print("Unexpected exception!\n");
      print($Ex->message, "\n");
    }
  }  
  ExitProgram(-4);
}

ExitProgram(0);

sub Test1 () {
  print "Test1: \$@ = $@\n";  
  try eval {
    throw Ex::TestExceptionClass::Test1
      'Ex::TestExceptionClass::Test1 thrown!';
  }; 
  print "Test1: \$@ = $@\n";  
}

sub Test2Sub () {
  print "Test2Sub: \$@ = $@\n";  
  #try eval {
    throw Ex::TestExceptionClass::Test2Sub
      'Ex::TestExceptionClass::Test2Sub thrown!';
  #}; 
  print "Test2Sub: \$@ = $@\n";  
}

sub Test2 () {
  print "Test2: \$@ = $@\n";  
  try eval {
    Test2Sub();
    print "Test2: \$@ = $@\n";  
    throw Ex::TestExceptionClass::Test2
      'Ex::TestExceptionClass::Test2 thrown!';
  }; 
  print "Test2: \$@ = $@\n";  
  if(catch my $Ex) {
    print("Caught ", ref($Ex), "\n");
    if($Ex->isa('Ex::TestExceptionClass::Test2')) {
      print($Ex->message, "\n");
    } else {
      print("Unexpected exception!\n");
      print($Ex->message, "\n");
      $Ex->rethrow();
    }    
  }
  print "Test2: \$@ = $@\n";   
}

sub Test3 () {
  print "Test3: \$@ = $@\n";  
  try eval {
    throw Ex::TestExceptionClass::Test3::Ex1 
      'Ex::TestExceptionClass::Test3::Ex1 thrown!';
  }; 
  print "Test3: \$@ = $@\n";  
  try eval {
    throw Ex::TestExceptionClass::Test3::Ex2
      'Ex::TestExceptionClass::Test3::Ex2 thrown!';
  }; 
  print "Test3: \$@ = $@\n";  
  try eval {
    die "Died for some reason!";
  }; 
  print "Test3: \$@ = $@\n";  
  try eval {
    throw Ex::TestExceptionClass::Test3::Ex3
      'Ex::TestExceptionClass::Test3::Ex3 thrown!';
  }; 
  print "Test3: \$@ = $@\n";  
}

sub ExitProgram ($) {
  my $ExitCode = shift;
  
  if($ExitCode == 0) {
    print "$0 finished successfully.";
  } else {    
    print "$0 finished with exit code $ExitCode.";
  }   
  exit($ExitCode);
}

__END__;
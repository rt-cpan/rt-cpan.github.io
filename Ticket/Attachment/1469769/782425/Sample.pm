package Sample;

require DynaLoader;

#@INC = ('DynaLoader');
use base qw( DynaLoader );

bootstrap Sample;

print "howdy!\n";

1;

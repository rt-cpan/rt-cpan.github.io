use ExtUtils::MakeMaker;
                                                                                
require 5.006;

WriteMakefile
  ( NAME         => 'Geo::Proj4'
  , VERSION_FROM => 'lib/Geo/Proj4.pm'
  , AUTHOR       => 'Mark Overmeer, Schuyler Erle, Rich Gibson'
  , ABSTRACT     => 'Proj4 library for carthographic projections'
  , CCFLAGS      => "-IC:\\Dev\\AUSPOS\\src\\libs\\proj-4.5.0\\src"
  , LIBS         => [ "-lC:\\Dev\\AUSPOS\\src\\libs\\proj-4.5.0\\src\\proj" ]
  );

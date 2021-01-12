#!/usr/local/bin/perl -w

use lib qw(/export/home/mputcha/Archive-Tar-1.29);
use strict;
use LogUtil;
use Archive::Tar;
 


   my $tar = Archive::Tar->new;
  if( Archive::Tar->can_handle_compressed_files){
   $tar->read('x.gz',1);
   }
   else{
   print "CANT HANDLE\n";
   }

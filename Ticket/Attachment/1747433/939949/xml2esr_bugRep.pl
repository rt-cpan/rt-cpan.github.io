#!/usr/bin/perl

  	use XML::Parser;

	my $level; 
	my $row;
    
	my @path;
	
	my $parser = new XML::Parser 
	   ( Handlers => 
	      {   # Creates our parser object
				Start   => \&hdl_Start,
				End     => \&hdl_End,
				Char    => \&hdl_Char,
				Default => \&hdl_Default
	      }
	   );

	my $ret =$parser->parsefile($ARGV[0]);


sub hdl_Start
{  
	my( $pe, $elt) = @_;

	push(@path, $elt);

	$level++;                 
}	
sub hdl_End
{
	my( $pe, $elt)= @_;

	pop(@path);

	$level--;
}	

sub hdl_Char
{
	my( $pe, $elt) = @_;
	
	print join('/', @path). "\n";
#	print join('/', @path). "\t$elt\n";
}	

sub hdl_Default
{
#	my( $pe, $elt)= @_;

#print "--- $row hdl_Defaul!\n";t
}	


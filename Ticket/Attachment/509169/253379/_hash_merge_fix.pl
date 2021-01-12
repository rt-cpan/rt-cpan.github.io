#!/usr/bin/perl

use Data::Dumper;

my @hashes = (
	{},
	{ no_index => {} },
	{ no_index => {directory => [] } },
	{ no_index => {directory => [qw(t inc)] } },
	);	

foreach my $hash ( @hashes )
	{
	print "Started with: ------\n", Dumper( $hash );
	
	my $rc = main->_hash_merge( 
		$hash,
		no_index => { directory => [ qw(corpus) ] },
		);
		
	print "\nEnded with: ------\n", Dumper( $hash ), "\n===========\n";
	}





sub _hash_merge 
	{
    my ($self, $h, $k, $v) = @_;
 
	if (ref $h->{$k} eq 'ARRAY') 
    	{
        push @{$h->{$k}}, ref $v ? @$v : $v;
    	} 
    elsif (ref $h->{$k} eq 'HASH') 
    	{
    	foreach $vk ( keys %$v )
    		{
    		$self->_hash_merge( $h->{$k}, $vk, $v->{$vk});
    		}
       # $h->{$k}{$_} = $v->{$_} foreach keys %$v;
    	} 
    else 
    	{
        $h->{$k} = $v;
    	}
	}
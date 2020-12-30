#!perl

use strict;
use warnings;
use feature qw/ say /;

use Mojo::UserAgent;

my $base_url  = shift || die "usage: $0 <start_url> <max_depth> [-g]\n";
my $MAX_DEPTH = shift || 2;
my $GET_CHECK = shift || 0;
my $IGNORE    = 'NO_IGNORES';

my $start_url = $base_url;
$start_url =~ s/(.*\/).*\.s?html?$/$1/;

say $start_url;

get_links( $base_url,0 );

my ( %seen,@dead_links );

sub get_links {
	my ( $url,$depth ) = @_;

    my $ua  = Mojo::UserAgent->new->max_redirects( 0 );
	my $res;

	say "---> $url ($depth)" if $GET_CHECK;
    
	eval { $res = $ua->get( $url )->result };
	$@ && do { warn $@; return };

	if    ( $res->is_success )    { }
	elsif ( $res->is_error )      { push( @dead_links,$url ); return }
	elsif ( $res->code =~ /^30/ ) { say $res->headers->location; return }
	else                          { push( @dead_links,$url ); return }
 
	my @child_links;

	return if ++$depth > $MAX_DEPTH;

	for my $href ( $res->dom->find('a')->each ) {
    
		$url = $href->attr( 'href' );

		next if ! $url;
		next if $url !~ /$base_url|^\//;
		next if $url =~ /$IGNORE/;
		next if $seen{$url}++;

		my $check_url = $url =~ /$base_url/
			? "$url/" : "$base_url$url/";

		$check_url =~ s{//$}{/};
		push( @child_links,$check_url );
	}

	get_links( $_,$depth ) for @child_links;
	$depth--;
}

say "Finished\nReport for $start_url:";
say scalar( keys( %seen ) ) . " links found";
say scalar( @dead_links ) . " dead links:";
say $_ for ( @dead_links );

exit scalar( @dead_links );

# This test came about when I found out that Poco::Client::HTTP does not
# release file descriptors after an HTTPS fetch.
#
# So to test this, I measure the numbers of open file descriptors when
# starting, and then fetch a URL a number of times. The test passes if the
# number of FDs is the same after all the fetches are done. As a double check,
# I also measure the number of fds opened before starting the kernel, and when
# its done.
#
# You can configure which URLs to fetch, but I just picked one http and one
# https that prove the point.
#
# TODO: Replace the sub "count_fds" with a more platform neutral version. Right
# now, this function only works on platform with the /proc file system.

# Runtime config
our $debuglevel = 2; # 0 none, 1 info, 2 debug

my @urls = ( "www.bacus.pt", "chase.com" );

#Net::SSLeay::Handle->debug(100);
# End of config

use strict;
use warnings;

use Net::SSLeay::Handle qw/shutdown/;
use Symbol qw(gensym);


use Test::More;

plan tests => 1+@urls;


sub DEBUG(@) { $debuglevel >= 2 && print STDERR @_,"\n"; }
sub INFO(@) { $debuglevel >= 1 && print STDERR @_,"\n"; }

sub Net::SSLeay::Handle::DESTROY { warn "Handle $_[0] being destroyed.\n"; }
sub Net::SSLeay::Handle::UNTIE { warn "Handle $_[0] is untied.\n"; }

my $orig_fdcount = count_fds();
DEBUG "Orig fdcound: $orig_fdcount.";

for my $url ( @urls ) {
    DEBUG "Getting '$url'.";
    
    { 
	my ($host, $port) = ($url, 443);
	my $ssl = gensym();
	tie(*$ssl, "Net::SSLeay::Handle", $host, $port);
	print $ssl "GET / HTTP/1.0\r\n\r\n";
	shutdown($ssl,1);
    
	my @response = <$ssl>;
	#while (<$ssl>) { push @response, $_; }
	my $total_length = length(join('',@response));
	DEBUG shift @response;
	DEBUG "Total reponse length: $total_length.";
	#DEBUG "Response: ".join('',@response);
	#close $ssl;
    }

    # Handle should have been garbage collected
    my $newfdcount = count_fds();
    is($newfdcount, $orig_fdcount, "As many file descriptors as we started with.");
}


my $newfdcount = count_fds();
is($newfdcount, $orig_fdcount, "Final: As many file descriptors as we started with.");
DEBUG "fdcount: $orig_fdcount/$newfdcount.";

exit 0;

sub count_fds {
    use File::Spec;
    my $fdpath = File::Spec->devnull();
    open(F, $fdpath) or die "Can't open '$fdpath': $!\n";
    my $count = fileno(F);
    close(F);
    return $count;
}




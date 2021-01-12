package PAR::GTK2Kludge;

# This is a package implementing the fix discovered by Marc Lehmann. Thanks
# for sharing this solution; I would have never figured this out!
# The original can be found at: http://txt.schmorp.de/2629b6fdba568e7cda3ed953cbaf8613.txt

use strict;
use warnings;

our $VERSION = '0.20';

BEGIN {
	my $dbg; for(@ARGV){ $dbg++ if /^-d|^--debug/;}

	print "Running kludge\n" if $dbg;
	if (%PAR::LibCache) {
		print "kludging\n" if $dbg;
		@INC = grep ref, @INC; # weed out all paths except pars loader refs

			while (my ($filename, $zip) = each %PAR::LibCache) {
				for ($zip->memberNames) {
					next unless m!^root/(.*)!;
					print "zip: $_\n" if $dbg;
					$zip->extractMember ($_, "$ENV{PAR_TEMP}/$1")
						unless -e "$ENV{PAR_TEMP}/$1";
				}
			}

		if ($^O eq "MSWin32") {
			$ENV{GTK_RC_FILES} = "$ENV{PAR_TEMP}/share/themes/MS-Windows/gtk-2.0/gtkrc";
		}

		print "Inc:\n", join("\n",@INC),"\n" if $dbg;
		print "Temp:\n", $ENV{PAR_TEMP},"\n" if $dbg;
		print "Path:\n", $ENV{PATH},"\n" if $dbg;
		
		print "Chdir to $ENV{PAT_TEMP}\n" if $dbg;
		chdir $ENV{PAR_TEMP} if $ENV{PAR_TEMP};
	}
}

1;

__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

PACKAGE - Perl extension for blah blah blah

=head1 SYNOPSIS

  use PACKAGE;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for PACKAGE, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

mgrimes, E<lt>mgrimes at cpan dot org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by mgrimes

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.


=cut


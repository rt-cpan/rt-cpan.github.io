#!perl -w
use strict;
use warnings;
use MIME::Parser;

my $parser = MIME::Parser->new();
$parser->extract_nested_messages(1);
$parser->extract_uuencode(1);
$parser->output_to_core(1);
$parser->tmp_to_core(1);

my $entity = $parser->parse(\*STDIN);
if (!$entity) {
	die qq{Could not parse MIME: $!\n};
}

print_entity_structure( $entity, 0 );
exit(0);

sub print_entity_structure
{
	my ($in, $level) = @_;
	my ($type) = $in->mime_type;
	my @parts = $in->parts;
	$type =~ tr/A-Z/a-z/;
	my ($disposition) = $in->head->mime_attr("Content-Disposition");
	my ($body)        = $in->bodyhandle;

	my $fname = $in->head->recommended_filename() || '';

	$disposition = "inline" unless defined($disposition);

	print "    " x $level;
	if(!defined($body)) {
		print "non-leaf: type=$type; fname=$fname; disp=$disposition\n";
		map { print_entity_structure($_, $level + 1) } @parts;
	} else {
		print "leaf: type=$type; fname=$fname; disp=$disposition\n";
	}
}

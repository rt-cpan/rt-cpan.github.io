#!/usr/bin/perl
	use strict;
	use HTML::WikiConverter;

	my $MW_ROW_START = '|-';

	my $test_reg = '!\s+heading last col\s+'.quotemeta($MW_ROW_START).'\s+\|\s+data first col first row';

  	my $wc = new HTML::WikiConverter( dialect => 'MediaWiki' 
									, (  encoding => 'latin1')
									);

	my $html_table = join '',<DATA>;

	my	$wiki_table = $wc->html2wiki($html_table);
		
	print "wiki table result:\n";
	print $wiki_table;

	if ( $wiki_table =~ qr($test_reg)s) {
		print "\nPASS\nThere is '$MW_ROW_START' between 'heading last col' and 'data first col first row\n";
	}
	else {
		print "\nFAIL\nThere should be a '$MW_ROW_START' between 'heading last col' and 'data first col first row' to indicate the start of a new row\n";

	}

	

#####################
# table for testing	#
#####################
__DATA__
<table border="1">
	<colgroup>
		<col />
		<col />
		<col />
	</colgroup>
	<thead>
		<tr>
			<th>heading col 1</th>
			<th>heading col 2</th>
			<th>heading last col</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>data first col first row</td>
			<td>data c2 r1</td>
			<td>data c3 r1</td>
		</tr>
		<tr>
			<td>data c1 r2</td>
			<td>data c2 r2</td>
			<td>data c3 r2</td>
		</tr>
		<tr>
			<td>data c1 r3</td>
			<td>data c2 r3</td>
			<td>data c3 r3</td>
		</tr>
	</tbody>
</table>
	
#!perl

use Template;
use Data::Paginated;

my $list = [{ name => 'A1', type => 'A'} ];
my $page = Data::Paginated->new({
    entries => $list,
    entries_per_page => 5,
    current_page => 1,
	});		   
my $tt = Template->new;
$tt->process('test.tt', { pages => $page->page_data }) || die $tt->error;
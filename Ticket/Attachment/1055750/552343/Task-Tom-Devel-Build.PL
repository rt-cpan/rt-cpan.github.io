use 5.006;

use strict;
use warnings;

use Module::Build;
use Config;

(my $mbv = Module::Build->VERSION) =~ s/_//g;

my %args = (
    dist_author => 'Tom Wyant (wyant at cpan dot org)',
    dist_abstract => q{Tom Wyant's preferred modules for development},
    module_name => 'Task::Tom::Devel',
    build_requires => {
    },
    requires => {
	'Archive::Tar'		=> 0,
	'CPAN::Mini'		=> 0,
	'CPAN::Checksums'	=> 0,
	'Devel::Cover'		=> 0,
	'Devel::EnforceEncapsulation'	=> 0,
	'Devel::Hide'		=> 0,
	'ExtUtils::Manifest'	=> 0,
	'Module::Install'	=> 0,
	'Perl::Critic'		=> 0,
	'Perl::Critic::More'	=> 0,
	'Perl::Tidy'		=> 0,
	'Pod::Spell'		=> 0,
	'Readonly::XS'		=> 0,
	'Test::CPAN::Changes'	=> 0,
	'Test::Kwalitee'	=> 0,
	'Test::Memory::Cycle'	=> 0,
	'Test::MockTime'	=> 0,
	'Test::More'		=> 0,
	'Test::Perl::Critic'	=> 0,
	'Test::Pod'		=> 0,
	'Test::Pod::Coverage'	=> 0,
	'Test::Spelling'	=> 0,
	'Test::Without::Module'	=> 0,
##	'warnings::unused'	=> 0,
    },
#   dynamic_config => 1,
    license => 'perl',
);

$mbv >= 0.28 and $args{meta_merge} = {
    no_index => {
	directory => [qw{inc t}],
    },
    resources => {
	bugtracker => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Encode-RAD50',
    },
};

my $bldr = Module::Build->new(%args);

$bldr->create_build_script ();

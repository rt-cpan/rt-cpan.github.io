use 5.005; #by perlver - uses base.pm
use ExtUtils::MakeMaker;

my %opts = (
    'NAME'	   => 'Pod::POM',
    'VERSION_FROM' => 'lib/Pod/POM.pm',
    'EXE_FILES'    => [ 'bin/pom2', 'bin/podlint' ],
    'dist'         => {
	'COMPRESS' => 'gzip',
	'SUFFIX'   => 'gz',
    },
);

if ($ExtUtils::MakeMaker::VERSION >= 5.43) {
    $opts{ AUTHOR }   = 'Andy Wardley <abw@kfs.org>';
    $opts{ ABSTRACT } = 'POD Object Model',
}

if ($ExtUtils::MakeMaker::VERSION >= 6.48) {
    $opts{ MIN_PERL_VERSION }   = '5.005';
}

if ($ExtUtils::MakeMaker::VERSION >= 6.31) {
    $opts{ LICENSE }   = 'perl';
}

WriteMakefile( %opts );

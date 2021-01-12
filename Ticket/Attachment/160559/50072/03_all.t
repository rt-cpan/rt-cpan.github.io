#!/usr/bin/perl -w

# Main testing for Params::Util

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), 'lib' ) );
	}
}

use Test::More tests => 16;
use_ok( 'Params::Util', ':ALL' );





#####################################################################
# Is everything imported

ok( defined *_IDENTIFIER{CODE}, '_IDENTIFIER imported ok' );
ok( defined *_CLASS{CODE},      '_CLASS imported ok'      );
ok( defined *_SCALAR{CODE},     '_SCALAR imported ok'     );
ok( defined *_POSINT{CODE},     '_POSINT imported ok'     );
ok( defined *_NUMBER{CODE},     '_NUMBER imported ok'     );
ok( defined *_SCALAR0{CODE},    '_SCALAR0 imported ok'    );
ok( defined *_ARRAY{CODE},      '_ARRAY imported ok'      );
ok( defined *_ARRAY0{CODE},     '_ARRAY0 imported ok'     );
ok( defined *_HASH{CODE},       '_HASH imported ok'       );
ok( defined *_HASH0{CODE},      '_HASH0 imported ok'      );
ok( defined *_CODE{CODE},       '_CODE imported ok'       );
ok( defined *_CALLABLE{CODE},   '_CALLABLE imported ok'   );
ok( defined *_INSTANCE{CODE},   '_INSTANCE imported ok'   );
ok( defined *_SET{CODE},        '_SET imported ok'        );
ok( defined *_SET0{CODE},       '_SET0 imported ok'       );

1;

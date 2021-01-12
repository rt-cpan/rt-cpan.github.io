package Class::Accessor;
sub empty {}
1;

package Fixture;
use base 'Class::C3';
use base 'Class::Accessor';
sub update_all { 
	# This is the only one that gets called.
	# It should be called third.
	print __PACKAGE__ . " called for update_all\n\n"; 
}

1;

package Fixture::Scenario;
use base 'Fixture';

1;

package Fixture::HasKnowledgeBase;
use base 'Fixture';

1;

package Fixture::OneQNodeScenario;
use base 'Fixture::HasKnowledgeBase';
use base 'Fixture::Scenario';
sub update_all { 
	# We'd expect this to be called second, but it isn't
	print __PACKAGE__ . " called for update_all\n\n"; 
	shift->next::method; 
}

1;

package Fixture::HasKBSet;
use base 'Fixture::HasKnowledgeBase';

1;

package Fixture::HasStudent;
use base 'Fixture::HasKBSet';

1;

package Fixture::HasAssignment;
use base 'Fixture::HasKBSet';

1;

package Fixture::HasAssignmentInstance;
use base 'Fixture::HasAssignment';
use base 'Fixture::HasStudent';

1;

package Fixture::HasSubmission;
use base 'Fixture::HasAssignmentInstance';
use base 'Fixture::HasStudent';

1;

package Fixture::HasEntry;
use base 'Fixture::HasSubmission';
use base 'Fixture::OneQNodeScenario';

1;

package Fixture::TwoQNodeScenario;
use base 'Fixture::OneQNodeScenario';

1;

package Fixture::Scenario::MeadsStages;
use base 'Fixture::TwoQNodeScenario';
use base 'Fixture::HasEntry';
sub update_all { 
	# We'd expect this to be called first, but it isn't
	print __PACKAGE__ . " called for update_all\n\n"; 
	shift->next::method; 
}

1;

package Fixture::ThreeQNodeScenario;
use base 'Fixture::TwoQNodeScenario';

1;

package Fixture::Scenario::Theories;
use base 'Fixture::ThreeQNodeScenario';
use base 'Fixture::Scenario::MeadsStages';

1;

package Test::Class;

1;

package TestFixture;
use base 'Test::Class';
use base 'Fixture';


1;
package Test::Recognition;
use base 'TestFixture';
use base 'Fixture::Scenario::Theories';

1;

my $obj = new Test::Recognition;
$obj->update_all;

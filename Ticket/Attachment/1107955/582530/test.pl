use lib '.';
use BISAO_Health_Care_Professional;
use SOAP::Lite qw( debug );

my $f = BISAO_Health_Care_Professional->new();
$f->readable(1);
$f->want_som(1);

my $som = $f->Query( SOAP::Data->name('HealthCareProfessionals')->value('Contact') );
#my $som = $f->HealthCareProfessionals();

die $som->fault->{faultstring} if ( $som->fault );
print $som->result, "\n";


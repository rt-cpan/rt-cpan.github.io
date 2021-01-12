package Example::Controller::Example;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::SOAP'; }

__PACKAGE__->config->{wsdl} = 'WSDL/example.wsdl';

sub Test : WSDLPort('Example')
{
    my ($self, $c, $args) = @_;
	use Data::Dumper;
	$c->log->debug(Dumper($args));
}

__PACKAGE__->meta->make_immutable;


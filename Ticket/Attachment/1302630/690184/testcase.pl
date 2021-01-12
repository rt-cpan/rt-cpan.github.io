#!/usr/bin/perl -w
use strict;
use warnings;

BEGIN {
  $XML::SAX::ParserPackage = "XML::LibXML::SAX";
}

use XML::SAX::ParserFactory;

my $metadataHandler = innerSAX->new();
my $oaiHandler = outerSAX->new(metadataHandler => $metadataHandler,
                               oaiNS => "http://www.openarchives.org/OAI/2.0/");

my $parser = XML::SAX::ParserFactory->parser(Handler => $oaiHandler);

$parser->parse_file("test.rdf");


package outerSAX;
use base qw(XML::SAX::Base);

sub new {
  my ($class, %opts) = @_;
  my $self = bless \%opts, ref($class) || $class;
  $self->set_handler( undef );
  return $self;
}

sub start_element {
  my ($self, $element) = @_;

  return $self->SUPER::start_element($element) unless $element->{NamespaceURI} eq $self->{oaiNS};

  if ( $element->{LocalName} eq 'metadata' ) {
      $self->{ OLD_Handler } = $self->get_handler();
      $self->set_handler( $self->{metadataHandler} );
    }
  else {
      return $self->SUPER::start_element($element)};
}

sub end_element {
  my ($self, $element) = @_;

  return $self->SUPER::end_element($element) unless $element->{NamespaceURI} eq $self->{oaiNS};

  if ( $element->{LocalName} eq 'metadata' ) {
      $self->set_handler( $self->{OLD_Handler} );
    }
  else {
      $self->SUPER::end_element($element);
    }
}


package innerSAX;
use base qw(XML::SAX::Base);
use XML::LibXML::SAX::Builder;

sub new {
  my ($class, %opts) = @_;
  my $self = bless \%opts, ref($class) || $class;
  $self->{'tagStack'} = [];
  return $self;
}

sub start_element {
  my ($self, $element) = @_;

  unless ( $self->{'tagStack'}[0] ) {
      my $builder = XML::LibXML::SAX::Builder->new() or die "cannot instantiate SAX builder";
      $self->set_handler($builder);
      $self->SUPER::start_document(); # i.e. $builder->start_document();
# DEBUG ME: warnings occur here 
      $self->SUPER::start_element($element);
    }
  else {
      $self->SUPER::start_element($element)};

  push(@{$self->{'tagStack'}}, $element->{Name});
}

sub end_element {
  my ($self, $element) = @_;
  $self->SUPER::end_element($element);
  pop (@{$self->{'tagStack'}});

  unless ( $self->{'tagStack'}[0] ) {
      my $hdl = $self->get_handler();
      $self->set_handler(undef);

# convert fragment to document, do something with it (in real life: XSLT)
      my $fragment = $hdl->done();
      my $child = $fragment->firstChild();
      $child = $child->nextSibling while $child && $child->nodeName eq "#text";
      my $tempdoc = XML::LibXML::Document->createDocument() or die "cannot create new Document";
      $tempdoc->addChild($child) or die "cannot addChild";
      print $tempdoc->toString;

    }
}

1;


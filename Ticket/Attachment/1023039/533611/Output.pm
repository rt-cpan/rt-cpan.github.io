package Siebel::Srvrmgr::ListParser::Output;
use Moose;

use MooseX::Storage;
use namespace::autoclean;

with Storage( io => 'StorableFile' );

has 'data_type' =>
  ( is => 'ro', isa => 'Str', reader => 'get_data_type', required => 1 );

has 'raw_data' => (
    is       => 'rw',
    isa      => 'ArrayRef',
    reader   => 'get_raw_data',
    writer   => 'set_raw_data',
    required => 1
);
has 'data_parsed' => (
    is     => 'rw',
    isa    => 'HashRef',
    reader => 'get_data_parsed',
    writer => 'set_data_parsed'
);
has 'cmd_line' =>
  ( isa => 'Str', is => 'ro', reader => 'get_cmd_line', required => 1 );

no Moose;
__PACKAGE__->meta->make_immutable;


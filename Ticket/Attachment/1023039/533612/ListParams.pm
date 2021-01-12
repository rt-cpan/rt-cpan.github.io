package Siebel::Srvrmgr::ListParser::Output::ListParams;
use Moose;
use namespace::autoclean;

extends 'Siebel::Srvrmgr::ListParser::Output';

has 'comp_params' => (
    is     => 'rw',
    isa    => 'ArrayRef',
    reader => 'get_comp_params',
    writer => 'set_comp_params'
);

has 'fields_pattern' => (
    is     => 'rw',
    isa    => 'Str',
    reader => 'get_fields_pattern',
    writer => 'set_fields_pattern'
);

has server =>
  ( isa => 'Str', is => 'ro', writer => '_set_server', reader => 'get_server' );

has comp_alias => (
    isa    => 'Str',
    is     => 'ro',
    writer => '_set_comp_alias',
    reader => 'get_comp_alias'
);

# for POD,  this is the list configuration considered by the module
#srvrmgr> configure list params
#        PA_ALIAS (31):  Parameter alias
#        PA_VALUE (101):  Parameter value
#        PA_DATATYPE (31):  Parameter value datatype
#        PA_SCOPE (31):  Parameter level
#        PA_SUBSYSTEM (31):  Parameter subsystem
#        PA_SETLEVEL (31):  Internal level at which value was set
#        PA_DISP_SETLEVEL (61):  Display level at which value was set (translatable)
#        PA_NAME (76):  Parameter name
#
# Data extructure return
#                 'data_parsed' => {
#                                    'Parameter' => {
#                                                     'PA_NAME' => 'Private key file name',
#                                                     'PA_DATATYPE' => 'String',
#                                                     'PA_SCOPE' => 'Subsystem',
#                                                     'PA_VALUE' => '',
#                                                     'PA_ALIAS' => 'KeyFileName',
#                                                     'PA_SETLEVEL' => 'SIS_NEVER_SET',
#                                                     'PA_DISP_SETLEVEL' => 'SIS_NEVER_SET',
#                                                     'PA_SUBSYSTEM' => 'Networking'
#                                                   },
#

sub set_details {

    my $self = shift;

    if ( defined( $self->get_cmd_line() ) ) {

        #list params for server SERVERNAME component COMPONENT_ALIAS
        my @values = split( /\s/, $self->get_cmd_line() );

        if ( ( scalar(@values) ) == 7 ) {

            $self->_set_server( $values[4] );
            $self->_set_comp_alias( $values[6] );

        }

    }

    return 1;

}

sub BUILD {

    my $self = shift;

    $self->parse();
    $self->set_details();

}

sub parse {

    my $self = shift;

    my $data_ref = $self->get_raw_data();

    my %parsed_lines;

# removing the three last lines Siebel 7.5.3 (one blank line followed by a line amount of lines returned followed by a blank line)
    for ( 1 .. 3 ) {

        pop( @{$data_ref} );

    }

    foreach my $line ( @{$data_ref} ) {

        chomp($line);

      SWITCH: {

            if ( $line =~ /^\-+\s/ ) {    # this is the header line

                my @columns = split( /\s{2}/, $line );

                my $pattern;

                foreach my $column (@columns) {

                    $pattern .= 'A'
                      . ( length($column) + 2 )
                      ; # + 2 because of the spaces after the "---" that will be trimmed

                }

                $self->set_fields_pattern($pattern);

                last SWITCH;

            }

            if ( $line eq '' ) {

                last SWITCH;

            }

            #SV_NAME     CC_ALIAS
            if ( $line =~ /^PA_ALIAS\s.*\sPA_NAME/ ) {    # this is the header

                my @columns = split( /\s{2,}/, $line );

                $self->set_comp_params( \@columns );

                last SWITCH;

            }
            else {

                my @fields_values =
                  unpack( $self->get_fields_pattern(), $line );

                if (@fields_values) {

                    my $pa_alias    = $fields_values[0];
                    my $list_len    = scalar(@fields_values);
                    my $columns_ref = $self->get_comp_params();

                    for ( my $i = 1 ; $i < $list_len ; $i++ )
                    {    # starting from 1 to skip the field PA_ALIAS

                        $parsed_lines{$pa_alias}->{ $columns_ref->[$i] } =
                          $fields_values[$i];

                    }

                }
                else {

                    warn "got nothing\n";

                }

            }

        }

    }

    $self->set_data_parsed( \%parsed_lines );
    $self->set_raw_data( [] );

}

no Moose;
__PACKAGE__->meta->make_immutable;

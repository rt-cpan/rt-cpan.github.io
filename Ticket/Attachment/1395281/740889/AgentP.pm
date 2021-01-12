      package AgentP;
      use base 'LWP::UserAgent';
      sub _agent       { "Mozilla/8.0" }
      sub get_basic_credentials {
            my ($self, $realm, $uri) = @_;
  print( STDERR "  - providing auth to realm \"$realm\"\n" );
          return 'admin', 'password';
      }

1
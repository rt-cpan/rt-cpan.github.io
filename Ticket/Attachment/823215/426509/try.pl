  use Win32::File::VersionInfo;
  my $foo = GetFileVersionInfo ( "c:\\WINDOWS\\system32\\kernel32.dll" );
  if ( $foo ) {
        print $foo->{FileVersion}, "\n";
        my $lang = ( keys %{$foo->{Lang}} )[0] ;
        if ( $lang ) {
                print $foo->{Lang}{$lang}{CompanyName}, "\n";
        }
  }

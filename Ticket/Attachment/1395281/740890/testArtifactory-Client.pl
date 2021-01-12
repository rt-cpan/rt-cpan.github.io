    use Artifactory::Client;
    use autodie;
    use Data::Printer;
    use AgentP;
    my $ua=AgentP->new();
    my $args = {
        artifactory => 'http://localhost',
        port => 8081,
        repository => 'dave-snapshot-local/',
        ua =>$ua 
    };
p $ua;
    my $client = Artifactory::Client->new( $args );
p $client;
    my $path = 'test/foo'; # path on artifactory

    # Properties are a hashref of key-arrayref pairs.  Note that value must be an arrayref even for a single element.
    # This is to conform with Artifactory which treats property values as a list.
    my $properties = {
        one => ['two'],
        baz => ['three'],
    };

    use File::Spec;
    my $file=File::Spec->rel2abs( __FILE__ );
    #my $file = 'D:\\working\\perl\\testArtifactory-Client.pl';
p $file;
$filesize=-s $file;
p $filesize;
    # Name of methods are taken straight from Artifactory REST API documentation.  'Deploy Artifact' would map to
    # deploy_artifact method, like below.  The caller gets HTTP::Response object back.
    my $resp = $client->deploy_artifact( path => $path, properties => $properties, file => $file );
p $resp;

    # Custom requests can also be made via usual get / post / put / delete requests.
    my $resp = $client->get( 'http://localhost:8081/artifactory/dave-snapshot-local/test/foo' );
    p $resp;

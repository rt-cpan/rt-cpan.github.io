#!/usr/bin/perl

use Socket::Class      ();
use Socket::Class::SSL ();
use IO::Select         ();

my $pem = '-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQC5hCJbBaDK3vhJN51DaVwUdUQkb7fnbYV36F1cYSQ0XcuUhWSb
wB1Kq9BKzuYW/qaIIH08n9W41GMbQcZGLGe6pn0eZsvv/TrXLV8a2Yf6QzWw4ufH
aJc1NLDvq8P2N0jxhiWmGf1u5ZJw6nGShqbrNEnB5WJZDvmdMgzGp6G7DwIDAQAB
AoGBAJsmsPzi9hj05T2Gr5WjVgkeEcFPVcTNSeSAhyQtcfQBxbMO5JeF0nmSu/70
jmYIzwnl8hdzrXCI3+H53nLtzElXPM8FJ10SOAsklHZexjvV3fCC3U7Qo5su2R1e
cKsRfNYx3X++kODuKGHzOi+fi9V0hiZtHgs3s9Lb4Gr2VKoRAkEA3sBUz70DEkBd
UHfCh1kRRph4yUtytx9EETaewQ5kc94QHHuUk8G61zlBoItbPU+bQAJGzwap0PNe
EJCqLe6ctQJBANU0/asX/q/mALPZqjE5XpzbXY4d8ZdKxJjLaEzjBHSyw4bGAD4W
Q/k7E7b8r/M5wGdipBvSFbCvS2qE2c/bVzMCQQCu5u/xKeV2eEmM/GwnIF17RA9b
Zz2M4iTtKykeR3HCtPOLmdGA71YI1nFcYO/kRVSOvvrgZcgDRIRwl1a4uCodAkEA
y8T1nIw2Uo8UpM+npZwbHPdblvRvbhV7iDz/1lwyagZgcXLT0IMfPBiGYyFmWKQd
i7Hu/tfu+wrOnWOTeOE9mQJAQaMngYlDh0SLABUiMk6MuBtZArrCL735ostnWnpf
efsi37gWPlbX0Yy+4HyDPIcFpXJ46cZecFVlOq2NZSSEAg==
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
MIIDRTCCAq6gAwIBAgIBADANBgkqhkiG9w0BAQQFADB7MQswCQYDVQQGEwJVUzEQ
MA4GA1UECBMHVW5rbm93bjEQMA4GA1UEBxMHVW5rbm93bjEQMA4GA1UEChMHVW5r
bm93bjEQMA4GA1UECxMHVW5rbm93bjEMMAoGA1UEAxMDcGlnMRYwFAYJKoZIhvcN
AQkBFgdzc2xAcGlnMB4XDTA4MTIyNDAzNDE0NFoXDTA5MTIyNDAzNDE0NFowezEL
MAkGA1UEBhMCVVMxEDAOBgNVBAgTB1Vua25vd24xEDAOBgNVBAcTB1Vua25vd24x
EDAOBgNVBAoTB1Vua25vd24xEDAOBgNVBAsTB1Vua25vd24xDDAKBgNVBAMTA3Bp
ZzEWMBQGCSqGSIb3DQEJARYHc3NsQHBpZzCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAuYQiWwWgyt74STedQ2lcFHVEJG+3522Fd+hdXGEkNF3LlIVkm8AdSqvQ
Ss7mFv6miCB9PJ/VuNRjG0HGRixnuqZ9HmbL7/061y1fGtmH+kM1sOLnx2iXNTSw
76vD9jdI8YYlphn9buWScOpxkoam6zRJweViWQ75nTIMxqehuw8CAwEAAaOB2DCB
1TAdBgNVHQ4EFgQUQRmLH9Vlf7Ts39g1omt38SEf3wowgaUGA1UdIwSBnTCBmoAU
QRmLH9Vlf7Ts39g1omt38SEf3wqhf6R9MHsxCzAJBgNVBAYTAlVTMRAwDgYDVQQI
EwdVbmtub3duMRAwDgYDVQQHEwdVbmtub3duMRAwDgYDVQQKEwdVbmtub3duMRAw
DgYDVQQLEwdVbmtub3duMQwwCgYDVQQDEwNwaWcxFjAUBgkqhkiG9w0BCQEWB3Nz
bEBwaWeCAQAwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQBqpceFZCqa
c2g3sjstCfDPm3PESyiPNvN152+GLuwiyu0X0KXUNzqAbQbvQ1hABjQBDWbV0hw7
tDgd0FNDIxw4+X8N4e9UVHuYlXCF4G5nLuKm5GJyHnfNCZLHdG8dNUHFwG0MN8+Q
ET5BUqESHHx8ODIGnoUK6wWamINhU/Uiig==
-----END CERTIFICATE-----';

my $homedir = ( getpwuid($>) )[7];
if ( open( my $pem_fh, '>', $homedir . '/mypem_ssl_test.pem' ) ) {
    print {$pem_fh} $pem;
    close($pem_fh);
}

my %SSLARGS = (
    'private_key' => $homedir . '/mypem_ssl_test.pem',
    'certificate' => $homedir . '/mypem_ssl_test.pem',

    #'SSL_cipher_list' => 'ALL:!ADH:+HIGH:+MEDIUM:-LOW:-SSLv2:-EXP'
);

my $port = 10001;
my %ARGS = (
    'listen'     => '45',
    'proto'      => 'tcp',
    'local_port' => $port,
    'reuseaddr'  => '1',
);
my $fd = Socket::Class::SSL->new( %ARGS, %SSLARGS );
while (1) {
    $socket = $fd->accept() || next;
    if ( fork() ) {
        $socket->close();

        #parent
    }
    else {
        $socket->read( $constring, 2 );
        $socket->write("SSL SERVER CONNETED OK\n");
        exit();
    }
}

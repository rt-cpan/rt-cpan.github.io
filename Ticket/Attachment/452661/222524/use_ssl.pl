use Test::More tests => 8;
use Net::Clickatell;

use strict;


my $api_id = 'abc123';
my $username = 'user';
my $password = 'pass';

my $clickatell;


$clickatell = Net::Clickatell->new( 
                                   API_ID => $api_id, 
                                   USERNAME =>$username, 
                                   PASSWORD =>$password 
                                  );
is ($clickatell->{USE_SSL}, 1, 'UseSSL = 1');
is ($clickatell->{BASE_URL}, 'https://api.clickatell.com/', 'https base URL correct');
$clickatell = undef;

$clickatell = Net::Clickatell->new(
                                   UseSSL=>0, 
                                   API_ID => $api_id, 
                                   USERNAME =>$username, 
                                   PASSWORD =>$password 
                                  );
is ($clickatell->{USE_SSL}, 0, 'UseSSL = 0');
is ($clickatell->{BASE_URL}, 'http://api.clickatell.com/', 'http base URL correct');
$clickatell = undef;

#use an alternative base url
$clickatell = Net::Clickatell->new( 
                                   API_ID => $api_id, 
                                   BaseURL=>'api.alternative.com/', 
                                   USERNAME =>$username, 
                                   PASSWORD =>$password 
                                  );
is ($clickatell->{USE_SSL}, 1, 'UseSSL = 1');
is ($clickatell->{BASE_URL}, 'https://api.alternative.com/', 'alternative https base URL correct');
$clickatell = undef;

#use an alternative url with no ssl
$clickatell = Net::Clickatell->new( 
                                   UseSSL=>0, 
                                   API_ID => $api_id, 
                                   BaseURL=>'api.alternative.com/', 
                                   USERNAME =>$username, 
                                   PASSWORD =>$password
                                  );
is ($clickatell->{USE_SSL}, 0, 'UseSSL = 0');
is ($clickatell->{BASE_URL}, 'http://api.alternative.com/', 'alternative http base URL correct');
$clickatell = undef;


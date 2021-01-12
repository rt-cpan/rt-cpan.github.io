use Test::More tests => 136;
use Net::Clickatell;
use URI::Escape qw(uri_escape);

use strict;


#
# test file produced by Ian Clark
# http://www.abc-rallying.co.uk/perl
#


my $api_id = 'abc123';
my $username = 'user';
my $password = 'pass';

my $msidn = '0192834';
my $apimsgid = 'AJFDHUIEW3FJAF943RAJ';
my $to = '07999999999';
my $from = '07888888888';
my $text = 'sample text message';
my $expected_text = 'sample+text+message';
my $mms_expire = 'expire';
my $mms_url = 'http://www.cpan.org/mms';
my $tranid = '';
my $sess_id = '94950f7628a2d931845afe29e6eece17';

my $response;
my $response2;

my $clickatell;


#check that the methods return undefined if 
#they are called in a procedural context
$clickatell = Net::Clickatell::new();
ok(!defined($clickatell), 'new undefined');
$clickatell = Net::Clickatell::getStatusDetail();
ok(!defined($clickatell), 'getStatusDetail undefined');
$clickatell = Net::Clickatell::getStatus();
ok(!defined($clickatell), 'getStatus undefined');
$clickatell = Net::Clickatell::authentication();
ok(!defined($clickatell), 'authentication undefined');
$clickatell = Net::Clickatell::ping();
ok(!defined($clickatell), 'ping undefined');
$clickatell = Net::Clickatell::connect();
ok(!defined($clickatell), 'connect undefined');
$clickatell = Net::Clickatell::getBalance();
ok(!defined($clickatell), 'getBalance undefined');
$clickatell = Net::Clickatell::checkCoverage();
ok(!defined($clickatell), 'checkCoverage undefined');
$clickatell = Net::Clickatell::getQuery();
ok(!defined($clickatell), 'getQuery undefined');
$clickatell = Net::Clickatell::getMessageCharge();
ok(!defined($clickatell), 'getMessageCharge undefined');
$clickatell = Net::Clickatell::sendBasicSMSMessage();
ok(!defined($clickatell), 'sendBasicSMSMessage undefined');
$clickatell = Net::Clickatell::sendMMNotification();
ok(!defined($clickatell), 'sendMMNotification undefined');
$clickatell = Net::Clickatell::sendWAPPush();
ok(!defined($clickatell), 'sendWAPPush undefined');
$clickatell = Net::Clickatell::sendSIWAPPush();
ok(!defined($clickatell), 'sendSIWAPPush undefined');



#check for common initialisation failures
$clickatell = Net::Clickatell->new( USERNAME =>$username, PASSWORD =>$password );
ok (!defined($clickatell), 'clickatell object NOT initiated - no API id');
$clickatell = Net::Clickatell->new( API_ID => $api_id, PASSWORD =>$password );
ok (!defined($clickatell), 'clickatell object NOT initiated - no username');
$clickatell = Net::Clickatell->new( API_ID => $api_id, USERNAME =>$username );
ok (!defined($clickatell), 'clickatell object NOT initiated - no password');


#check that the attributes are set correctly using defaults
$clickatell = Net::Clickatell->new( API_ID => $api_id, USERNAME =>$username, PASSWORD =>$password );
ok (defined($clickatell), 'clickatell object initiated with default SSL');
is ($clickatell->{USE_SSL}, 1, 'UseSSL = true');
is ($clickatell->{API_ID}, $api_id, 'API ID correct');
is ($clickatell->{USERNAME}, $username, 'Username correct');
is ($clickatell->{PASSWORD}, $password, 'Password correct');
is ($clickatell->{BASE_URL}, 'https://api.clickatell.com/', 'base URL correct');
is ($clickatell->{USER_AGENT}, 'Clickatell.pm/0.1', 'user agent correct');

#use an alternative base url
$clickatell = Net::Clickatell->new( API_ID => $api_id, BaseURL=>'api.alternative.com/', USERNAME =>$username, PASSWORD =>$password );
is ($clickatell->{BASE_URL}, 'https://api.alternative.com/', 'alternative https base URL correct');

#use an alternative url with no ssl
$clickatell = Net::Clickatell->new( UseSSL=>0, API_ID => $api_id, BaseURL=>'api.alternative.com/', USERNAME =>$username, PASSWORD =>$password );
is ($clickatell->{BASE_URL}, 'http://api.alternative.com/', 'alternative http base URL correct');

#change the user agent
$clickatell = Net::Clickatell->new( UseSSL=>'true', UserAgent=>'test agent', API_ID => $api_id, USERNAME =>$username, PASSWORD =>$password );
ok (defined($clickatell), 'clickatell object initiated with SSL bad value');
is ($clickatell->{USE_SSL}, 1, 'UseSSL = true');
is ($clickatell->{BASE_URL}, 'https://api.clickatell.com/', 'https base URL correct');
is ($clickatell->{USER_AGENT}, 'test agent', 'user agent correct');

#use the non ssl default url
$clickatell = Net::Clickatell->new( UseSSL=>0, API_ID => $api_id, USERNAME =>$username, PASSWORD =>$password );
ok (defined($clickatell), 'clickatell object initiated with SSL 0');
is ($clickatell->{USE_SSL}, 0, 'UseSSL = false');
is ($clickatell->{BASE_URL}, 'http://api.clickatell.com/', 'http base URL correct');



($response, $response2) = $clickatell->getStatusDetail('ID: add8f5556c0d3d54bc94a4cd8800f01b4 Status: 001');
is ($response, '001', 'status detail code returned ok');
is ($response2, 'Message unknown. The delivering network did not recognise the message type or content.', 'status detail returned ok');

($response, $response2) = $clickatell->getStatus('001');
is ($response, '001', 'getStatus code ok');
is ($response2, 'Message unknown. The delivering network did not recognise the message type or content.', 'status detail returned ok');

($response, $response2) = $clickatell->getStatus('999');
is ($response, -1, 'getStatus code unknown ok');
is ($response2, 'Unknown Status', 'getStatus unknown ok');



#check if we have Test::MockModule installed
#only run the http tests if we are able to sub them out
eval "use Test::MockModule";
BAIL_OUT("Test::MockModule required for http tests") if $@;


{
    #override the normal LWP::UserAgent::request method
    #this will allow repeatable testing which does not
    #require access to the internet
    my $lwp = Test::MockModule->new( 'LWP::UserAgent' );
    $lwp->mock( request => sub { 
        my $lwpObj = shift;
        my $lwpReq = shift;
        
        my $uri = $lwpReq->{_uri};
        my $contentRef = hashContent($lwpReq->{_content});
        my %content = %$contentRef;
        
        my $operation='';
        if ($uri=~/\/([\w\.]+)$/){
            $operation = $1;
        }
        
        
        #check that the http params have been set correctly
        is ($content{user}, $username, 'username passed ok');
        is ($content{password}, $password, 'password passed ok');
        ok ($content{api_id} eq $api_id || $content{api_id} eq 'err', 'api id passed ok');
        
        #check which clickatell operation has been called
        if ($operation eq 'getbalance'){
            return getBalanceResponse($contentRef)
        }elsif ($operation eq 'routeCoverage.php'){
            is ($content{msisdn}, $msidn, 'msidn passed to route coverage ok');
            return getRouteCoverageResponse($contentRef);
        }elsif ($operation eq 'querymsg'){
            is ($content{apimsgid}, $apimsgid, 'apimsgid passed to query message ok');
            return getQueryResponse($contentRef);
        }elsif ($operation eq 'auth'){
            return getAuthResponse($contentRef);
        }elsif ($operation eq 'ping'){
            is ($content{session_id}, $sess_id, 'sess_id passed to ping ok');
            return getPingResponse($contentRef);
        }elsif ($operation eq 'sendmsg'){
            is ($content{to}, $to, 'to passed to send message ok');
            is ($content{from}, $from, 'from passed to send message ok');
            is ($content{text}, $expected_text, 'text passed to send message ok');
            return getSendMessageResponse($contentRef);
        }elsif ($operation eq 'ind_push.php'){
            is ($content{mms_from}, $from, 'mms_from passed to MM ok');
            is ($content{mms_class}, '80', 'mms_class passed to MM ok');
            is ($content{mms_subject}, 'MMS', 'mms_subject passed to MM ok');
            is ($content{to}, $to, 'to passed to MM ok');
            is ($content{from}, $from, 'from passed to MM ok');
            is ($content{mms_expire}, $mms_expire, 'mms_expire passed to MM ok');
            is ($content{mms_url}, uri_escape(uri_escape($mms_url)), 'mms_url passed to MM ok');
            return getMMNotificationResponse($contentRef);
        #removed due to runtime errors in sendSIWAPPush
        #}elsif ($operation eq 'si_push.php'){
        #    TODO: {
        #        local $TODO = 'error in sendSIWAPPush preventing a successful call';
        #        ok (defined($content{si_id}), 'si id defined in WAP Push');
        #        is ($content{si_action}, 'delete', 'si_action passed to WAP Push ok');
        #        ok (defined($content{si_created}), 'si_created defined in WAP Push');
        #        ok (defined($content{si_expires}), 'si_expires defined in WAP Push');
        #        is ($content{to}, $to, 'to passed to WAP Push ok');
        #        is ($content{from}, $from, 'from passed to WAP Push ok');
        #        is ($content{message}, $text, 'text passed to WAP Push ok');
        #        is ($content{si_url}, uri_escape(uri_escape($mms_url)), 'si_url passed to WAP Push ok');
        #    }
        #    return getWAPPushResponse($contentRef);
        }elsif ($operation eq 'getmsgcharge'){
            is ($content{apimsgid}, $apimsgid, 'apimsgid passed to get message charge ok');
            return getMessageChargeResponse($contentRef);
        }else{
            #return standard response
            return getStandardResponse();
        }
    });

    $response = $clickatell->getBalance;
    is ($response, 'OK: Credit: 100.3', 'get balance OK call');

    $response = $clickatell->authentication;
    is ($response, 'OK: 94950f7628a2d931845afe29e6eece17', 'auth OK call');

    $response = $clickatell->ping($sess_id);
    is ($response, 'OK:', 'ping OK call');

    $response = $clickatell->sendMMNotification($from, $to, $tranid, $mms_expire, $mms_url);
    is ($response, 'OK: ID: dd8f5556c0d3d54bc94a4cd8800f01b4', 'send MMNotification OK call');
    
    $response = $clickatell->sendBasicSMSMessage($from, $to, $text);
    is ($response, 'OK: ID: dd8f5556c0d3d54bc94a4cd8800f01b4', 'send message OK call');

    #removed due to runtime errors in sendSIWAPPush
    #TODO: {
    #    local $TODO = 'error in sendSIWAPPush preventing a successful call';
    #    $response = $clickatell->sendWAPPush($from,$to,$text,$mms_url);
    #    is ($response, 'OK: OK: ID: dd8f5556c0d3d54bc94a4cd8800f01b4', 'send WAP push OK call');
    #}

    ($response, $response2) = $clickatell->getQuery($apimsgid);
    is ($response, '001', 'getQuery return param 1 ok');
    is ($response2, "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4 Status: 001, Message unknown. The delivering network did not recognise the message type or content., Message unknown. The delivering network did not recognise the message type or content.", 'getQuery return param 2 ok');

    ($response, $response2) = $clickatell->getMessageCharge($apimsgid);
    is ($response, '001', 'getQuery return param 1 ok');
    is ($response2, "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4 Status: 001, Message unknown. The delivering network did not recognise the message type or content., Message unknown. The delivering network did not recognise the message type or content.", 'getQuery return param 2 ok');
    
    $response = $clickatell->checkCoverage($msidn);
    is ($response, 'OK: This prefix is currently supported. Messages sent to this prefix will be routed. Charge: 1', 'check coverage OK call');



    #recreate the clickatell object but with a different api id to force error conditions in the stubs
    $clickatell = Net::Clickatell->new( UseSSL=>0, API_ID => 'err', USERNAME =>$username, PASSWORD =>$password );
    ok (defined($clickatell), 'clickatell object re-initiated');

    $response = $clickatell->getBalance;
    is ($response, 'ERR: 001, Authentication failed', 'get balance error call');

    $response = $clickatell->authentication;
    is ($response, 'ERR: 001, Authentication failed', 'auth error call');

    $response = $clickatell->ping($sess_id);
    is ($response, 'ERR: 001, Authentication failed', 'ping error call');

    $response = $clickatell->sendMMNotification($from, $to, $tranid, $mms_expire, $mms_url);
    is ($response, 'ERR: 105, Invalid Destination Address', 'send MMNotification error call');

    $response = $clickatell->sendBasicSMSMessage($from, $to, $text);
    is ($response, 'ERR: 105, Invalid Destination Address', 'send message error call');

    #removed due to runtime errors in sendSIWAPPush
    #TODO: {
    #    local $TODO = 'error in sendSIWAPPush preventing a successful call';
    #    $response = $clickatell->sendWAPPush($from,$to,$text,$mms_url);
    #    is ($response, 'ERR: 105, Invalid Destination Address', 'send WAP push error call');
    #}

    ($response, $response2) = $clickatell->getQuery($apimsgid);
    is ($response, -1, 'getQuery error return param 1 ok');
    is ($response2, "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4, Error in the return status", 'getQuery error return param 2 ok');

    ($response, $response2) = $clickatell->getMessageCharge($apimsgid);
    is ($response, -1, 'getQuery error return param 1 ok');
    is ($response2, "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4, Error in the return status", 'getQuery error return param 2 ok');
    
    $response = $clickatell->checkCoverage($msidn);
    is ($response, 'ERR: This prefix is not currently supported. Messages sent to this prefix will fail. Please contact support for assistance.', 'check coverage error call');
}



sub hashContent{
    my $string = shift;
    
    my %hash;
    my @pairs = split /&/, $string;
    foreach my $pair(@pairs){
        if ($pair=~/^(.+)=(.*)$/){
            $hash{$1}=$2;
        }
    }
    return \%hash;
}

sub getBalanceResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = 'ERR: 001, Authentication failed';
    }else{
        $content = 'Credit: 100.3';
    }
    
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getAuthResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = 'ERR: 001, Authentication failed';
    }else{
        $content = 'OK: 94950f7628a2d931845afe29e6eece17';
    }
    
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getPingResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = 'ERR: 001, Authentication failed';
    }else{
        $content = 'OK:';
    }
    
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getSendMessageResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = 'ERR: 105, Invalid Destination Address';
    }else{
        $content = 'ID: dd8f5556c0d3d54bc94a4cd8800f01b4';
    }
    
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getMMNotificationResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = 'ERR: 105, Invalid Destination Address';
    }else{
        $content = 'ID: dd8f5556c0d3d54bc94a4cd8800f01b4';
    }
    
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getWAPPushResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = 'ERR: 105, Invalid Destination Address';
    }else{
        $content = 'ID: dd8f5556c0d3d54bc94a4cd8800f01b4';
    }
    
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getRouteCoverageResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = 'ERR: This prefix is not currently supported. Messages sent to this prefix will fail. Please contact support for assistance.';
    }else{
        $content = 'OK: This prefix is currently supported. Messages sent to this prefix will be routed. Charge: 1';
    }
    
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getQueryResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4";
    }else{
        $content = "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4 Status: 001, Message unknown. The delivering network did not recognise the message type or content.";
    }
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getMessageChargeResponse{
    my $hashRef = shift;
    my %params = %$hashRef;
    
    my $content;
    if ($params{api_id} eq 'err'){
        $content = "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4";
    }else{
        $content = "001\nID: add8f5556c0d3d54bc94a4cd8800f01b4 Status: 001, Message unknown. The delivering network did not recognise the message type or content.";
    }
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content($content);
    return $response;
}

sub getStandardResponse{
    my $response = HTTP::Response->new;
    $response->code(200);
    $response->content('OK:001');
    return $response;
}


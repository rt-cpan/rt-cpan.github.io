#/usr/bin/env perl

use strict;
use warnings;
use Test::More tests=>8;
use utf8;

package Test::reCAPTCHA;

use HTML::FormHandler::I18N;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler'; # se non derivasse da DBIC

with 'HTML::FormHandlerX::Widget::Field::reCAPTCHA';

has '+is_html5' => (default=>1);

has_field 'email' => (type => 'Email', 'label'=>'email', element_attr => {title=>'your email address', placeholder => 'your email address'}, required=>1);

has_field 'recaptcha' => (
        type=>'reCAPTCHA', 
        recaptcha_message => "Non hai dimostrato di essere un umano!",
        required=>1,
);

has ['recaptcha_public_key','recaptcha_private_key'] => (is => 'rw', isa=>'Str', required=>1);

no HTML::FormHandler::Moose;

package ::main;

#use_ok('Test::reCAPTCHA');

my $public_key = 'zio pino';
my $private_key = 'zio can';

my $form = Test::reCAPTCHA->new(recaptcha_public_key=>$public_key,recaptcha_private_key=>$private_key);

ok($form, 'get form');

$form->process(params => {});

ok($form->field('recaptcha')->render, 'OK recaptcha');

my $expected = q(
<div>
<label for="recaptcha">Recaptcha</label>
<script type="text/javascript">
//<![CDATA[
var RecaptchaOptions = {};
//]]>
</script>
<script src="http://www.google.com/recaptcha/api/challenge?k=zio+pino" type="text/javascript"></script>
<noscript><iframe frameborder="0" height="300" src="http://www.google.com/recaptcha/api/noscript?k=zio+pino" width="500"></iframe><textarea cols="40" name="recaptcha_challenge_field" rows="3"></textarea><input name="recaptcha_response_field" type="hidden" value="manual_challenge" /></noscript>

</div>);

ok($form->field('recaptcha')->render eq $expected, 'recaptcha render OK') || diag($form->field('recaptcha')->render);

like($form->field('recaptcha')->render,qr/k=zio\+pino/, 'recaptcha public_key OK') || diag($form->field('recaptcha')->render);

# sometime, for development deployment, can be useful to inactivate reCAPTCHA
# but actually it doesn't support to be inactive.

my $form1 = Test::reCAPTCHA->new(inactive=>['recaptcha'],recaptcha_public_key=>$public_key,recaptcha_private_key=>$private_key);

ok($form1, 'get form without recaptcha');

TODO: {
    local $TODO = "recaptcha doesn't seem inactivable";
    eval {
	ok($form1->process(params => {}), "process form with recaptcha inactive");
    };
    eval {
	ok($form1->render, "OK, render form with recaptcha inactive");
    };
}

TODO1: {    
    $TODO = "form with recaptcha doesn't render if keys are given at runtime";
    ok($form->render, "Fixed form with recaptcha and keys given at runtime");
}

exit;

1;

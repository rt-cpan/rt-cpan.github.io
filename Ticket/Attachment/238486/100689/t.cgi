#!/usr/bin/perl -w
use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

use Mail::GnuPG;
use MIME::Parser;

my $q = new CGI;

print $q->header;

my $signedfile = $q->param("signedfile");

if (!ref $signedfile) {
	print 
	 $q->start_html, 
	 $q->start_multipart_form, 
	 "Signed text:",
	 $q->filefield("signedfile"),
	 $q->submit,
	 $q->end_form,
	 $q->end_html;
	 exit 0;
}



print $q->start_html;

my $signeddata;
{
  local $/=undef;
  $signeddata = <$signedfile>;
  close $signedfile;
}

my $parser = MIME::Parser->new;
$parser->output_under("/tmp");

my $entity = $parser->parse_data($signeddata) or die "parse failed\n";

my $mg = Mail::GnuPG->new(keydir => "/tmp/gnupg");

my @ret = $mg->verify($entity);

print "Verify returned :" . join(",", @ret), "<br>\n";

if ($ret[0]) {
  print "Messages: <pre>" , join("", @{$mg->{last_message}}) , "\n";
}

print $q->end_html;

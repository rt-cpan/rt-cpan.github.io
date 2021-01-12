#!/usr/bin/perl
#
# Require Perl5
#
# rss2twitter -- RSS to Twitter
#
# by Pivari.com <info@pivari.com> 25th April 2007
#
# This is version 0.1
#
# blogger to twitter
use strict;
use Getopt::Long;
use HTTP::Lite;
use Net::Twitter;
use XML::RSS;
# use Encode;
# sourceforge
# GUI
# Donazioni
# -user e -password
# con user crea un file di appoggio dove memorizzare gli articoli
# Caricamento rss
# estrazione titolo e link
# conversione caratteri accentati
# pubblicazione

my $version="0.1";
my $producer="rss2twitter";
my $rss2twitterHome="http://www.pivari.com/$producer.html";
my $configure=$producer.".cfg";
my $help=0; my $verbose=0; my $Version;
my $debug=0; my $match=0; my $prhase;
my $companyname="Pivari.com";
my $PIVARImail="mailto:info\@pivari.com";

my $elem; my @option; my @elem; my $temp; my $newtemp;
my $phrase; my $result;

&GetOptions("configure=s"  => \$configure,
            "help"         => \$help,
            "version"      => \$Version,
            "verbose"      => \$verbose,
            "debug"        => \$debug) || printusage() ;
my @elem=("user","password","feed");
my %option=(user                  => '',
            password              => '',
            feed                  => '');

$debug and $verbose=1;
if($Version) {print "$producer $version\n";exit;}
$help and printusage();

if (-e $configure) {
  $verbose and print "Processing $configure configuration file\n";
  open (CNF, "$configure");
  while (<CNF>) {
    s/\t/ /g;        #replace tabs by space
    s/ *$//g;        #delete blanks at the end of the line
    next if /^ *\#/; #ignore comment lines
    next if /^ *$/;  #ignore empty lines
    foreach $elem (@elem) {
      if (/ *$elem *: *(.*)/i) {
        $option{$elem}=$1;
	$verbose and print "$elem is set\t\t$option{$elem}\n";
        }
      }
    }
  close(CNF);
  } else {
  &Warning("to set your $producer configuration file you can use:\n$producer.cfg or -configure your_$producer.cfg\nElse the program will use the default parameters\n-default to see the default parameters\n")
  }

my $http = new HTTP::Lite;
my $req = $http->request("$option{'feed'}") 
             or die "Unable to get document: $!";
$debug and print "Downloading $option{'feed'}\n"; 
$debug and print $http->body();
my $rss = new XML::RSS;
$rss->parse($http->body());

my $file= $option{'user'}.".r2t";
my $twit = Net::Twitter->new(username=>$option{'user'}, password=>$option{'password'});
   foreach my $item (@{$rss->{'items'}}) {
     next unless defined($item->{'title'}) && defined($item->{'link'});
     if (-e $file) {
       $match=0;
       open (FILE, "$file") ||
         die "$producer: couldn't read file $file\n";
       while (<FILE>) {
         $temp=$item->{'title'};
#         $temp=&SpecChars($item->{'title'});
#	 if (/$item->{'link'}: $temp/) {$match=1}
	 if (/$item->{'link'}/) {$match=1}
         }
       close(FILE);
       if($match eq 0) {
         $phrase="$item->{'link'} $item->{'title'} ";
	 $verbose and print "$phrase\n";
         $result = $twit->update($phrase);
         }
     } else {
       $phrase="$item->{'link'} $item->{'title'}";
       $verbose and print "$phrase\n";
       $result = $twit->update($phrase);
     } 
   }
   open (FILE, ">$file") ||
     die "$producer: couldn't create file $file\n";
   foreach my $item (@{$rss->{'items'}}) {
     next unless defined($item->{'title'}) && defined($item->{'link'});
     $temp=$item->{'title'};
#       $temp=&UTFiso($temp);
#       $newtemp = decode("utf8", $temp), 
#       $temp = encode("cp1250", $newtemp);
#       $temp=&SpecChars($temp);
     print FILE "$item->{'link'}: $temp\n";
     }
   close(FILE);



sub SpecChars {
  my $string = shift(@_);
  $string=~s/&/&amp;/g;
  $string=~s/'/&#39;/g;
  $string=~s/"/&#34;/g;
  $string=~s/ñ/&#241;/g;
  $string=~s/à/&#224;/g;
  $string=~s/è/&#232;/g;
  $string=~s/ì/&#236;/g;
  $string=~s/ò/&#242;/g;
  $string=~s/ù/&#249;/g;
  $string=~s/á/&#225;/g;
  $string=~s/é/&#233;/g;
  $string=~s/í/&#237;/g;
  $string=~s/ó/&#243;/g;
  $string=~s/ú/&#250;/g;
  $string=~s/â/&#226;/g;
  $string=~s/ê/&#234;/g;
  $string=~s/î/&#238;/g;
  $string=~s/ô/&#244;/g;
  $string=~s/û/&#251;/g;
  $string=~s/ä/&#228;/g;
  $string=~s/ë/&#235;/g;
  $string=~s/ï/&#239;/g;
  $string=~s/ö/&#246;/g;
  $string=~s/ü/&#252;/g;
  $string=~s/ã/&#227;/g;
  $string=~s/õ/&#245;/g;
  $string=~s//&#8220;/g;
  $string=~s//&#8221;/g;
  $string=~s//&#8212;/g;
  $string=~s//&#8217;/g;
  $string=~s/®/&#174;/g;
  return $string;
  }

# UTF-8 to iso-8859-1
sub UTFiso {
  my $string = shift(@_);
  $string=~s/Ã /à/g;
  $string=~s/Ã¨/è/g;
  $string=~s/Ã©/é/g;
  $string=~s/Ã²/ò/g;
  $string=~s/Ã¹/ù/g;
  $string=~s/Ã¬/ì/g;
  $string=~s/â//g;
  $string=~s/â//g;
  $string=~s/Â°/°/g;
  $string=~s/Â®/®/g;
  $string=~s/â¢//g;
  return $string;
  }

sub printusage {
    print <<USAGEDESC;

usage:
        $producer [-options ...] 

where options include:
    -help               print out this message
    -configure file     default $producer.cfg
    -version            the program version
    -verbose            verbose

Home: $rss2twitterHome

USAGEDESC
    exit(1);
}

exit 0;

# __END__

=head1 NAME

RSS2Twitter - Version 1.0 25th April 2007

=head1 SYNOPSIS

Syntax : rss2twitter [-options]

=head1 DESCRIPTION

rss2twitter
To introduce the title and the link of the posts in a RSS into Twitter

=head1 Features

RSS2TWITTER

=head1 Options

where options include:

    -help               print out this message
    -configure file     default txt2pdf.cfg
    -version            the program version
    -verbose            verbose

=cut

#!/usr/local/bin/perl

use XML::CSVINPUT;
use Getopt::Long;

my %option = ('defaultdelim' => ';');
GetOptions
 (
  'infile=s' => \$option{csvin},
  'outfile=s' => \$option{xmlout},
  'delim=s' => \$option{delim},
 );
unless (defined ($option{csvin} && $option{xmlout}))
 {&USAGE();
  exit;
 }
unless (defined $option{delim})
 {$option{delim} = $option{defaultdelim};
 }

eval{
$default_obj_xs = Text::CSV_XS->new({sep_char => $option{delim}}, error_out => '1');
my $obj = XML::CSVINPUT->new({csv_xs => $default_obj_xs});
my $num = $obj->parse_doc($option{csvin}, {'headings' => 1, 'sub_char' => "_"});
$obj->declare_xml({version => '1.0', encoding=> 'ISO-8859-1', standalone => 'yes'});
#$obj->declare_doctype({source => 'PUBLIC', location1 => '-//Netscape Communications//DTD RSS 0.90//EN', location2 => 'http://my.netscape.com/publish/formats/rss-0.91.dtd'});
$obj->print_xml($option{xmlout}, {format => " ", file_tag => "dsScheduleData", parent_tag => "Activity"});
#if($XML::CSV::csvxml_error) != ""
#{print "erreur : $XML::CSV::csvxml_error"
#}
};

if($@)
 {print "not ok 4: $@\n";
  $loaded = 0;
  undef($@);
 }
else
 {print "OK $@\n";
 }

########################################################
sub USAGE
 {
print <<EOF
Options requises :
==================
  -i FichierCSV1,FichierCSV2 si plusieurs fichiers csv ou -i FichierCSV
  -o NomDuFichierXLS
  -d ";" pour le delimiteur

Exemple :
---------
  csv2xls.pl -i file1.csv,file2.csv,file3.csv -o file1.xls -d ";"

EOF
;
 }

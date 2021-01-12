use strict;
use Data::Dumper();
use IO::File();
#---------
{  # Print result on STDERR and in the file 'bug.out'
   my ($file, $fh) = ('bug.out', undef);
   sub _print {my $s=shift; print STDERR $s; print $fh $s}
   sub _dump {
      my %h = @_;
      if (!$fh) {$fh = IO::File->new(">$file") or die("open(>$file) impossible: ($!)!")}
      _print "-------\n";
      for my $k (sort keys %h) {
         my $d = Data::Dumper->new([$h{$k}], [$k]);
         $d->Sortkeys(1);
         _print $d->Dump;
      }
   }
}
#---------
my $file = 'bug.csv';
{  # Test with CSV_XS
   use Text::CSV_XS();
   my $fh = IO::File->new("<$file") or die("open(<$file) impossible: ($!)!");
   my $csv = Text::CSV_XS->new ({sep_char=>";", binary=>1});
   my $fields = $csv->getline ($fh);
   _dump (
      context => "XS",
      'csv->fields()' => [ $csv->fields() ],
      'csv->error_input()'  => $csv->error_input(),
      'csv->error_diag ()'  => join ('|', @{[$csv->error_diag()]}),
      csv => $csv,
   );
}
{  # Same Test with CSV_XP
   use Text::CSV_PP();
   my $fh = IO::File->new("<$file") or die("open(<$file) impossible: ($!)!");
   my $csv = Text::CSV_PP->new ({sep_char=>";", binary=>1});
   my $fields = $csv->getline ($fh);
   _dump (
      context => "PP",
      'csv->fields()' => [ $csv->fields() ],
      'csv->error_input()'  => $csv->error_input(),
      'csv->error_diag ()'  => join ('|', @{[$csv->error_diag()]}),
   );
}

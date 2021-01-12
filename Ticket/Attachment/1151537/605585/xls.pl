    use 5.10.0;
    use warnings;
    binmode STDOUT, ':encoding(UTF-8)';    # or use utf8::all
    use Spreadsheet::ParseExcel;

    my $workbook = Spreadsheet::ParseExcel->new->parse('utf8.xls');

    my @worksheets = $workbook->worksheets;
    my $cell = $worksheets[0]->get_cell( 0, 0 );
    say "Value       = ", $cell->value();
    say "Unformatted = ", $cell->unformatted();

    say "Perl version   : $]";
    say "OS name        : $^O";
    say "Module versions: (not all are required)\n";

    my @modules = qw(
      Spreadsheet::ParseExcel
      Scalar::Util
      Unicode::Map
      Spreadsheet::WriteExcel
      Parse::RecDescent
      File::Temp
      OLE::Storage_Lite
      IO::Stringy
    );

    for my $module (@modules) {
        my $version;
        eval "require $module";

        if ( not $@ ) {
            $version = $module->VERSION;
            $version = '(unknown)' if not defined $version;
        }
        else {
            $version = '(not installed)';
        }

        printf "%21s%-24s\t%s\n", "", $module, $version;
    }

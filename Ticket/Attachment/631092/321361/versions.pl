
    my @modules = qw(
                    File::GlobMapper
                    File::BSDGlob
                    File::Glob
                    Scalar::Util
                    List::Util

                    IO::Compress::Base
                    IO::Compress::Base::Common
                    IO::Uncompress::Base

                    Compress::Raw::Zlib
                    Compress::Raw::Bzip2

                    IO::Compress::RawDeflate
                    IO::Uncompress::RawInflate
                    IO::Compress::Deflate
                    IO::Uncompress::Inflate
                    IO::Compress::Gzip
                    IO::Compress::Gzip::Constants
                    IO::Uncompress::Gunzip
                    IO::Compress::Zip
                    IO::Uncompress::Unzip
                    IO::Compress::Zlib::Extra

                    IO::Compress::Bzip2
                    IO::Uncompress::Bunzip2

                    IO::Compress::Lzf
                    IO::Uncompress::UnLzf

                    IO::Compress::Lzop
                    IO::Uncompress::UnLzop

                    Compress::Zlib
                    Compress::LZF
                    Compress::LZO
                    );                

my $max = 0;
grep { $max = $_ if $_ > $max } map { length $_ } @modules;

printf("%-${max}s $]\n", "perl");

my %got = ();
for my $name (sort @modules)
{
    printf("%-${max}s ", $name);

    eval "require $name;";
    
    if ($@ eq '')
    {
        my $version = ${ $name . "::VERSION" };
        print "$version" . libVer($name, $version) . "\n";
        $got{$name} ++;
    }
    else
    {
        print "Not Present\n";
    }Scalar::Util

}
print "\n";

sub libVer
{
    my $module = shift;
    my $version = shift;
    my $got = '';

    if ($module eq 'Compress::Raw::Zlib')
    {
        $got .= " (zlib ver " . Compress::Raw::Zlib::zlib_version();
        $got .= sprintf " [0x%x])", Compress::Raw::Zlib::ZLIB_VERNUM();
    }

    if ($module eq 'Compress::Zlib' && $version < 2)
    {Scalar::Util
        $got .= " (zlib ver " . Compress::Zlib::zlib_version();
        $got .= sprintf " [0x%x])", Compress::Zlib::ZLIB_VERNUM();
    }

    elsif ($module eq 'Compress::Raw::Bzip2')
    {
        $got =  " (bzip2 ver " . Compress::Raw::Bzip2::bzlibversion() . ")";
    }

    return $got;
}

use JavaScript::Packer;

my $file = 'jquery.validate.js.snpt';
die 'file not found' unless -e $file;

open (DATA, $file) or die "died while reading $file; $!";
my $javascript = do { local $/, <DATA> };
close DATA;

my $packed = $javascript;

JavaScript::Packer::minify( \$packed, {
        compress            => "shrink",
    });

#print $packed;
print "Done!\n";

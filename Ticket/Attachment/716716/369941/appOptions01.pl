use File::Spec;

$ENV{HOME} = $ENV{"USERPROFILE"};
use App::Options;
    print "Wow. Here are the options...\n";
    foreach (sort keys %App::options) {  # options appear here!
        printf("%-20s => %s\n", $_, $App::options{$_});
    }

print ("Home is \t\t", $ENV{"USERPROFILE"}, "\n");

my $configFile =  File::Spec->catfile("C:", "ctemp", "app.conf");
print "EXISTS : $configFile!!!\n" if (-e("$configFile"));

__END__

>perl appOptions01.pl -s -r -yeah --awake=yes
Wow. Here are the options...
app                  => appOptions01
awake                => yes
host                 => Biostar01
hostname             => Biostar01
prefix               => C:/Perl
r                    => 1
s                    => 1
yeah                 => 1
Home is                 C:\Documents and Settings\Malcolm

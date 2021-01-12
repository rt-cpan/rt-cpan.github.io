#!/usr/bin/perl
use Sort::External;
use Fcntl;


$temp_directory = "/home/roberts/EpiSims/events-data";
$eventsfile = shift(@ARGV);
$outfile =  shift(@ARGV);


open(EVENTS, $eventsfile)
    || die "Events file $eventsfile is not found! \n";

open(OUT, ">$outfile")
    || die "Could not open $outfile! \n";
    
my $sort_sub = sub { 
    print "a: $Sort::External::a\n";
    print "b: $Sort::External::b\n";
    return 0;
};

my $sortscheme = sub {
     @fieldsa = split(" ",$Sort::External::a);
     @fieldsb = split(" ",$Sort::External::b);
     #print "Sort::External::a: $Sort::External::a\n";
     #print "Sort::External::b: $Sort::External::b\n";
     #print "fieldsa[1]: @fieldsa[1]\n";
     $colona1 = index (@fieldsa[1], ":");
     $colona2 = index (@fieldsa[1], ":", $colona1+1);
     $colonb1 = index (@fieldsb[1], ":");
     $colonb2 = index (@fieldsb[1], ":", $colonb1+1);
     #print "colon1: $colon1\n";
     #print "colon2: $colon2\n";
     $hours1 = substr(@fieldsa[1],0,$colona1);
     $minutes1 = substr(@fieldsa[1], $colona1 + 1, 2);
     $seconds1 = substr(@fieldsa[1], $colona2 + 1, 2);
     $hours2 = substr(@fieldsb[1],0,$colonb1);
     $minutes2 = substr(@fieldsb[1], $colonb1 + 1, 2);
     $seconds2 = substr(@fieldsb[1], $colonb2 + 1, 2);
     #print "Hours1: $hours1; Minutes1: $minutes1; Seconds1: $seconds1\n";
     #print "Hours2: $hours2; Minutes2: $minutes2; Seconds2: $seconds2\n";
     return -1 if $hours1 < $hours2;
     return 1 if $hours1 > $hours2;
     return -1 if $hours1 == $hours2 && $minutes1 < $minutes2;
     return 1 if $hours1 == $hours2 && $minutes1 > $minutes2;
     return -1 if $hours1 == $hours2 && $minutes1 == $minutes2 && $seconds1 < $seconds2;
     return 1 if $hours1 == $hours2 && $minutes1 == $minutes2 && $seconds1 > $seconds2;
     return 0;1
};

my $sortex = Sort::External->new( -mem_threshold => 2**8, 
				  -sortsub => $sortscheme,
				  -working_dir => $temp_directory,);

while (<EVENTS>) {
    $sortex->feed($_);
};

$sortex->finish;

while ( defined( $_ = $sortex->fetch ) ) {
    print OUT "$_";
}


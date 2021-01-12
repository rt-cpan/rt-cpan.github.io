#!/usr/bin/perl -w
use Verilog::Netlist;
use XML::Simple qw(XMLout);

# Setup options so files can be found
use Verilog::Getopt;
my $opt = new Verilog::Getopt;
$opt->parameter( "+incdir+",
                 "-y ./","+libext+.v",
                 );

# Prepare netlist
my $netlist = new Verilog::Netlist (options => $opt,);

foreach my $file ('i2c_blk_ver.v') {
    $netlist->read_file (filename=>$file);
}
# Read in any sub-modules
$netlist->link();
$netlist->lint();
$netlist->exit_if_error();

# Find top module
my @top_module = $netlist->top_modules_sorted;
print $top_module[0]->name."\n";
my $module = $netlist->find_module($top_module[0]->name);

# Extract the list of instances under top module
my @cells = $module->cells;


foreach my $mod ($netlist->top_modules_sorted) {
    
    show_hier ($mod, "  ", "", "");

}

sub show_hier {
    my $mod = shift;
    my $indent = shift;
    my $hier = shift;
    my $cellname = shift;

    if (!$cellname) {$hier = $mod->name;} #top modules get the design name
    else {
            printf ("%-45s %s\n", $indent."Module ".$mod->name,$hier) if($mod->name eq "SHIFT8");
        $hier .= ".$cellname";} #append the cellname



##Printing cell pin list
    foreach my $cell ($mod->cells_sorted) {
        if ($cell->submodname eq "SHIFT8"){
            printf ($indent. "  Module %s\n", $cell->submodname);            
            printf ($indent. "    Cell %s\n", $cell->name);
            foreach my $pin ($cell->pins_sorted) 
            {
                printf ($indent."     .%s(%s)\n", $pin->name, $pin->netname);
                $pin->dump;
##                print "pin name ".$nt->name."\n";

                
            }
        }
        show_hier ($cell->submod, $indent."  ", $hier, $cell->name) if $cell->submod;
    }
}

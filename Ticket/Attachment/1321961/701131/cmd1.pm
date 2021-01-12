# ABSTRACT fobicates the fnords
package myapp::Command;
use Modern::Perl;
use Moops;

class cmd1
extends MooseX::App::Cmd::Command
using Moose {
  has opt1 => (traits =>['Getopt'], isa =>'Bool', is => 'ro');
  method description { return "cmd1"; };
  method execute( HashRef $opt, ArrayRef $args) {
    print "Opt".($opt->{'opt1'} ? "" : " not")." set\n";
  };
}

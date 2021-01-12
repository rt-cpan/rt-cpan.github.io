#! perl
use Cwd 'abs_path';
use File::Spec;
print "\nCwd->abs_path(F:testpl.cmd)        = ", Cwd->abs_path('F:testpl.cmd');
print "\nCwd->abs_path(G:testpl.cmd)        = ", Cwd->abs_path('G:testpl.cmd');
print "\nCwd->abs_path(H:testpl.cmd)        = ", Cwd->abs_path('H:testpl.cmd');
print "\nCwd->abs_path(testpl.cmd)          = ", Cwd->abs_path('testpl.cmd');
print "\nCwd->abs_path(\\testpl.cmd)         = ", Cwd->abs_path('\testpl.cmd');
print "\nCwd->abs_path(\\\\server\\testpl.cmd) = ", Cwd->abs_path('\\server\testpl.cmd');
print "\n";

print "\nFile::Spec->rel2abs(F:testpl.cmd)         = ", File::Spec->rel2abs('F:testpl.cmd');
print "\nFile::Spec->rel2abs(G:testpl.cmd)         = ", File::Spec->rel2abs('G:testpl.cmd');
print "\nFile::Spec->rel2abs(H:testpl.cmd)         = ", File::Spec->rel2abs('H:testpl.cmd');
print "\nFile::Spec->rel2abs(testpl.cmd)           = ", File::Spec->rel2abs('testpl.cmd');
print "\nFile::Spec->rel2abs(\\testpl.cmd)          = ", File::Spec->rel2abs('\testpl.cmd');
print "\nFile::Spec->rel2abs(\\\\server\\testpl.cmd)  = ", File::Spec->rel2abs('\\server\testpl.cmd');

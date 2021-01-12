/* REXX */
/* change to drives and directories that exist on your system */
/* adjust path to test script */
'F:'
cd '\ecs'
'G:'
/* don't use the same name as above */
cd '\BIN'
say 'Should output Cwd->abs_path(F:testpl.cmd)              = F:/ecs/testpl.cmd'
say '              Cwd->abs_path(G:testpl.cmd)              = G:/bin/testpl.cmd'
say '              Cwd->abs_path(testpl.cmd)                = G:/bin/testpl.cmd'
say '              Cwd->abs_path(\testpl.cmd)               = G:/testpl.cmd'
say '              Cwd->abs_path(\\server\testpl.cmd)       = //server/bin/testpl.cmd'
say '              File::Spec->rel2abs(F:testpl.cmd)        = F:/ecs/testpl.cmd'
say '              File::Spec->rel2abs(G:testpl.cmd)        = G:/bin/testpl.cmd'
say '              File::Spec->rel2abs(testpl.cmd)          = G:/bin/testpl.cmd'
say '              File::Spec->rel2abs(\testpl.cmd)         = G:/testpl.cmd'
say '              File::Spec->rel2abs(\\server\testpl.cmd) = //server/bin/testpl.cmd'
perl 'h:\utility\testrel2abs.pl'

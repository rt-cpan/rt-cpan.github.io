use strict;
use warnings;

use Inline C => Config =>
    BUILD_NOISY => 1,
;

use Inline C => <<'EOC';

void inline_warner() {
   int *x;
   x = 2;
}


EOC

print "DONE";

__END__

Should output (for me on Windows):

#############################################
validate Stage
Starting Build Preprocess Stage
get_maps Stage
Finished Build Preprocess Stage

Starting Build Parse Stage
Finished Build Parse Stage

Starting Build Glue 1 Stage
Finished Build Glue 1 Stage

Starting Build Glue 2 Stage
Finished Build Glue 2 Stage

Starting Build Glue 3 Stage
Finished Build Glue 3 Stage

Starting Build Compile Stage
  Starting "perl Makefile.PL" Stage
Writing Makefile for try_pl_534c
Writing MYMETA.yml
  Finished "perl Makefile.PL" Stage

  Starting "make" Stage
C:\perl514_M\bin\perl.exe C:\perl514_M\lib\ExtUtils\xsubpp  -typemap "C:\perl514_M\lib\ExtUtils\typemap" -typemap "C:\_32\pscrpt\inline\typemap"  try_pl_534c.xs > try_pl_534c.xsc && C:\perl514_M\bin\perl.exe -MExtUtils::Command -e "mv" -- try_pl_534c.xsc try_pl_534c.c
gcc -c  -I"C:/_32/pscrpt/inline" 	-s -O2 -DWIN32 -DPERL_TEXTMODE_SCRIPTS -DPERL_IMPLICIT_CONTEXT -DPERL_IMPLICIT_SYS -fno-strict-aliasing -mms-bitfields -s -O2 	  -DVERSION=\"0.00\" 	-DXS_VERSION=\"0.00\"  "-IC:\perl514_M\lib\CORE"   try_pl_534c.c
try_pl_534c.xs: In function `inline_warner':
try_pl_534c.xs:8: warning: assignment makes pointer from integer without a cast
Running Mkbootstrap for try_pl_534c ()
C:\perl514_M\bin\perl.exe -MExtUtils::Command -e "chmod" -- 644 try_pl_534c.bs
C:\perl514_M\bin\perl.exe -MExtUtils::Mksymlists \
     -e "Mksymlists('NAME'=>\"try_pl_534c\", 'DLBASE' => 'try_pl_534c', 'DL_FUNCS' => {  }, 'FUNCLIST' => [], 'IMPORTS' => {  }, 'DL_VARS' => []);"
dlltool --def try_pl_534c.def --output-exp dll.exp
g++ -o blib\arch\auto\try_pl_534c\try_pl_534c.dll -Wl,--base-file -Wl,dll.base -mdll -s -L"c:\perl514_M\lib\CORE" -L"C:\home\rob\mingw_vista\i686-pc-mingw32\lib" try_pl_534c.o   C:\perl514_M\lib\CORE\libperl514.a -lmoldname -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -lnetapi32 -luuid -lws2_32 -lmpr -lwinmm -lversion -lodbc32 -lodbccp32 -lcomctl32 dll.exp
dlltool --def try_pl_534c.def --base-file dll.base --output-exp dll.exp
g++ -o blib\arch\auto\try_pl_534c\try_pl_534c.dll -mdll -s -L"c:\perl514_M\lib\CORE" -L"C:\home\rob\mingw_vista\i686-pc-mingw32\lib" try_pl_534c.o   C:\perl514_M\lib\CORE\libperl514.a -lmoldname -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -lnetapi32 -luuid -lws2_32 -lmpr -lwinmm -lversion -lodbc32 -lodbccp32 -lcomctl32 dll.exp 
C:\perl514_M\bin\perl.exe -MExtUtils::Command -e "chmod" -- 755 blib\arch\auto\try_pl_534c\try_pl_534c.dll
C:\perl514_M\bin\perl.exe -MExtUtils::Command -e "cp" -- try_pl_534c.bs blib\arch\auto\try_pl_534c\try_pl_534c.bs
C:\perl514_M\bin\perl.exe -MExtUtils::Command -e "chmod" -- 644 blib\arch\auto\try_pl_534c\try_pl_534c.bs
dmake:  Warning: -- Target [blibdirs] was made but the time stamp has not been updated.
  Finished "make" Stage

  Starting "make install" Stage
Files found in blib\arch: installing files in blib\lib into architecture dependent library tree
Installing C:\_32\pscrpt\inline\_Inline\lib\auto\try_pl_534c\try_pl_534c.dll
Installing C:\_32\pscrpt\inline\_Inline\lib\auto\try_pl_534c\try_pl_534c.bs
  Finished "make install" Stage

  Starting Cleaning Up Stage
  Finished Cleaning Up Stage

Finished Build Compile Stage

DONE
#######################################

But, with Inline-0.55 outputs:

#######################################
validate Stage
Starting Build Preprocess Stage
get_maps Stage
Finished Build Preprocess Stage

Starting Build Parse Stage
Finished Build Parse Stage

Starting Build Glue 1 Stage
Finished Build Glue 1 Stage

Starting Build Glue 2 Stage
Finished Build Glue 2 Stage

Starting Build Glue 3 Stage
Finished Build Glue 3 Stage

Starting Build Compile Stage
  Starting "perl Makefile.PL" Stage
  Finished "perl Makefile.PL" Stage

  Starting "make" Stage
  Finished "make" Stage

  Starting "make install" Stage
  Finished "make install" Stage

  Starting Cleaning Up Stage
  Finished Cleaning Up Stage

Finished Build Compile Stage

DONE
#######################################
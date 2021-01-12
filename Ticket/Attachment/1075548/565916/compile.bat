cl -c -Od testdll.c
link -NODEFAULTLIB -INCREMENTAL:NO -dll -debug -align:16 testdll.obj
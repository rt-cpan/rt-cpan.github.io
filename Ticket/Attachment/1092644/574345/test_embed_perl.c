// gcc -Wall -g -o test_embed_perl test_embed_perl.c `perl -MExtUtils::Embed -e ccopts -eldopts`

#include <EXTERN.h>
#include <perl.h>

static PerlInterpreter *my_perl;

char *my_argv[] = { "", "test.pl", NULL };
int my_argc = 2;
char **my_env = NULL;

static void xs_init (pTHX);
EXTERN_C void boot_DynaLoader (pTHX_ CV* cv);

// static void xs_init(pTHX)
EXTERN_C void
xs_init(pTHX)
{
        char *file = __FILE__;
        dXSUB_SYS;

        // DynaLoader is a special case
        newXS("DynaLoader::boot_DynaLoader", boot_DynaLoader, file);
}

static void
do_perl(int a, int b)
{
        dSP; /* initialize stack pointer */
        ENTER; /* everything created after here */
        SAVETMPS; /* ...is a temporary variable. */
        PUSHMARK(SP); /* remember the stack pointer */
        XPUSHs(sv_2mortal(newSViv(a))); /* push the base onto the stack */
        XPUSHs(sv_2mortal(newSViv(b))); /* push the exponent onto stack */
        PUTBACK; /* make local stack pointer global */
        call_pv("call_perl", G_SCALAR); /* call the function */
        SPAGAIN; /* refresh stack pointer */
        /* pop the return value from stack */
        printf ("   -> %d * %d = %d.\n", a, b, POPi);
        PUTBACK;
        FREETMPS; /* free that return value */
        LEAVE; /* ...and the XPUSHed "mortal" args.*/
}

void call_perl(int argc, char **argv, char **env, int a, int b)
{
        int exitstatus;

        //PERL_SYS_INIT3(&my_argc,&my_argv,&my_env);

        my_perl = perl_alloc();
        perl_construct( my_perl );
        
        PL_exit_flags |= PERL_EXIT_DESTRUCT_END;
        exitstatus = perl_parse(my_perl, xs_init, my_argc, my_argv, my_env);
        if (exitstatus) {
                printf("exitstatus=%d\n", exitstatus);
                perl_destruct(my_perl);
                perl_free(my_perl);
                PERL_SYS_TERM();
                exit(1);
        }
        
        do_perl(a, b);
        
        PL_perl_destruct_level = 1;
        perl_destruct(my_perl);
        perl_free(my_perl);

        //PERL_SYS_TERM();
        my_perl = NULL;
}

int main (int argc, char **argv, char **env)
{
        int i;

        //PERL_SYS_INIT3(&my_argc,&my_argv,&my_env);

        for (i = 0; i < 5; i++) {
                printf("call %d:\n", i);
                call_perl(my_argc, my_argv, my_env, i, i+1);
        }
	//call_perl();

        //PERL_SYS_TERM();
        //my_perl = NULL;

        return 0;
}


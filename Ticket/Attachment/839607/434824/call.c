/*
 cc `perl -MExtUtils::Embed -e ccopts -e ldopts` -g call.c -o call && ./call

 for s in `perl -nle 'print $1 if /sub (\w+)/' call.pl`; \
   do if ./call $s 2> /dev/null; then echo "$s PASS"; else echo "$s FAIL"; fi;\
 done

 test_use_fail FAIL
 test_eval_begin_die FAIL
 test_eval_syntax FAIL
 test_eval_begin_eval_die PASS
 test_eval_end_die PASS
 test_eval_die PASS

 */
#include <stdio.h>

#include <EXTERN.h>
#include <perl.h>

static PerlInterpreter *my_perl;

main (int argc, char **argv, char **env)
{
    char *embedding[] = { "", "call.pl" };
    char *default_sub = "test_eval_begin_die";
    char *call_sub = (argc > 1) ? argv[1] : default_sub;

    fprintf(stderr, "Hello (successful end is Goodbye)\n");

    PERL_SYS_INIT3(&argc,&argv,&env);
    my_perl = perl_alloc();
    perl_construct( my_perl );

    perl_parse(my_perl, NULL, 3, embedding, NULL);
    PL_exit_flags |= PERL_EXIT_DESTRUCT_END;
    perl_run(my_perl);

    fprintf(stderr, "calling %s with G_EVAL | G_KEEPERR\n", call_sub);
    call_pv(call_sub, G_DISCARD | G_NOARGS | G_EVAL | G_KEEPERR);
    fprintf(stderr, " $@ = %s\n\n", SvPV_nolen(ERRSV));

    fprintf(stderr, "calling %s with no G*\n", call_sub);
    call_pv(call_sub, G_DISCARD | G_NOARGS);
    fprintf(stderr, " $@ = %s\n\n", SvPV_nolen(ERRSV));

    perl_destruct(my_perl);
    perl_free(my_perl);
    PERL_SYS_TERM();

    fprintf(stderr, "Goodbye\n");
    exit(0);
}

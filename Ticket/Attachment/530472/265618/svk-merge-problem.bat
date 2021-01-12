rem DOS batch script to reproduce the broken auto-merge problem
rem author: theultramage@gmail.com       date: 7.nov.2008

rem Procedure used:
rem 1. check out /trunk at the point where /branches/loginmerge branched off
rem 2. merge in the following revision from /loginmerge to /trunk (adds files)
rem 3. merge in the next revision from /loginmerge to /trunk (changes files)
rem 4. observe extensive damage done to the previously added files
rem    for example, see ea-depot/src/login/account.h, line 10

rem Last change was:
rem -AccountDB* account_db_sql(void);
rem +AccountDB* account_db_sql(bool case_sensitive);
rem
rem Expected outcome:
rem    AccountDB* account_db_sql(bool case_sensitive);
rem Instead got:
rem    AccountDB* accounbool case_sensitive_sql(void);

for /f %%i in ("%0") do set drive=%%~dpi
call svk depotmap ea %drive%ea-depot
call svk mirror http://svn.eathena.ws/svn/ea/ /ea/
call svk sync /ea/ --skipto 12410 --torev 12522
call svk checkout --floating -r 84 /ea/trunk ea-checkout
cd ea-checkout
call svk merge -c 86 /ea/branches/loginmerge .
call svk merge -c 114 /ea/branches/loginmerge .

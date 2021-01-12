#!/usr/bin/perl
#program-id. test01a.

package test01a;

use constant NO     => 0;
use constant YES    => 1;
use constant FALSE  => 0;
use constant TRUE   => 1;
use constant OFF    => 0;
use constant ON     => 1;
use cobol;
use bignum;
#INPUT-OUTPUT SECTION.

tie $w01_addition,            'cobol',1 ;
tie $w01_add,                 'cobol',5 ,'9(6)';
tie $w01_1,                   'cobol',5 ,'x';
tie $w01_add1,                'cobol',5 ,'9(6)';
tie $w01_2,                   'cobol',5 ,'x';
tie $w01_add2,                'cobol',5 ,'9(2)';
tie $w01_3,                   'cobol',5 ,'x';
tie $w01_add3,                'cobol',5 ,'9(6)';
tie $w01_4,                   'cobol',5 ,'x';
for($A=1;$A<=2;$A++)
{   tie $w01_addt[$A],        'cobol',5 ,'9(8)';
}
tie $w01_5,                   'cobol',5 ,'x';
tie $w01_add4,                'cobol',5 ,'s9(4)v9';
tie $w01_6,                   'cobol',5 ,'x';
tie $w01_add5,                'cobol',5 ,'s9(4)v9(2)';
tie $w01_7,                   'cobol',5 ,'x';
tie $w01_add6,                'cobol',5 ,'s9(4)v9(3)';
tie $w01_8,                   'cobol',5 ,'x';
tie $w01_add7,                'cobol',5 ,'s9(4)v9(4)';

tie $filler,                  'cobol',99;                   #---end of data definitions---;


#~~~~procedure division logic~~~~
&a_000;

sub a_000
{   &a_100;
}

sub a_100
{   $w01_addition = '0' x length($w01_addition);
    $w01_1 = ':';
    $w01_2 = ':';
    $w01_3 = ':';
    $w01_4 = ':';
    $w01_5 = ':';
    $w01_6 = ':';
    $w01_7 = ':';
    $w01_8 = ':';
    #DISPLAY "* ------ add statements tests begin ------ *".
    &cobol::display ($w01_addition);
    $w01_add = 10;
    &cobol::display ($w01_addition);
    $w01_add1 = 11;
    &cobol::display ($w01_addition);
    $w01_add2 = 98;
    &cobol::display ($w01_addition);
    $w01_add = $w01_add + 10;
    #DISPLAY "W01-ADD=" W01-ADD " W01-ADD1=" W01-ADD1 " W01-ADD2=" W01-ADD2.
    &cobol::display ($w01_addition);
    $w01_add = $w01_add + 1 + 2 + 3.5 + .5;
    $w01_add1 = $w01_add1 + 1 + 2 + 3.5;
    $w01_add2 = $w01_add2 + 1 + 2 + 3.5;
    if ($cobol::size_error) {
        &e_100;
    }
    if (!$cobol::size_error) {
        &d_100;
    }
    #DISPLAY "add 1 2 3.5 (6.5) TO W01-ADD = " W01-ADD
    #" rounded W01-ADD1 =" W01-ADD1 " W01-ADD2 =" W01-ADD2 " rounded".
    &cobol::display ($w01_addition);
    $w01_add = 98;
    &cobol::display ($w01_addition);
    $w01_add1 = 0;
    $w01_add2 = 0;
    $w01_add3 = 0;
    #DISPLAY "W01-ADD=" W01-ADD " W01-ADD1=" W01-ADD1 " W01-ADD2=" W01-ADD2 " W01-ADD3=" W01-ADD3.
    &cobol::display ($w01_addition);
    $w01_add1 = + 11 + 22 + 33.5 + $w01_add;
    $w01_add2 = + 11 + 22 + 33.5 + $w01_add;
    $w01_add3 = + 11 + 22 + 33.5 + $w01_add + .5;
    if (!$cobol::size_error) {
        &d_100;
    }
    &cobol::display ($w01_addition);
    #DISPLAY "add 11 22 33.5 (66.5) TO W01-ADD = " W01-ADD
    $w01_add4 = 1;
    $w01_add5 = 1;
    $w01_add6 = 1;
    $w01_add7 = 1;
    #DISPLAY "W01-ADD4=" W01-ADD4 " W01-ADD5=" W01-ADD5
    #" W01-ADD6=" W01-ADD6 " W01-ADD7=" W01-ADD7.
    &cobol::display ($w01_addition);
    $w01_add4 = - 28.36 - 11.69 - .05;
    $w01_add5 = - 28.36 - 11.69 - .005;
    $w01_add6 = - 28.36 - 11.69 - .0005;
    $w01_add7 = - 28.36 - 11.69 - .00005;
    #DISPLAY "add -28.36 to -11.69 giving W01-ADD4 = " W01-ADD4 " rounded"
    #" W01-ADD5 =" W01-ADD5 " rounded"
    #" W01-ADD6 =" W01-ADD6 " rounded"
    #" W01-ADD7 =" W01-ADD7 " rounded".
    &cobol::display ($w01_addition);
    $w01_add4 = 1;
    $w01_add5 = 1;
    $w01_add6 = 1;
    $w01_add7 = 1;
    #DISPLAY "W01-ADD4=" W01-ADD4 " W01-ADD5=" W01-ADD5
    #" W01-ADD6=" W01-ADD6 " W01-ADD7=" W01-ADD7.
    &cobol::display ($w01_addition);
    $w01_add4 = + 28.36 + 2 + 11.69 + .05;
    $w01_add5 = + 28.36 + 2 + 11.69;
    $w01_add6 = + 28.36 + 2 + 11.69;
    $w01_add7 = + 28.36 + 2 + 11.69;
    #DISPLAY "add 28.36 2 to 11.69 giving W01-ADD4 = " W01-ADD4
    #" rounded W01-ADD5 =" W01-ADD5
    #" W01-ADD6 =" W01-ADD6
    #" W01-ADD7 =" W01-ADD7.
    &cobol::display ($w01_addition);
    $w01_add5 = 11.69;
    &cobol::display ($w01_addition);
    $w01_add4 = 2;
    $w01_add6 = 2;
    $w01_add7 = 2;
    #DISPLAY "W01-ADD4=" W01-ADD4 " W01-ADD5=" W01-ADD5
    #" W01-ADD6=" W01-ADD6 " W01-ADD7=" W01-ADD7.
    #ADD 28.36 GIVING W01-ADD4 W01-ADD5 W01-ADD6 W01-ADD7
    &cobol::display ($w01_addition);
    $w01_add4 = + 28.36 + $w01_add5 + .05;
    $w01_add6 = + 28.36 + $w01_add5;
    $w01_add7 = + 28.36 + $w01_add5;
    if ($cobol::size_error) {
        &e_100;
    }
    if (!$cobol::size_error) {
        &d_100;
    }
    &cobol::display ($w01_addition);
}

#DISPLAY "add 28.36 W01-ADD5 = " W01-ADD5 " giving W01-ADD4 = " W01-ADD4
#" rounded W01-ADD6 =" W01-ADD6
#" W01-ADD7 =" W01-ADD7.
#DISPLAY "* ------ add statements tests end   ------ *".
sub d_100
{   
}

#DISPLAY "D-100: An add exception erorr has _NOT_ occured" .
sub e_100
    #DISPLAY "E-100: An add exception erorr has occured" .
{   
}


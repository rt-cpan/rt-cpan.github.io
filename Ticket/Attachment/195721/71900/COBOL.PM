#!/usr/bin/perl

package cobol;                          #cobol runtime package for perl...

#----------------------------------------------------------------------------------------
our $prog = 'COBOL.PM -- COBOL COMPILER/TRANSLATOR RUNTIME PACKAGE FOR PERL';
our $copy = 'Copyright (c) 2006 by C. Easton Beymer.  All rights reserved.';
our $vers = 'Version 0.1';
#----------------------------------------------------------------------------------------

#   to do list:
#       add more error reporting and better error mechanism
#       beef up pic processing with $,p,*,CR,DB,etc.
#       add comp-4 and possibly comp-5 types
#       try to access symbol table to get variable names for error messages
#           and to check for variable name duplication (except filler)
#           my guess is that this is not doable
#       see if possible to access line number being compiled for error reporting purposes
#           it would be easy to add line number to tie syntax (but messy)
#       minimize use of global variables

use constant NO     => 0;
use constant YES    => 1;
use warnings;
use strict;
use Win32::Console;
use bignum;

my $out;
my $buffer;         

use constant
{   DSP => 1,                           #numeric display
    C3  => 2,                           #comp-3 signed packed decimal
    C6  => 4,                           #comp-6 unsigned packed decimal
    C1  => 8,                           #comp-1 16 bit binary
    CMP => 16,                          #comp machine independent binary
    BWZ => 32,                          #blank when zero
    STC => 64,                          #sign trailing character
    STS => 128,                         #sign trailing separate
    SLC => 256,                         #sign leading character
    SLS => 512,                         #sign leading separate
    JR  => 1024,                        #justified right
    ALL => 2048,                        #'all' repetition
    REN => 4096                         #renames indicator
};

my $vn = 0;                             #global variable definitions
my $vx = 0;
my $gn = 0;
my $pn = 0;
my $time2 = NO;
my $r1 = 0;
my $r2 = 0;
my $n1 = 0;
my $n2 = 0;
my $n3 = 0;
my @groups = ();                        #data is stored here!
my @lev = ();                           #levels
my @len = ();                           #length of variable
my @off = ();                           #offset in group
my @pic = ();                           #picture
my @typ = ();                           #pic type
my @lit = ();                           #literal
my @grp = ();                           #var ptr into groups
my @bit = ();                           #var bit indicators
my @red = ();                           #ptr to redef var
my @glv = ();
my @val = ();                           #88 level values
my @var = ();                           #value reference
my @ref = ();                           #var ref for 88 lev
my $pix;
my $typx;
my $bits;
my $str;
my $num;
my $sign;
my $plvl = 0;
my $lgth;

our $length;                            #length of current variable
our $size_error;                        #this is the flag for '(not) on size error'
our $at_end;                            #this is the flag for '(not) at end'
our $invalid_key;                       #this is the flag for '(not) invalid key'

sub TIESCALAR
{   my ($cobol,$lvl,$pict,@rest) = @_;  #break out the tie list values
    my $litx = '';
    my $self = $vn;                     #cobol variable counter
    my ($nx,$ll,$rest);
    if ($time2 and ($lvl == 1 or $lvl == 77 or $lvl == 99)) {
        &offsets;                       #2nd level 01 (or 77) found - calc offsets/lengths
        &allocgrp;                      #allocate space for level 01 group
        $plvl = 0;
        return if ($lvl == 99);         #level 99 signals end of tie statements
    }
    if ($lvl == 1) {                    #initialize for following group definition
        $time2 = YES;                   #set second time thru switch
        $pn = $vn;                      #$pn marks the group's 01 variable index no
        @glv = ();
    }
    $lev[$vn] = $lvl;                   #move level into global array
    &leverr;                            #check for level number errors
    if ($lvl == 88) {                   #logic to deal with 88 level value storage
        die "88 level's initial value is missing\n" if (!$pict);
        $off[$vn] = $len[$vn] = 0;      #88 has no offset, length
        $ref[$vn] = $vx;                #ref back to level being referenced by 88
        @val = ();                      #always want an empty array
        $val[0] = $pict;                #pic is first value in 88 level
        foreach $rest(@rest)
        {   push @val,$rest;            #store each value in an array
        }
        $var[$vn] = @val;               #save array of values into two dim value array
        $vn++;                          #increment tied variable counter
        return bless \$self,$cobol;     #now 88 scalar is tied to an object!
    }
    $plvl = $lvl if ($lvl < 50);        #save off prev level for level error check
    $typ[$vn] = $typx = 'g';            #default type is group - no pic
    $grp[$vn] = $gn;                    #this group is stored in $groups[$gn]
    $off[$vn] = 0;                      #offset to be calc'd later
    $len[$vn] = 0;                      #length to be calc'd later
    $bits = 0;
    my $litc = 0;
    foreach $rest(@rest)                #set bits in an integer for various stuff
    {	if ($rest eq 'comp3') {$bits = $bits | C3}      #comp-3 signed packed decimal
        elsif ($rest eq 'comp6') {$bits = $bits | C6}   #comp-6 unsigned packed decimal
        elsif ($rest eq 'comp1') {$bits = $bits | C1}   #comp-1 16 bit binary
        elsif ($rest eq 'comp') {$bits = $bits | CMP}   #comp machine independent binary
        elsif ($rest eq 'bwz') {$bits = $bits | BWZ}    #blank when zero
        elsif ($rest eq 'stc') {$bits = $bits | STC}    #sign trailing
        elsif ($rest eq 'sts') {$bits = $bits | STS}    #sign trailing separate
        elsif ($rest eq 'slc') {$bits = $bits | SLC}    #sign leading
        elsif ($rest eq 'sls') {$bits = $bits | SLS}    #sign leading separate
        elsif ($rest eq 'just') {$bits = $bits | JR}    #justified right
        elsif ($rest eq 'all') {$bits = $bits | ALL}    #"all" repetition
        else  {$litx = $rest; $litc++}; #must be literal if keyword not found
    }
    die "Undefined keyword(s)\n" if ($litc > 1);
    $pix = $pict;
    if ($pix) {
        &picture;                       #do all kinds of neat stuff in picture
        $typ[$vn] = $typx;              #save type set in picture
        $len[$vn] = length($pix);       #save length of picture
        $pix = '' if ($typx eq 'an');   #pic not needed - just move to length
    }
    if ($typ[$vn] eq 'n' and !($bits & C1)
        and !($bits & C3) and !($bits & C6) and !($bits & CMP)) {
        $bits = $bits | DSP;            #display if not comp-x field
    }
    $bits = $bits | STS if ($bits & CMP);       #computational has a trailing sign
    #this sets sign trailing character (STC) as default if no sign clause passed here
    $bits = $bits | STC if ($sign and !($bits & STS) and !($bits & SLC) and !($bits & SLS));
    $bit[$vn] = $bits;                  #save variable attribute to array
    $typ[$vn] = 'ne' if ($bits & BWZ);  #blank when zero means numeric edited
    $str = $litx;
    &storeno if ($typx eq 'n'and $litc);#format numeric literal - sends/returns $str
    $litx = $str;
    $pic[$vn] = $pix;                   #save off modified picture
    if ($typx eq 'n') {                 #calc length of various numeric types
        $pix =~ s/s|v//g;               #remove sign and assumed dec pt chars
        $len[$vn] = length($pix);       #save length of numeric picture
        $len[$vn] = 2 if ($bits & C1);  #is it a 2 byte comp-1 field?
        $len[$vn] = ($len[$vn] >> 1) + 1 if ($bits & C3); #calc length of comp-3
        $len[$vn] = ($len[$vn] + 1) >> 1 if ($bits & C6); #calc length of comp-6
        $len[$vn]++ if ($sign and $bits & CMP);  #add 1 to length if signed comp type
        #add 1 to length if signed numeric display type and sign is leading/trailing separate
        $len[$vn]++ if ($sign and $bits & DSP and ($bits & SLS or $bits & STS));
        &makepix;                       #make numeric picture easier to use
    }
    if ($bits & ALL) {                  #'all' propagation of variable length of literal
    	$ll = length($litx);
    	$litx = $litx x ($len[$vn]/$ll+1);      #truncation of this will likely be needed
    }
    $ll = length($litx);                #following stuff forces length of lit to pic length
    $litx = substr($litx,0,$len[$vn]) if ($typx ne 'n' and $ll > 0 and $ll > $len[$vn]);
    $litx .= ($len[$vn]-$ll) x ' ' if ($typx ne 'n' and $ll > 0 and $ll < $len[$vn]);
    $lit[$vn] = $litx;                  #save off length corrected literal
    unshift @glv,$vn if ($typx eq 'g' and $lvl < 50);     #save ref to group levels
    &alloc77 if ($lvl == 77);           #allocate space for 77 lev item
    $vn++;                              #increment tied variable counter
    $vx = $vn;                          #$vx is last non 88 level counter
    return bless \$self,$cobol;         #now scalar is tied to an object!
}

sub leverr                              #make sure we have a valid level number
{   my $err = 0;
    return if ($lev[$vn] == 77 or $lev[$vn] == 1);
    if ($lev[$vn] == 66 or $lev[$vn] == 88) {
        die "No level number defined prior to 66 or 88 level definition\n" if ($vx == 0);
        return;
    }
    if ($lev[$vn] < $plvl) {
        my $ok = 0;
        foreach my $xx(@glv)            #level must have been previously used
        {   $ok = 1 if ($lev[$xx] == $lev[$vn] or $lev[$vn] == 1); }
        $err = 1 if (!$ok);
    }
    $err = 1 if ($lev[$vn] < 1 and $lev[$vn] > 49);
    $err = 1 if ($plvl == 0);           #level > 1 without previous level 1
    die "Invalid cobol level number: $lev[$vn]\n" if ($err);   #level number error
}

sub picture                             #process cobol picture
{  my (@tok,$paren,$no,$tokx,$lc,$pl,$type,$hol,$dec);
   @tok = $pix =~ m/(z+|x+|b+|a+|\$+|\*+|\d+|\(|\.|,|\-|\+|CR|DB|\/|s|v)/ig;
   $pix = $paren = '';
   $sign = 0;
   for ($no=0; $no<=$#tok; $no++)
   {   if ($paren eq '(')
       {   $tokx = ($lc)x($tok[$no]-1); #expand prefix (x,z,9,etc.) by no in parens - 1
           $pix = $pix.$tokx;           #build expanded picture
           $paren = '';
           next;
       }
       if ($tok[$no] eq '(')            #'(' found - next token equal to count in parens
       {   $paren = '(';
           next;
       }
       $sign = 1 if ($tok[$no] eq 's'); #signed field
       $pix = $pix.$tok[$no];           #build expanded picture
       $lc = chop $tok[$no];            #save last char of prev token
    }
    $typx = '';                         #what kind of data does pic represent?
    $type = $pix =~ m/b+|0+|\// if ($type);     #is it a valid 'ane'?
    $type = $pix =~ m/a+|x+/;
    $typx = 'ane' if ($type);
    return if ($typx);                  #alphanumeric edited found
    $type = $pix =~ m/z+|9+/;
    $type = $pix =~ m/b+|0+|\/|,|\.|\-/ if ($type);     #is is a valid 'ne'?
    $typx = 'ne' if ($type);
    return if ($typx);                  #numeric edited found
    $type = $pix =~ m/^s|9+|v/;         #is it a valid 'n'?
    $typx = 'n' if ($type);
    return if ($typx);                  #numeric edited found
    $typx = 'an';
    return;                             #alphanumeric catch all
}

sub makepix                             #make numeric picture easier to use
{   my ($sin,$hol,$dec);                #'s99999v99' = 's,5,2' or '999v99999' = 'u,3,5'
    $pix = $pic[$vn];
    $sin = $pix =~ m/^s/;               #is it a signed field
    $pix =~ s/^s// if ($sin);           #get rid of leading sign char
    ($hol,$dec) = split(/v/,$pix,2);    #split out whole num and dec num using 'v' sep
    $hol = length($hol);                #length of whole part
    $dec = length($dec) if ($dec);      #length of decimal part
    $dec = 0 if (!$dec);                #no decimal point detected
    $pix = 'u,';                        #leading @ tells that we have been here before
    $pix = 's,'if ($sin && $bits^C6);   #don't set sign if comp-6
    $pix = $pix.$hol.','.$dec;          #pix='s,5,2' -- s='s'or'u', 5=whole lgth, 2=dec pts
    $pic[$vn] = $pix;                   #update picture in $pic array
}                                   

sub offsets                             #fill in offsets and group lengths
{   my($soff,$xn,$gx,$gnp,$r1);
    #this area is tough to understand.  first an array of group levels was built above
    #in reverse order using unshift.  this allows the offsets and lengths to be built
    #from the bottom of the group up.  this allows corresponding higher group levels
    #to be populated with offsets and lengths until we end with the 01 group.
    foreach $gx(@glv)
    {   $gnp = $gx + 1;                 #if level=1, add up all level=2 (or level+1)
        #this is where the group length is calculated!
        $len[$gx] = 0;                  #start with zero length
        for ($xn=$gnp; $xn<=$#lev; $xn++)
        {   last if ($lev[$xn] <= $lev[$gx]);   #get out if at end of group
            $r1 = $red[$xn];
            next if ($r1);              #redefines not a part of length
            next if ($lev[$xn] == 88);  #level 88 not a part of length
            next if ($lev[$xn] != $lev[$gnp]);
            $len[$gx] = $len[$gx] + $len[$xn];  #calculate group length!
            #print "xn=$xn gx=$gx gnp=$gnp lev-xn=$lev[$xn] pix=$pic[$xn] ";
            #print "lev-gnp=$lev[$gnp] len-xn=$len[$xn] len-gx=$len[$gx]\n";
        }
    }
    for ($xn=$pn; $xn<$vn; $xn++)       #check redefines length
    {   $r1 = $red[$xn];
        next if (!$r1 or $bit[$r1] & REN);      #not a redefines - also skip renames
        die "Redefines length longer than redefined length!\n" if ($len[$xn]>$len[$r1]);
    }
    $soff = 0;
    for ($xn=$pn; $xn<$vn; $xn++)       #this area calculates offsets
    {   $r1 = $red[$xn];
        $soff = $off[$r1] if ($r1);
        $off[$xn] = $soff;              #set offset for this variable
        $soff = $soff + $len[$xn] if ($typ[$xn] ne 'g');
        #print "\nlev=$lev[$xn] $xn\n";
        #print "pic=$pic[$xn]\n" if ($typ[$xn] ne 'g');
        #print "off=$off[$xn]\n";
        #print "len=$len[$xn]\n";
        #print "lev=$lev[$xn] pic=$pic[$xn] off=$off[$xn] len=$len[$xn]\n";
    }
    @glv =();                           #done with glv array for the moment
}

sub alloc77                             #allocate working storage space - level 77
{   if ($lit[$vn] eq '') {
        $groups[$gn] = "\x00" x $len[$vn];      #alloc 77 item space - init to low values
    }
    else
    {   substr($groups[$gn],$off[$vn],$len[$vn]) = $lit[$vn];
        $lit[$vn] = '';                 #literal no longer needed - save some space
    }
    $gn++;                              #point at next group's storage
    $time2 = 0;                         #don't want to alloc 01 space after 77
    @glv = ();                          #make sure glv array initialzed after 77
}

sub allocgrp                            #allocate working storage space - level 01
{   #this allows the length of a 01 group being redefined to be increased by the
    #added length of the redefining 01 group as required in the cobol standard
    if ($r2 > 0) {
        if ($len[$r2] > $len[$r1]) {
    	    $groups[$gn] = $groups[$gn].("\x00" x ($len[$r2]-$len[$r1]));
        }
        $r1 = $r2 = 0;                  #reinitialize redefines indexes
        $gn++;                          #point at next group's storage
    	  return;
    }
    for (my $nx=$pn; $nx<$vn; $nx++)    #this allows for allocation of 01 space
    {   if ($lev[$nx] == 1 and $lit[$nx] eq '') {
            $groups[$gn] = "\x00" x $len[$nx];  #alloc group 01 - init to low values
        }
        else
        {   #print "lev=$lev[$nx] off=$off[$nx] len=$len[$nx]\n";
            #print "[$groups[$gn]][$len[$nx]][$gn]\n";
            substr($groups[$gn],$off[$nx],$len[$nx]) = $lit[$nx] if ($lit[$nx] ne '');
            #print "[$groups[$gn]\n";
            $lit[$nx] = '';             #literal no longer needed - save some space
        }
    }
    $r1 = $r2 = 0;                      #must redefine within scope of next 01 group
    $gn++;                              #point at next group's storage
}

sub redefines
{   my ($var2,$var1) = @_;              #get the requested object and data
    $r2 = $$var2;                       #get indexes into all the arrays
    $r1 = $$var1;
    die "Order error in redefines statement!\n" if (!($r2 > $r1));
    die "Redefines level mismatch - must be equal!\n" if ($lev[$r1] != $lev[$r2]);
    die "66 or 88 level not allowed in redefines!\n" if ($lev[$r2] == 66 or $lev[$r2] == 88);
    die "77 level redefinition length error!\n" if ($lev[$r2] == 77 and $len[$r2] > $len[$r1]);
    if ($lev[$r2] == 01 or $lev[$r2] == 77) {   #redefine previous group at 01 or 77 level
        $gn--;                          #point back at previous group 01
    	$grp[$r2] = $gn;                #update index to point at previous group
        return;
    }
    $red[$r2] = $r1;                    #save index of item being redefined
}

sub renames
{   my ($var3,$var1,$thru,$var2) = @_;  #get the requested object and data
    my $n3 = $$var3;                    #get index into all the arrays
    my $n1 = $$var1;
    my $n2 = $$var2;                    #add check for reference!
    $n2 = $n1 if ($thru ne 'thru');     #assume no renames thru parameter
    die "Renames statement must refer to 66 level!\n" if ($lev[$n3] != 66);
    die "Order error in renames statement!\n" if (!($n3 > $n2 and $n2 > $n1));
    for (my $x=$n1; $x<=$n2; $x++)      #determine length of area being renamed
    {   die "Invalid level number in renames!\n" if ($lev[$x] < 02 or $lev[$x] > 49);
        $len[$n3] = $len[$n3]+$len[$x]; #calc length of 66 item
    }
    $red[$n3] = $n1;                    #save index of first item being renamed
    $bit[$n1] = $bit[$n1] | REN;        #mark as a renames statement
}

sub FETCH                               #return cobol data into perl
{   my $self = shift;                   #get the requested object
    $vn = $$self;                       #get index into all the arrays
    $gn = $grp[$vn];                    #point at this variable's group area
    $str = substr($groups[$gn],$off[$vn],$len[$vn]);
    return $str if ($typ[$vn] eq 'an' or $typ[$vn] eq 'g'); #group or alphanumeric
    $pix = $pic[$vn];                   #set up pic for fetch number
    #print "fetch=$vn=[$pic[$vn]]$str,$groups[$gn],$off[$vn],$len[$vn]\n";
    if ($typ[$vn] eq 'ane') {           #alphanumeric edited
        &anepic;
        return $pix;
    }
     if ($typ[$vn] eq 'ne') {           #numeric edited
        &nepic;
        return $pix;
    }
     if ($typ[$vn] eq 'n') {            #numeric
        $bits = $bit[$vn];              #set up bits mask for use in fetch
        &fetchno;
        return $num;
    }
}

sub STORE                               #save perl data into cobol structure
{   my $self;
    ($self,$str) = @_;                  #get the requested object and data
    my $vn = $$self;                    #get index into all the arrays
    my $gn = $grp[$vn];
    my $li = length($groups[$gn]);      #beginning length of group
    #print "in STORE str=$str vn=$vn=$typ[$vn] $pic[$vn]\n";
    $pix = $pic[$vn];                   #set up pic for store number
    $bits = $bit[$vn];                  #set up bits mask for use in store
    &storeno if ($typ[$vn] eq 'n');     #only numerics get formatted prior to storing
    $str = ' ' if ($typ[$vn] eq 'ne' and ($bits & BWZ) and $str == 0);      #blank when zero
    my $sl = length($str);
    my $ln = $len[$vn];
    substr($groups[$gn],$off[$vn],$ln) = $str if ($sl == $ln);              #lengths match
    substr($groups[$gn],$off[$vn],$ln) = substr($str,0,$ln) if ($sl > $ln); #trunc length
    if ($sl < $ln) {
        if ($bits & JR)                 #justify right? (or left)
        {   substr($groups[$gn],$off[$vn],$ln) = (' 'x($ln-$sl)).$str;      #justified right
        }  
        else
        {   substr($groups[$gn],$off[$vn],$ln) = $str.(' 'x($ln-$sl));      #left pad spaces
        }  
    }
    my $lo = length($groups[$gn]);      #make sure that group length does not change
    die "Internal error - group length changed: in=$li out=$lo!\n" if ($li!=$lo);
    return;
}

sub nepic                               # transform decimal string using cobol pics
{   my ($nop,$min,$dec,$pxc,$off,$pl,$zux,$p,$pch,$nch,$len);
    #$num = '-12345678.123';
    #$pix = 'bbzzz,zzz,zzz.99-';
    #           12,345,678.12-
    $nop = ('0' x 18).'.'.('0' x 18);   #mask used to align the dec point
    $min = $num =~ m/-/;                #is it a negative number?
    $num =~ s/-//g;                     #remove minus sign from input no
    $len = length($num);
    $pix =~ s/-/\+/ if (!$min);         #set sign char to '+' if # not neg
    $dec = index $num,'.';              #find possible index of dec pt
    $dec = length $num if ($dec == -1); #use length if no dec pt
    substr($nop,18-$dec,$len) = $num;   #slap number into zero pattern
    $dec = index $pix,'.';              #find possible index of dec pt
    $dec = length $pix if ($dec == -1); #use length if no dec pt
    $pxc = substr($pix,0,$dec);         #grab whole # part of pic
    $pxc =~ s/,|-|b|s|\///g;            #leave only 9's and 'z's in pic
    $off = 18 - length($pxc);           #starting point in # string
    $nop =~ s/\.//;                     #get rid of period in mask
    $zux = NO;
    $pl = $lgth = length($pix);
    for ($p=0; $p<$pl; $p++)            #populate the picture with numbers
    {   $pch = substr($pix,$p,1);       #pull off chars one at a time
        #skip fill characters
        next if ($pch eq '/' or $pch eq '.' or $pch eq '-'
            or $pch eq 'b' or $pch eq '0' or $pch eq '+');
        $zux = YES if ($pch eq '9');    #no more zero suppression if 9 in pic
        #this gets rid of leading comma if blank to left
        substr($pix,$p,1) = 'b' if ($pch eq ',' and $zux == 0);
        next if ($pch eq ',');          #skip comma fill char
        $nch = substr($nop,$off,1);     #pull off numbers one at a time
        $zux = YES if ($nch ne '0');    #found number other than 0
        $nch = 'b' if (!$zux and $nch eq '0');
        substr($pix,$p,1) = $nch;       #insert the number into pic
        $off++;
    }
    $pix =~ s/b/ /g;                    #clean up b's (spaces) with real spaces
    $pix =~ s/\+/ /g;                   #remove trailing '+' if not negative
}

sub anepic                              # transform alphanumeric string using cobol pics
{   my ($pl,$sl,$p,$s,$pch);
    #$str = 'Easton Beymer is the real thing!';
    #$pix = 'xbxbxbxbxbxbxbxbxbxbxbxbxbxbxxxxxxxxx';
    #        E a s t o n   B e y m e r   is the re
    #must preserve actual 'b's in string while replacing pic 'b's with spaces
    $pix =~ s/b/\xff/g;                 #temporarily sub 'b's in pic with x'ff'
    $pl = $lgth = length $pix;          #get lengths of pic and string
    $sl = length $str;
    for ($p=$s=0; $p<$pl; $p++)         #populate the picture with characters
    {   $pch = substr($pix,$p,1);       #pull off chars one at a time
        #skip filler characters
        next if ($pch eq "\xff" or $pch eq '/' or $pch eq '0');
        #insert string char or space into picture
        substr($pix,$p,1) = substr($str,$s,1) if ($s<$sl);
        substr($pix,$p,1) = ' ' if ($s>=$sl);
        $s++;
    }
    $pix =~ s/\xff/ /g;                 #revert back to actual spaces
}

sub fetchno                             #fetch cobol number and move to perl number
{   my ($at,$sin,$hol,$dec,$neg,$os);
    if ($bits & C1) {                   #is it a comp-1 field?
        $num = unpack('s',$str);        #unpack 16 bit signed binary (comp-1) field
        return;
    }
    ($sin,$hol,$dec) = split(/,/,$pix,3);       #break up the modified numeric pic
    #print "$sin,$hol,$dec\n";
    $neg = NO;
    if ($bits & C3) {                   #process comp-3 field
        $str = unpack('H*',$str);       #unpack comp-3 field
        $neg = $str =~ m/(d|b)\z/;      #is it a comp-3 neg number - sign at end
        $str =~ s/[a-f]\z// if ($sin);  #get rid of sign at end of comp-3 string
    }
    $str = unpack('H*',$str) if ($bits & C6);   #unpack if it is a comp-6 field
    my $sl = $lgth = length($str);      #number of numbers in string
    if ($bits & CMP) {                  #process computational field
        $str =~ tr/[\x00-\x09]/[0-9]/;  #translate for example x'09' to x'39'
        if ($sin eq 's') {
            $neg = YES if (substr($str,$sl-1,1) eq'-');
            $str =~ s/\-|\+//;          #get rid of sign
            $sl = length($str);         #recalculate length
        }
    }
    if ($bits & DSP) {                  #handle various display sign options
        my $xt = 0;                     #$xt is offset of sign byte in string; SL,SLS = 0
        $xt = $sl - 1 if ($bits & STC or $bits & STS);   #ST,STS = last byte in string
        $at = substr($str,$xt,1);       #get sign byte from string
        if ($bits & SLC or $bits & STC) {
            $neg = YES if ($at gt '9'); #is neg sign bit set? i.e. x'49'=-9, x'39'=+9
            $at =~ tr/[@-I]/[0-9]/ if ($neg);   #get rid of neg bit
            substr($str,$xt,1) = $at;   #put pos no back in string
        }
        if ($bits & SLS or $bits & STS) {
            $neg = YES if ($at eq'-');  #is negative sign set?
            $str =~ s/\-|\+//g;         #get rid of all signs
            $sl = length($str);         #recalculate length
        }
    }
    $os = $sl - $hol - $dec;            #is there a char offset less than size?
    $num = substr($str,$os,$hol);       #grab whole number part of pic
    $num = $num.'.'.substr($str,$os+$hol,$dec) if ($dec > 0); #add dec pt, digits
    $num =~ s/^0*//;                    #get rid of leading zeroes
    $num = '-'.$num if ($sin eq 's' and $neg);  #add leading negative sign if neg number
    #print "fetch=$num\n";
    return;
}

sub storeno                             #store perl number into cobol number
{   my ($at,$sin,$hol,$dec,$sign,$os,$mask,$off,$nos);
    my ($lhol,$rdec,$len,$lmask,$rmask,$xmask);
    if ($bits & C1) {                   #is it a comp-1 field?
        $str = pack('s',$str);          #pack 16 bit signed binary (comp-1) field
        return;
    }
    ($sin,$hol,$dec) = split(/,/,$pix,3);
    $sign = substr($str,0,1);           #is there a leading neg sign character
    $sign = '+' if ($sign ne '-');      #if not neg, must be pos
    $str =~ s/-//;                      #get rid of negative sign
    ($lhol,$rdec) = split('\.',$str,2);  #split in whole number and decimal parts   
    $mask = $lmask = $rmask = '0' x 18; 
    if ($lhol) {
        $len = length($lhol);           #how many characters to move to left side
        $lmask = ('0' x (18-$len)).$lhol;        
    }
    if ($rdec) {
        $len = length($rdec);           #how many characters to move to right side
        $rmask = $rdec.('0' x (18-$len));        
    }
    $xmask = $lmask.$rmask;              #number imbedded in 36 digit mask
    #print "$xmask\n";
    $str = substr($xmask,18-$hol,$hol+$dec);    #place number in proper position in mask
    $nos = $hol + $dec;                 #nos is length of number
    #print "str=$str $nos\n";
    if ($bits & DSP) {                  #set display sign - trailing/leading/separate
        if ($sign eq '-' and (($bits & STC) or ($bits & SLC))) {
            $at = substr($str,$nos-1,1) if ($bits & STC);
            $at = substr($str,0,1) if ($bits & SLC);
            $at =~ tr/[0-9]/[@-I]/;
            substr($str,$nos-1,1) = $at if ($bits & STC);
            substr($str,0,1) = $at if ($bits & SLC);
        }
        $str = $sign.$str if ($bits & SLS);     #add leading sign
        $str = $str.$sign if ($bits & STS);     #add trailing sign
        #print "Str=$str\n";
        return;
    }
    if ($bits & CMP) {                  #build computational value
        $str = substr($mask,18-$hol,$nos);      #extract number from mask
        $str =~ tr/[0-9]/[\x00-\x09]/;  #translate for example x'39' to x'09'
        $str = $str.$sign if ($sin eq 's');     #append trailing sign if signed field
        return;
    }
    if ($bits & C3) {                   #set comp-3 trailing sign
        substr($mask,18-$hol+$nos,1) = 'C' if ($sin eq 's' and $sign ne '-');
        substr($mask,18-$hol+$nos,1) = 'D' if ($sin eq 's' and $sign eq '-');
        substr($mask,18-$hol+$nos,1) = 'F' if ($sin eq 'u');
        $off = $nos % 2;                #see if we have odd or even # of digits
        $str = substr($mask,18-$hol-1,$nos+2)if (!$off);
        $str = substr($mask,18-$hol,$nos+1) if ($off);
        $str = pack "H*",$str;
        return;
    }
    if ($bits & C6) {                   #set comp-6 field
        $off = $nos % 2;                #see if we have odd or even # of digits
        $str = substr($mask,18-$hol-1,$nos+1) if ($off);
        $str = substr($mask,18-$hol,$nos) if (!$off);
        $str = pack "H*",$str;
        return;
    }
}
                                    
sub consinit                             #initialize, allocate computer console
{   $out = new Win32::Console(STD_OUTPUT_HANDLE) || die;
}                                   
                                    
sub display                             #display to computer console
{   my @toks = @_;                  
	  #foreach my $tok(@toks)
    #{   $out->Write($tok, 0, 0);
    #}
    #$out->Display();
            print "[$groups[$gn]]\n";
}

sub accept                              #accept from computer console
{
}   
1;
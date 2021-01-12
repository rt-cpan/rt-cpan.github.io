#!perl -w
#Illustrate missing and duplicate date from localtime(). 
#Adding a days worth of seconds to epoch seconds and passing the result to localtime() does not always result in one day passing.
#Sometimes zero days pass (a date will be duplicated) and sometimes two days will pass (a date will be skipped).
#duplicates:  2014_11_02  2015_11_01  2016_11_06
#missing   :  2015_03_08  2016_03_13  2017_03_12 


#global initialization 
   use Time::Local;   #for localtime()

#print date for next 3 years or so 
   for (my $epochSecs=1412053200;  $epochSecs<1498885200;  $epochSecs+=(60*60*24) )
   {
      my ($day, $month, $year) = (localtime($epochSecs))[3..5];
      printf "day=%04d_%02d_%02d  epochSecs=$epochSecs\n", $year+1900, $month+1, $day; 
   } 


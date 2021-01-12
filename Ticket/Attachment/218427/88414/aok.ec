#include <include/rhlierr.h>
main ()
{
USTATUS status;
EXEC SQL BEGIN DECLARE SECTION
char code[6], surname[21];
char incode[6];
EXEC SQL END DECLARE SECTION;

EXEC SQL
  CONNECT;

strcpy(incode, "COMP");
if ( SQLCODE != UENORM)
  printf ("%s\n", ufchmsg(SQLCODE, &status));
else
  printf ("Connected to database\n");

EXEC SQL
  SELECT code, surname INTO :code, :surname FROM PUBLIC.Doctor
  WHERE code = :incode;

if ( SQLCODE != UENORM)
  printf ("%s\n", ufchmsg(SQLCODE, &status));
else
  printf ("Name: %s\n", surname);

}


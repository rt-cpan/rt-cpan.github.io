# My configuration:
# Eclipse 3.3
# EPIC 0.6.20
# Padwalker 1.7
# Win32::OLE 0.1707

# Error:
# Output from OLE LastError() is different (wrong), when using Debug AND
# "Show local variables". See my outputs below.

use strict;
use warnings;

my $VssTypeLibrary = 'Microsoft SourceSafe 6.0 Type Library';
use Win32::OLE 'valof';
use Win32::OLE::Const $VssTypeLibrary;  
use Win32::OLE::Enum;
use Win32::OLE::Variant;  

Win32::OLE->Option(Warn => 0,     # Don't print unrequested warnings.
                   Variant => 1); # Return variant instead of scalar.
my $VssDB = new Win32::OLE('SourceSafe')
  or die;
$VssDB->Open($ARGV[0], # Pathname to srcsafe.ini (Visual Source Safe database). 
             $ARGV[1], # User name.
             $ARGV[2]);# Password.             
print Win32::OLE->LastError(), "\n";

my $Item = $VssDB->VSSItem('$/abc');
print Win32::OLE->LastError(), "\n";

print $Item->Spec(), "\n";

my $Items = $VssDB->VSSItems('$/');
print Win32::OLE->LastError(), "\n";

exit; 

__END__;               
               
Output when using Run or Debug with "Show internal variables" disabled and a 
breakpoint on line 23 and then step over:
> 0
> 0
> $/abc
> Win32::OLE(0.1707) error 0x80020003: "Mitglied nicht gefunden"
>     in METHOD/PROPERTYGET ""


Output when using Debug with "Show internal variables" enabled and a breakpoint 
on line 23 and then step over:
> Win32::OLE(0.1707) error 0x8002000e: "Unzulässige Parameteranzahl"
>     in METHOD/PROPERTYGET "VSSItem"
> Win32::OLE(0.1707) error 0x8002000e: "Unzulässige Parameteranzahl"
>     in METHOD/PROPERTYGET "VSSItem"
> $/abc
> Win32::OLE(0.1707) error 0x8002000e: "Unzulässige Parameteranzahl"
>     in METHOD/PROPERTYGET "VSSItem"
Please note, that this output is not always reproducible, but it seems to 
dependent on the status of Eclipse/EPIC. However, the line '$/abc' indicates
clearly, that the OLE object is working correctly.
               
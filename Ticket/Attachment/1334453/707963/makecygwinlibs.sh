#!/bin/sh


function makelib {
    # echo EXPORTS > libsybct64.def
    # nm libsybct64.lib | grep ' T ' | grep -v '\.text$' | awk '{print $3}' >> libsybct64.def
    # dlltool --def libsybct64.def --dllname libsybct64.dll --output-lib libsybct64.a

    pathdllnameext=$1
    bitness=$2

    echo "Processing: $pathdllnameext file."

    pathlibnameext=${pathdllnameext//dll/lib}

    pathlibname=${pathlibnameext%/*}
    libnameext=${pathlibnameext##*/}
    libname=${libnameext%*.lib}

    #echo LIBRARY $libname > $libname.def
    echo EXPORTS > $libname.def
    if [ "$bitness" = "64" ] ; then
       nm $pathlibnameext | grep ' T ' | grep -v '\.text$' | awk '{print $3}' >> $libname.def
    else
       nm $pathlibnameext | grep 'T _' | sed 's/.* T _//' >>$libname.def
    fi

    dlltool --def $libname.def --dllname $libname.dll --output-lib $pathlibname/$libname.a -k
}

bits=`perl -MConfig -wE'say $Config{ptrsize}==8?"64":""'`

if [ "$bits" = "64" ] ; then bitness=64 ; else bitness=32 ; fi 
echo "Building $bitness bit libraries."

makelib `which libsybct$bits.dll` $bitness
makelib `which libsybcs$bits.dll` $bitness
makelib `which libsybblk$bits.dll` $bitness


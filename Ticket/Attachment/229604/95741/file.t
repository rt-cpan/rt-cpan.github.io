#!/usr/bin/perl -w
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

BEGIN { $|= 1; print "1..267\n"; }
END {print "not ok 1\n" unless $loaded;}
use Win32API::File qw(:ALL);
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

$test= 1;

use strict qw(subs);

$temp= $ENV{"TMP"};
$temp= $ENV{"TEMP"}	unless -d $temp;
$temp= "C:/Temp"	unless -d $temp;
$temp= "."		unless -d $temp;
$dir= "W32ApiF.tmp";

$ENV{WINDIR} = $ENV{SYSTEMROOT} if not exists $ENV{WINDIR};

chdir( $temp )
  or  die "# Can't cd to temp directory, $temp: $!\n";

if(  -d $dir  ) {
    print "# deleting $temp\\$dir\\*\n" if glob "$dir/*";

    for (glob "$dir/*") {
	chmod 0777, $_;
	unlink $_;
    }
    rmdir $dir or die "Could not rmdir $dir: $!";
}
mkdir( $dir, 0777 )
  or  die "# Can't create temp dir, $temp/$dir: $!\n";
print "# chdir $temp\\$dir\n";
chdir( $dir )
  or  die "# Can't cd to my dir, $temp/$dir: $!\n";

#Second variant - in Russian language, encoding Win-1251
my $r_cannotfindfile=qr/not find the file?|�� ������� ����� ��������� ����/i;
my $r_accessdenied=qr/access is denied?|�������� � �������/i;
my $r_fileexists=qr/file exists?|���� ����������/i;
my $r_invalidhandle=qr/handle is invalid?|�������� ����������/i;
my $r_permdenied=qr/permission denied/i;
my $r_alreadyexists=qr/file already exists?|���������� ������� ����, ��� ��� �� ��� ����������/i;
my $r_cannotcreate=qr/cannot create/i;
my $r_nosuchfile=qr/no such file|�� ������� ����� ��������� ����/i;

$h1= createFile( "ReadOnly.txt", "r", { Attributes=>"r" } );
$ok=  ! $h1  &&  fileLastError() =~ $r_cannotfindfile;
$ok or print "# ","".fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 2
if(  ! $ok  ) {   CloseHandle($h1);   unlink("ReadOnly.txt");   }

$ok= $h1= createFile( "ReadOnly.txt", "wcn", { Attributes=>"r" } );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 3

$ok= WriteFile( $h1, "Original text\n", 0, [], [] );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 4

$h2= createFile( "ReadOnly.txt", "rcn" );
$ok= ! $h2  &&  fileLastError() =~ $r_fileexists;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 5
if(  ! $ok  ) {   CloseHandle($h2);   }

$h2= createFile( "ReadOnly.txt", "rwke" );
$ok= ! $h2  &&  fileLastError() =~ $r_accessdenied;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 6
if(  ! $ok  ) {   CloseHandle($h2);   }

$ok= $h2= createFile( "ReadOnly.txt", "r" );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 7

$ok= SetFilePointer( $h1, length("Original"), [], FILE_BEGIN );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 8

$ok= WriteFile( $h1, "ly was other text\n", 0, $len, [] )
  &&  $len == length("ly was other text\n");
$ok or print "# <$len> should be <",
  length("ly was other text\n"),">: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 9

$ok= ReadFile( $h2, $text, 80, $len, [] )
 &&  $len == length($text);
$ok or print "# <$len> should be <",length($text),
  ">: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 10

$ok= $text eq "Originally was other text\n";
if( !$ok ) {
    $text =~ s/\r/\\r/g;   $text =~ s/\n/\\n/g;
    print "# <$text> should be <Originally was other text\\n>.\n";
}
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 11

$ok= CloseHandle($h2);
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 12

$ok= ! ReadFile( $h2, $text, 80, $len, [] )
 &&  fileLastError() =~ $r_invalidhandle;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 13

CloseHandle($h1);

$ok= $h1= createFile( "CanWrite.txt", "rw", FILE_SHARE_WRITE,
	      { Create=>CREATE_ALWAYS } );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 14

$ok= WriteFile( $h1, "Just this and not this", 10, [], [] );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 15

$ok= $h2= createFile( "CanWrite.txt", "wk", { Share=>"rw" } );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 16

$ok= OsFHandleOpen( "APP", $h2, "wat" );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 17

$ok=  $h2 == GetOsFHandle( "APP" );
$ok or print "# $h2 != ",GetOsFHandle("APP"),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 18

{   my $save= select(APP);   $|= 1;  select($save);   }
$ok= print APP "is enough\n";
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 19

SetFilePointer($h1, 0, [], FILE_BEGIN) if $^O eq 'cygwin';

$ok= ReadFile( $h1, $text, 0, [], [] );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 20

$ok=  $text eq "is enough\r\n";
if( !$ok ) {
    $text =~ s/\r/\\r/g;
    $text =~ s/\n/\\n/g;
    print "# <$text> should be <is enough\\r\\n>\n";
}
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 21

$skip = "";
if ($^O eq 'cygwin') {
    $ok = 1;
    $skip = " # skip cygwin can delete open files";
}
else {
    unlink("CanWrite.txt");
    $ok= -e "CanWrite.txt" &&  $! =~ $r_permdenied;
    $ok or print "# $!\n";
}
print $ok ? "" : "not ", "ok ", ++$test, "$skip\n"; # ok 22

close(APP);		# Also does C<CloseHandle($h2)>
## CloseHandle( $h2 );
CloseHandle( $h1 );

$ok= ! DeleteFile( "ReadOnly.txt" )
 &&  fileLastError() =~ $r_accessdenied;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 23

$ok= ! CopyFile( "ReadOnly.txt", "CanWrite.txt", 1 )
 &&  fileLastError() =~ $r_fileexists;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 24

$ok= ! CopyFile( "CanWrite.txt", "ReadOnly.txt", 0 )
 &&  fileLastError() =~ $r_accessdenied;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 25

$ok= ! MoveFile( "NoSuchFile", "NoSuchDest" )
 &&  fileLastError() =~ $r_cannotfindfile;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 26

$ok= ! MoveFileEx( "NoSuchFile", "NoSuchDest", 0 )
 &&  fileLastError() =~ $r_cannotfindfile;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 27

$ok= ! MoveFile( "ReadOnly.txt", "CanWrite.txt" )
 &&  fileLastError() =~ $r_alreadyexists;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 28

$ok= ! MoveFileEx( "ReadOnly.txt", "CanWrite.txt", 0 )
 &&  fileLastError() =~ $r_alreadyexists;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 29

$ok= CopyFile( "ReadOnly.txt", "ReadOnly.cp", 1 )
 &&  CopyFile( "CanWrite.txt", "CanWrite.cp", 1 );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 30

$ok= ! MoveFileEx( "CanWrite.txt", "ReadOnly.cp", MOVEFILE_REPLACE_EXISTING )
 &&  fileLastError() =~ /$r_accessdenied|$r_cannotcreate/i;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 31

$ok= MoveFileEx( "ReadOnly.cp", "CanWrite.cp", MOVEFILE_REPLACE_EXISTING );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 32

$ok= MoveFile( "CanWrite.cp", "Moved.cp" );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 33

$ok= ! unlink( "ReadOnly.cp" )
 &&  $! =~ $r_nosuchfile
 &&  ! unlink( "CanWrite.cp" )
 &&  $! =~ $r_nosuchfile;
$ok or print "# $!\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 34

$ok= ! DeleteFile( "Moved.cp" )
 &&  fileLastError() =~ $r_accessdenied;
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 35

system( "attrib -r Moved.cp" );

$ok= DeleteFile( "Moved.cp" );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 36

$new= SEM_FAILCRITICALERRORS|SEM_NOOPENFILEERRORBOX;
$old= SetErrorMode( $new );
$renew= SetErrorMode( $old );
$reold= SetErrorMode( $old );

$ok= $old == $reold;
$ok or print "# $old != $reold: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 37

$ok= ($renew&$new) == $new;
$ok or print "# $new != $renew: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 38

$ok= @drives= getLogicalDrives();
$ok && print "# @drives\n";
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 39

$ok=  $drives[0] !~ /^[ab]/  ||  DRIVE_REMOVABLE == GetDriveType($drives[0]);
$ok or print "# ",DRIVE_REMOVABLE," != ",GetDriveType($drives[0]),
  ": ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 40

$drive= substr( $ENV{WINDIR}, 0, 3 );

$ok= 1 == grep /^\Q$drive\E/i, @drives;
$ok or print "# No $drive found in list of drives.\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 41

$ok= DRIVE_FIXED == GetDriveType( $drive );
$ok or print
  "# ",DRIVE_FIXED," != ",GetDriveType($drive),": ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 42

$ok=  GetVolumeInformation( $drive, $vol, 64, $ser, $max, $flag, $fs, 16 );
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 43
$vol= $ser= $max= $flag= $fs= "";	# Prevent warnings.

chop($drive);
$ok= QueryDosDevice( $drive, $dev, 80 );
$ok or print "# $drive: ",fileLastError(),"\n";
if( $ok ) {
    ( $text= $dev ) =~ s/\0/\\0/g;
    print "# $drive => $text\n";
}
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 44

$bits= GetLogicalDrives();
$let= 25;
$bit= 1<<$let;
while(  $bit & $bits  ) {
    $let--;
    $bit >>= 1;
}
$let= pack( "C", $let + unpack("C","A") ) . ":";
print "# Querying undefined $let.\n";

$ok= DefineDosDevice( 0, $let, $ENV{WINDIR} );
$ok or print "# $let,$ENV{WINDIR}: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 45

$ok=  -s $let."/Win.ini"  ==  -s $ENV{WINDIR}."/Win.ini";
$ok or print "# ", -s $let."/Win.ini", " vs. ",
  -s $ENV{WINDIR}."/Win.ini", ": ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 46

$ok= DefineDosDevice( DDD_REMOVE_DEFINITION|DDD_EXACT_MATCH_ON_REMOVE,
		      $let, $ENV{WINDIR} );
$ok or print "# $let,$ENV{WINDIR}: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 47

$ok= ! -f $let."/Win.ini"
  &&  $! =~ $r_nosuchfile;
$ok or print "# $!\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 48

$ok= DefineDosDevice( DDD_RAW_TARGET_PATH, $let, $dev );
if( !$ok  ) {
    ( $text= $dev ) =~ s/\0/\\0/g;
    print "# $let,$text: ",fileLastError(),"\n";
}
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 49

$ok= -f $let.substr($ENV{WINDIR},3)."/win.ini";
$ok or print "# ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 50

$ok= DefineDosDevice( DDD_REMOVE_DEFINITION|DDD_EXACT_MATCH_ON_REMOVE
		     |DDD_RAW_TARGET_PATH, $let, $dev );
$ok or print "# $let,$dev: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 51

my $path = $ENV{WINDIR};
my $attrs = GetFileAttributes( $path );
$ok= $attrs != INVALID_FILE_ATTRIBUTES;
$ok or print "# $path gave invalid attribute value, attrs=$attrs: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 52

$ok= ($attrs & FILE_ATTRIBUTE_DIRECTORY);
$ok or print "# $path not a directory, attrs=$attrs: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 53

$path .= "/win.ini";
$attrs = GetFileAttributes( $path );
$ok= $attrs != INVALID_FILE_ATTRIBUTES;
$ok or print "# $path gave invalid attribute value, attrs=$attrs: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 54

$ok= !($attrs & FILE_ATTRIBUTE_DIRECTORY);
$ok or print "# $path is a directory, attrs=$attrs: ",fileLastError(),"\n";
print $ok ? "" : "not ", "ok ", ++$test, "\n";	# ok 55

#	DefineDosDevice
#	GetFileType
#	GetVolumeInformation
#	QueryDosDevice
#Add a drive letter that points to our temp directory
#Add a drive letter that points to the drive our directory is in

#winnt.t:
# get first drive letters and use to test disk and storage IOCTLs
# "//./PhysicalDrive0"
#	DeviceIoControl

my %consts;
my @consts= @Win32API::File::EXPORT_OK;
@consts{@consts}= @consts;

my( @noargs, %noargs )= qw(
  attrLetsToBits fileLastError getLogicalDrives GetLogicalDrives );
@noargs{@noargs}= @noargs;

foreach $func ( @{$Win32API::File::EXPORT_TAGS{Func}} ) {
    delete $consts{$func};
    if(  defined( $noargs{$func} )  ) {
	$ok=  ! eval("$func(0,0)")  &&  $@ =~ /(::|\s)_?${func}A?[(:\s]/;
    } else {
	$ok=  ! eval("$func()")  &&  $@ =~ /(::|\s)_?${func}A?[(:\s]/;
    }
    $ok or print "# $func: $@\n";
    print $ok ? "" : "not ", "ok ", ++$test, "\n";
}

foreach $func ( @{$Win32API::File::EXPORT_TAGS{FuncA}},
                @{$Win32API::File::EXPORT_TAGS{FuncW}} ) {
    $ok=  ! eval("$func()")  &&  $@ =~ /::_?${func}\(/;
    delete $consts{$func};
    $ok or print "# $func: $@\n";
    print $ok ? "" : "not ", "ok ", ++$test, "\n";
}

foreach $const ( keys(%consts) ) {
    $ok= eval("my \$x= $const(); 1");
    $ok or print "# Constant $const: $@\n";
    print $ok ? "" : "not ", "ok ", ++$test, "\n";
}

chdir( $temp );
if (-e "$dir/ReadOnly.txt") {
    chmod 0777, "$dir/ReadOnly.txt";
    unlink "$dir/ReadOnly.txt";
}
unlink "$dir/CanWrite.txt" if -e "$dir/CanWrite.txt";
rmdir $dir;

__END__

use constant ( EXCEPTION_CONTINUE_EXECUTION => 0xffffffff );
use Win32::API qw( ReadMemory );
use Win32::API::Callback;
use Data::Dumper;
$Data::Dumper::Useqq = 1;

my $AddVectoredExceptionHandler = Win32::API->new('kernel32.dll', 'AddVectoredExceptionHandler', 'IK', 'N');
die "bad AddVectoredExceptionHandler" if ! $AddVectoredExceptionHandler;
my $RemoveVectoredExceptionHandler = Win32::API->new('kernel32.dll', 'RemoveVectoredExceptionHandler', 'N', 'I');
die "bad RemoveVectoredExceptionHandler" if ! $RemoveVectoredExceptionHandler;
my $RaiseException = Win32::API->new('kernel32.dll', 'RaiseException', 'IIIN', 'V');
die "bad RaiseException" if ! $RaiseException;
$cb = Win32::API::Callback->new(sub {
    #not 64bit compliant
    my $pExceptionInfo = ReadMemory($_[0], 8);
    my ($pExceptionRecord, $pContextRecord) = unpack('LL', $pExceptionInfo);
    my $ContextRecord = ReadMemory($pContextRecord, 716);
    print Dumper($ContextRecord);
    return EXCEPTION_CONTINUE_EXECUTION;
},
'N', 'i');
die "bad CB" if ! $cb;

my $VHHnd;
die "AddVectoredExceptionHandler failed" if ! ($VHHnd = $AddVectoredExceptionHandler->Call(1, $cb));
$RaiseException->Call(0,0,0,0);
die "RemoveVectoredExceptionHandler failed" if ! $RemoveVectoredExceptionHandler->Call($VHHnd);
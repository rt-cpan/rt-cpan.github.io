use POE; # needed to import the KERNEL and OBJECT constants
use POE::Wheel::ReadWrite;
use POE::Driver::SysRW;
use POE::Filter::Line;

POE::Session->create
(
    'inline_states' => 
    {
        '_start' => \&receive_cmd_child,
        '_stop' => \&input_fail,
        'User_Input' => \&user_input,
        'Input_Shutdown' => \&input_shutdown,
        'Input_Fail' => \&input_fail,
    },
);

$poe_kernel->run;
exit 0;

  
sub receive_cmd_child
{
    print "receive_cmd_child\n";
    my $heap = $_[HEAP];
    $heap->{readwrite} = POE::Wheel::ReadWrite->new
    (
        InputHandle     => \*STDIN,
        OutputHandle    => \*STDOUT,
        Driver          => POE::Driver::SysRW->new(),
        Filter          => POE::Filter::Line->new(),
        InputEvent      => User_Input,
        ErrorEvent      => Input_Fail,
        FlushedEvent    => Input_Shutdown
    );
    print "child_event end\n";
}


sub input_shutdown 
{
    delete $_[HEAP]->{readwrite} if ($_[HEAP]->{shutdown_now});
}

sub user_input 
{
    print "USER EVENT\n";
    my ($heap, $buf) = @_[HEAP, ARG0];
    print "buf=$buf\n";
    $heap->{readwrite}->put($buf);
    $heap->{shutdown_now} = 1 if ($buf eq "!");
}

sub input_fail 
{
    delete $_[HEAP]->{readwrite};
}



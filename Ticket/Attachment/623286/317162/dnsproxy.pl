#!/usr/bin/perl -w
# Author: Radek Wierzbicki (radekw13@users.sourceforge.net)
# License: Perl Artistic License

use strict qw(vars);
use warnings;
use Carp;
use IO::File;
use POSIX qw(setsid WIFEXITED WEXITSTATUS);
use Net::DNS;
use Net::DNS::Nameserver;
use Config::XPath;
use Getopt::Long qw($REQUIRE_ORDER $PERMUTE $RETURN_IN_ORDER);
use Error qw(:try);
#use Data::Dumper;
use Config::XPath::Exception;
use Carp::Heavy;
use Net::DNS::RR::A;
use Net::DNS::RR::NS;
use vars qw($opt_config $opt_nodmn $opt_verb);

##############################
my $_resolvers  = {};
my $_nameserver = undef;
my $_logfile;
my $_pidfile;
my $_uid;
my $_gid;
my $_verbosity;
my $_daemon;
my $_version = '1.0 beta';

use constant DEBUG => 2;
use constant INFO  => 1;
use constant ERROR => 0;

##############################
if (!Getopt::Long::GetOptions(
        'config|c=s'    => \$opt_config,
        'nodaemon|n'    => \$opt_nodmn,
        'verbosity|v=s' => \$opt_verb,
        'start|d'       => \&daemon_start,
        'stop|k'        => \&daemon_stop,
        'status'        => \&daemon_status,
        'help|h'        => \&help,
        'version'       => \&version,
    )
    ) {
    &help();
}

read_config(1);
if ($opt_nodmn) {
    dnsproxy();
} else {
    daemon_start();
}

##############################
sub dnsproxy {
    $SIG{INT}  = \&exit_nicelly;
    $SIG{QUIT} = \&exit_nicelly;
    if ($< != 0) {
        croak("must be started as root");
    }
    chown($_uid, $_gid, $_logfile);
    if ($opt_nodmn) {
        log_entry(INFO, 'Starting DNSProxy');
    }
    if (defined($_nameserver)) {
        log_entry(DEBUG, 'starting main loop');
        POSIX::setuid($_uid);
        $_nameserver->main_loop;
    } else {
        croak('nameserver object not created');
    }
    exit(0);
}

##############################
sub reply_handler {
    my ($qname, $qclass, $qtype, $peerhost) = @_;
    log_entry(DEBUG, 'entering reply handler');
    my ($rcode, @ans, @auth, @add);
    my $answer;
    my $def_rname = '';
    my $resolver  = undef;
    log_entry(INFO, "Request: $qname");
    my %candidates;
    foreach my $r (keys(%{$_resolvers})) {
        if ($_resolvers->{$r}->{'default'}) {
            $def_rname = $r;
            next;
        }
        my $trigger = $_resolvers->{$r}->{'trigger'};
        if (my ($matched) = $qname =~ m/($trigger)/) {
            log_entry(DEBUG, "resolver $r matched $matched");
            $candidates{$matched} = $r;
        }
    }
    my ($rname) =
      map {$candidates{$_}}
        sort {length($b) <=> length($a)}
          keys %candidates;
    if (defined($rname)) {
        log_entry(DEBUG, "resolver $rname will be used");
        $resolver = $_resolvers->{$rname}->{'resolver'};
    } else {
        log_entry(DEBUG, "default resolver $def_rname will be used");
        $rname    = $def_rname;
        $resolver = $_resolvers->{$rname}->{'resolver'};
    }
    $answer = $resolver->send($qname, $qtype, $qclass);
    if ($answer) {
        $rcode = $answer->header->rcode;
        @ans   = $answer->answer;
        @auth  = $answer->authority;
        @add   = $answer->additional;
        log_entry(INFO, "Response from $rname: $qname $rcode");
        return ($rcode, \@ans, \@auth, \@add);
    }
    $rcode = "NXDOMAIN";
    return ($rcode, \@ans, \@auth, \@add);
}

##############################
sub read_config {
    my ($init) = @_;
    my $block;
    my $cfg_file;
    if (defined($opt_config) and (-f $opt_config)) {
        $cfg_file = $opt_config;
    } elsif (-f $ENV{'HOME'} . "/.dnsproxy.conf") {
        $cfg_file = $ENV{'HOME'} . "/.dnsproxy.conf";
    } elsif (-f '/etc/dnsproxy.conf') {
        $cfg_file = '/etc/dnsproxy.conf';
    } else {
        croak('config file not found');
    }
    my $config = Config::XPath->new( filename => $cfg_file );
    
    my $el = $config->get_sub('//daemon');
    my $logfile = read_attr($el, 'log');
    my $pidfile = read_attr($el, 'pid');
    my $user    = read_attr($el, 'user');
    my $group   = read_attr($el, 'group');
    my $verb    = read_attr($el, 'verbosity');
    $_logfile = $logfile ? $logfile                : '/var/log/dnsproxy.log';
    $_pidfile = $pidfile ? $pidfile                : '/var/run/dnsproxy.pid';
    $_uid     = $user    ? scalar(getpwnam($user)) : scalar(getpwnam('nobody'));
    $_gid     = $group  ? scalar(getgrnam($group)) : scalar(getgrnam('nobody'));
    $_verbosity = defined($opt_verb) ? $opt_verb : ($verb ? $verb : INFO);
    if (($_verbosity < 0) or ($_verbosity > 2)) {
        my $err = 'verbosity must be an integer between 0 and 2';
        log_entry(ERROR, $err);
        croak($err);
    }
    
    if (!defined($init)) {
        return;
    }

    $el = $config->get_sub('//nameserver');
    my $iface     = read_attr($el, 'interface');
    my $port      = read_attr($el, 'port');
    my $verbosity = read_attr($el, 'verbosity');

    $_nameserver = Net::DNS::Nameserver->new(
        LocalAddr => $iface ? $iface : '127.0.0.1',
        LocalPort => $port  ? $port  : 53,
        ReplyHandler => \&reply_handler,
        Verbose      => $verbosity ? $verbosity : 0,
    );
    if (!defined($_nameserver)) {
        my $err = 'could not create nameserver object';
        log_entry(ERROR, $err);
        croak($err);
    }

    my $default_resolver = undef;
    foreach my $el ($config->get_sub_list('//resolver')) {
        my $rname = read_attr($el, 'name');
        $_resolvers->{$rname} = {};
        $_resolvers->{$rname}->{'trigger'} = read_attr($el, 'trigger');
        if (read_attr($el, 'default')) {
            log_entry(DEBUG, "resolver $rname is default");
            $_resolvers->{$rname}->{'default'} = 1;
            $default_resolver = $rname;
        }
        my @nameservers = split (" ", read_attr($el, 'nameserver')||'');
        my @searchlist  = split (" ", read_attr($el, 'searchlist')||'');
        my $tcp         = read_attr($el, 'tcp');
        my $to          = read_attr($el, 'timeout');
        my $dbg         = read_attr($el, 'debug');

        my $resobj = Net::DNS::Resolver->new(
            nameservers => \@nameservers,
            searchlist  => \@searchlist,
            usevc       => ($tcp && $tcp ne 'false') ? $tcp : 0,
            tcp_timeout => $to ? $to : 5,
            udp_timeout => $to ? $to : 5,
            debug       => $dbg ? $dbg : 0,
        );
        if (!defined($resobj)) {
            my $err = 'could not create resolver object';
            log_entry(ERROR, $err);
            croak($err);
        } else {
            $_resolvers->{$rname}->{'resolver'} = $resobj;
        }
    }
    if (!defined($default_resolver)) {
        my $err = 'default resolver not defined';
        log_entry(ERROR, $err);
        croak($err);
    }


    #print Dumper(\$_resolvers);
}


sub read_attr {
    my $el = shift; # should be a Config::XPath object
    my $attr = shift;
    
    my $res;
    my $path = '@'.$attr;
    try {
	$res = $el->get_string($path);
    } catch Config::XPath::ConfigNotFoundException with {
	# ingore non-existing attributes
    };
      
    return $res;
}

##############################
##############################
sub daemon_start {
    read_config(1);
    log_entry(DEBUG, 'staring DNSProxy as daemon');
    my $pid;
    if (is_running()) {
        exit(0);
    }
    if (!defined($pid = fork())) {
        croak("could not fork: $!");
    } elsif ($pid) {
        write_pid($pid);
        log_entry(INFO, "DNSProxy started (pid: $pid)");
        exit(0);
    } else {
        open(STDIN,  '/dev/null')  or die "Can't read /dev/null: $!";
        open(STDOUT, '>/dev/null') or die "Can't write to /dev/null: $!";
        open(STDERR, '>/dev/null') or die "Can't write to /dev/null: $!";
        POSIX::setsid() or die "Can't start a new session: $!";
        dnsproxy();
    }
    exit(0);
}

##############################
sub daemon_stop {
    read_config();
    my $pid   = is_running();
    my $count = 0;
    if ($pid) {
        while (kill(INT, $pid)) {
            sleep(1);
            $count++;
            if ($count == 3) {
                kill(KILL, $pid);
                log_entry(WARN, 'INT failed! sending KILL');
                last;
            }
        }
    }
    exit(0);
}

##############################
sub daemon_status {
    read_config();
    my $pid = is_running();
    if ($pid) {
        print("DNSProxy running\n");
        exit(0);
    } else {
        print("DNSProxy stopped\n");
        exit(1);
    }
}

##############################
sub exit_nicelly {
    log_entry(INFO, "DNSProxy stopped");
    exit(0);
}

##############################
sub write_pid {
    my $pid = $_[0];
    my $fh = IO::File->new($_pidfile, 'w');
    if (defined($fh)) {
        flock($fh, 2);
        print $fh $pid;
        $fh->close();
    } else {
        croak('could not write pid');
    }
    return $pid;
}

##############################
sub read_pid {
    my $pid = 0;
    my $fh = IO::File->new($_pidfile, 'r');
    if (defined($fh)) {
        flock($fh, 2);
        while (<$fh>) {
            $pid = $_;
            $pid =~ s/\s//g;
            last if ($pid);
        }
        $fh->close();
    }
    return $pid;
}

##############################
sub is_running {
    my $pid = read_pid();
    if ((!$pid) or ($pid == 0)) {
        return 0;
    }
    if (open(PS, "ps -p $pid 2>/dev/null|")) {
        while (<PS>) {
            s/^\s+//;
            return $pid if (/$pid/);
        }
        close(PS);
    }
    return 0;
}

##############################
sub log_entry {
    my ($level, $txt) = @_;
    return if ($level > $_verbosity);
    my @levels = qw(ERRR INFO DEBG);
    my $logtxt = $levels[$level] . ": $txt\n";
    if ($opt_nodmn) {
        print($logtxt);
    }
    my $fh = new IO::File($_logfile, 'a');
    if (defined($fh)) {
        flock($fh, 2);
        print $fh scalar(localtime()) . " " . $logtxt;
        $fh->close();
    } else {
        print("cannot write\n");
    }
}

##############################
sub help {
    print <<EOF
Usage:
$0
  --config -c CONFIG_FILE
  --noademon -n
  --verbosity -v 0|1|2
  --start -d
  --stop -k
  --status
  [--help -h]

EOF
        ;
    exit(2);
}

##############################
sub version {
    print("DNSProxy $_version\n");
    exit(0);
}

##############################

# -*-perl-*-
# vim:ai:et:ts=4:sw=4

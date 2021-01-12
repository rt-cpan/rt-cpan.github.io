#!/usr/bin/perl -w

use strict;
use ExtUtils::MakeMaker;
use Data::Dumper;

my %Default_Config = (
    warn_about_root     => 1,
    deny_root           => 0,
);
my %Config = ();

%Config = load_config();

deny_root();
warn_about_root();
reconfigure_for_non_root();
print "(the CPAN shell will now run)\n";


sub deny_root {
    return if !$Config{deny_root} or $> != 0;

    my $ans = prompt(<<'END', "no");
The CPAN shell has been configured to not run as root as it is
a security risk.  You should run it as a normal user.

If you want to change this (we recommed you don't) set "deny_root" to
0 in the CPAN shell.

Do you want to continue running as root?
END

    if( $ans =~ /^y/i ) {
        print "\n(the shell would run now)\n";
        exit;
    }
    else {
        print <<'END';

The CPAN shell will now exit.  Please re-run it as a non-root user.
END
        exit;
    }
}

sub warn_about_root {
    return if !$Config{warn_about_root} or $> != 0;

    my $ans = prompt(<<'END', "yes");
I see you're running the CPAN shell as root.

This is not advisable as it means all commands will be run as root
including extraction, configuration, build, testing and installation
of CPAN modules.  This is a security risk, as well as running the risk
that a poorly written test will run wild and delete all your files.

Only the installation need be run as root.  CPAN can do this for you
using "sudo" or "su".

Would you like CPAN to reconfigure itself to run as a normal user and
use sudo for installs?
END

    if( $ans =~ /^y/i ) {
        print <<'END';

This program will now exit.  You should rerun the CPAN shell again as
a normal user and we'll go through the process of reconfiguring.
END

        $Config{reconfigure_for_non_root} = 1;
    }
    else {
        print <<'END';

Ok, we won't bug you about this again.
(at this point the CPAN shell would run)
END
        $Config{warn_about_root} = 0;
    }

    exit;
}


sub reconfigure_for_non_root {
    return if !$Config{reconfigure_for_non_root};

    $Config{get_super} = prompt(<<'END', "sudo");
We'll now reconfigure the CPAN shell to run correctly as your current user.

What command should the CPAN shell use to get root?
(Probably "sudo" or "su root -c")
END

    print "\n\n(run a simple program here to test $Config{get_super})\n";

    system "$Config{get_super} $^X -wle 'chown $>, -1, q[cpan_root_detect.config];'";

    my $ans = prompt(<<'END', "yes");

Your CPAN build and configuration files and directories are probably
owned by root.  This will cause problems for the CPAN shell, so they
should have their ownership changed to be owned by this user.

Would you like me to do that now?
(If you say no, things might not work correctly and you'll probably
have to do it by hand later)
END

    if( $ans =~ /^y/i ) {
        print <<'END';

(at this point CPAN would use sudo and chown to change the ownership)
of everything in .cpan and CPAN::MyConfig)
END
    }

    $ans = prompt(<<'END', "yes");

Would you like the CPAN shell to warn if it is run as root in the future?
END

    if( $ans =~ /^y/i ) {
        $Config{deny_root} = 1;
    }

    $Config{reconfigure_for_non_root} = 0;

    print <<'END';

Ok, everything should be ready to go!
(at this point the CPAN shell would run)
END

    exit;
}


sub save_config {
    my $dumper = Data::Dumper->new([\%Config]);
    $dumper->Indent(1)->Terse(1);
    my $dump = $dumper->Dump;

    open my $fh, ">cpan_root_detect.config" or die $!;
    print $fh $dump;
    print "Saving config: ", $dump;
}

sub load_config {
    return %Default_Config unless -e "cpan_root_detect.config";

    open my $fh, "cpan_root_detect.config" or die $!;
    my $config = eval join "", <$fh>;
    die $@ if $@;
    return %$config;
}

END {
    save_config();
}

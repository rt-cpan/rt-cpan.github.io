#!/usr/bin/perl
# gvim=:SetNumberAndWidth 

use warnings; use strict;
$ENV{PERL_HASH_SEED} = 0;
use utf8;
use FindBin qw($Bin); $FindBin::Bin =~ s{/bin/lib/?$}{/bin};
use lib "$FindBin::Bin/lib";
use lib "$ENV{HOME}/bin/lib";
use Carp::Always;

use mem &{ sub() { select((select(1),$|=1)[0]) }};	#perlbest prac.

use constant process_deletes => 1;
use constant save_intermediate => 0;
use constant default_scale_down => 4.0/3;

use mro;
use P; use PathCat qw(Sep);
use Dbg;
package Posix;use POSIX;package main;
#use ErrHandler;

use Time::HiRes @Time::HiRes::EXPORT_OK;

use CompVer;
use RecycleBin;


################################################################################
{ package TraceLog;
	use warnings; use strict;
	use mem;
	our @EXPORT;
	sub Trace($;@) {undef};		# null action (tracing disabled)
	use mem (@EXPORT=qw(Trace));
	use Xporter;
1;
}

################################################################################
{ package DDump;		## for data marshalling (not for debugging)
	use warnings; use strict;
	use mem;
	use Data::Dumper;

	sub SDump ($;$$) {		#String Dump
		my ($vars, $labels, $indent_level) = @_;
		use Data::Dumper;
		Data::Dumper->new($vars, $labels)->Indent($indent_level || 1)->Purity(1)
			->Useqq(1)->Deepcopy(1)->Sortkeys(1)->Deparse(1)->
			#Useperl(1)->
			Quotekeys(0)->Dump;
	}
	sub Dump_SO($$;$) { print SDump($_[0], $_[1], $_[2]) }
	sub Dump_SE($$;$) { print STDERR SDump($_[0], $_[1], $_[2]) }
	
	our @EXPORT;
	use mem(@EXPORT=qw(SDump Dump_SO Dump_SE));
	use Xporter;

1;
}
###############################################################################
{ package RPM_Rec;
	use warnings; use 5.14.2;
	use Dbg;
	use P;
	our @offsets = qw(N V R arch srpm nosrc);
	our %Known_Syms;

	use mem &{						# used in access_maker below
		sub() {
			sub _o_N()		 {0}
			sub _o_V()		 {1}
			sub _o_R()		 {2}
			sub _o_arch()  {3}
			sub _o_srpm()  {4}
			sub _o_nosrc() {5}
			}
		};

	sub _access_maker {		 #{ {{2
		my $pkg = shift;		 #var in $_
		{
			no strict 'refs';
			my $proc = '# line ' . __LINE__ . ' "' . __FILE__ . "\"\n" . '
			{ use warnings;
				package ' . $pkg . '; 
				sub ' . $_ . ' (;$) {									# create access routine 
					my $offset=' . &{ "_o_" . $_ } . '; # for package::var
					my $p=shift;
					my $vn = ( ((caller 0)[3]) =~ m{([^:]+)$} )[0];
					if ($p->can("_o_$vn")) {
						if (@_)  {
							$p->[$offset] = $_[0];
						}
						$p->[$offset];
					} elsif (exists $RPM_Rec::Known_Syms[$vn]) {
						if (defined(wantarray)) {									# arrays	special
							wantarray? @{$p->{"$vn"}} : 0+@{$p->{"$vn"}};
						} else {
							$p->[$vn];
						}
					}
					 
				} 
			1}';
			eval "# line ". __LINE__ . "    " . __FILE__ . "\n" .
						"$proc";
			$@ and die "Fatal error in $pkg\::Vars\::_access_maker?: $@\n";
		}
	} ## end sub _access_maker


	sub _var_init ($;$) {		 # create accessor for each varname
		my ($p, $flds, $args) = @_;
		no strict "refs";
		$flds &&
			$flds =~ /^([A-Z]+)/ &&
			$1 ne 'ARRAY' &&
			die __PACKAGE__ . "var_init: param 2 must be fields ARRAY, not $1\n";
		$args &&
			$args =~ /^([A-Z]+)/ &&
			$1 ne 'ARRAY' &&
			die __PACKAGE__ . "var_init: param 3 must be assignable ARRAY not $1\n";

		my $pkg = ref $p || $p;
		$p = {} unless ref $p;
		bless $p, $pkg;

		my $dbg_ccount;

		foreach (@$flds) {
			$Known_Syms{$_} = $p unless exists $Known_Syms{$_};
			++$dbg_ccount if length $_ > 16;
			_access_maker($pkg);		#pass name in $_
		}
		$p;
	}		 #

	# has to be here (sigh) _var_init needs to be pre-defined;
	use mem &{ sub() {
			our @offsets = qw(N V R arch srpm nosrc);
			{ RPM_Rec->_var_init(\@offsets) } } };

	sub instantiate {
		my $p = shift;
		my $c = ref $p;
		return $p unless exists $Known_Syms{$c};
		my $pkgflds = $Known_Syms{$c};
		$p;
	}

	sub new ($;$) {		# return blessed objects and init pre-defined fields w/args
		my $p = shift;
		my $c = ref $p || $p;
		bless $p = $_[0], $c if ref $_[0];
		bless $p = [], $c unless ref $p;
		@{$p} = @{ $_[0] } if @_;
		bless $p, $c;
	}

	sub rec2rpm_name () {
		my $p		 = shift;
		my ($n, $v, $r, $arch) = ($p->N, $p->V, $p->R, $p->arch);
		chomp $arch;
		my $q = P "%s-%s-%s.%s.rpm", $n, $v, $r, $arch;
		$q=~s/-"(\S+)"-"(\S+)"/-$1-$2/;
		$q;

	}
	1;
}


###############################################################################
{ package Parse_n_Cmp;
	use Time::HiRes @Time::HiRes::EXPORT_OK;
	use CompVer;
	our @fields = qw(block prev delete pkgs);
	our @ISA		= qw(Data::Vars);
	use mem &{	sub() { our @fields = qw(block prev delete pkgs);
							our @ISA		= qw(Data::Vars); } };
	use Data::Vars \@fields,{block=>-1, prev=>undef, };
	use P;
	use DDump;


	sub N()			{0}
	sub V()			{1}
	sub R()			{2}
	sub arch()	{3}
	sub srpm()	{4}
	sub nosrc() {5}


	sub cmp_likely_recs($) {
		my $p = shift;
		my $recp = RPM_Rec->new($_[0]);
		$p->{delete}=[] unless ref $p->{delete};
		$p->{pkgs}=[] unless ref $p->{pkgs};

		return undef unless $recp->[srpm] && $recp->[nosrc];
		if ($recp->[arch] eq 'noarch') {}
		elsif ( $recp->[srpm]  and $recp->[srpm]	=~ /none/) { 
			$recp->[arch] = 'src';
		} elsif ($recp->[nosrc] and $recp->[nosrc] =~ /1/	) {
			$recp->[arch] = 'nosrc';
		}
			#};
		my $pprev;
		if (($pprev = $p->prev) && $pprev->N eq $recp->N) {
			my ($pv, $pr) = ($pprev->V, $pprev->R);
			my ($cv, $cr) = ($recp->V, $recp->R);
			my $res = cmp_vers($pv, $cv) || cmp_vers($pr, $cr);
			if ($res < 0) {		 #res < 0 means prev-ver < cur-ver
				push @{ $p->{delete} },
					pop @{ $p->{pkgs} };		# && fall through to push @pkgs

			} elsif ($res > 0) {				# res>0 means prev-ver > cur-ver
				push @{ $p->{delete} }, $recp;
				return;										#no pushing any vals onto @pkgs

			} else {		#FATALITY res == 0 means vers are same (!?!) (duplicate?)
				Pe "prevV=%s, cV=%s, prevR=%s, cR=%s", $pv, $recp->V, $pr, $recp->R;
				Pe "cmp Vs=%s, cmp Rs=%s", cmp_vers($pv, $recp->V),
					cmp_vers($pr, $recp->R);
				Pe "Unexpected equality encountered -- 2 *different* packages\n" .
					"Compare equal??? -- How?\n";
				Pe "Pkg NVR,arch,file=%s\n", join ", ", @$recp;
				die "dying....";
			}
		}

		push @{ $p->{pkgs} }, $recp;

		$p->prev($recp);
	}

	sub new ($) { my $p			= shift; my $c		 = ref $p || $p;
		my $param = $_[0];
		$param = { block => $_[0] } unless ref $param;
		$p = __PACKAGE__->SUPER::new($param);
	}

	sub split_n_cmp_vers ($) { my $p = shift; my $c = ref $p || $p;
		my $_ = $_[0];
		s/^\s*//;
		my $rp = [split /\s*\t\s*/, $_];
		$p->cmp_likely_recs($rp);
	}

	sub reset_prev_p () { $_[0]->{prev} = undef; }


	sub dump_to_output ($;$) { my ($p, $n, $n1) = @_;
		Dump_SO([$p], [ "*Data\[\"$n\"\]", ], "$n1");
	}
	1;
}

###############################################################################
package main;
use CompVer;
use strict;
use 5.14.2;
use TimeMarker;
use Time::HiRes @Time::HiRes::EXPORT_OK;
use DDump;
use Types::Core;
use Carp::Always;
use utf8;
use charnames ':full';
use Time::HiRes qw(sleep);
use Cwd;
use Dbg;
use TraceLog;
use P;


{
	sub set_autoflush($) {
		my $default = select $_[0]; $| = 1; select $default;
	}


	sub expire ($) {
		use Carp;
		my $msg = $_[0];
#		if (!$Devel && @cleanup) {
#			foreach my $action (@cleanup) {
#				my $cmd		= $action->{cmd};
#				my $abort = $action->{abort};
#				eval $cmd;
#				if ($@) {
#					printf STDERR "Error in cleanup: $@\n";
#					printf STDERR $abort ? "Cannot continue\n" :
#																 "Trying to continue\n";
#				}
#			}
#		}
		Carp::confess($_[0]);
		exit($! || 1);
	} ## end sub expire ($)



	sub start_childQ ($$$) {
		my ($Qnum, $inQp, $fifo_ctl) = @_;

		my ($s2p, $pfrs);
		pipe $pfrs, $s2p;		 # slave -> parent
		my $pid;

		unless (defined($pid = fork)) {		 # failure, send group-kill sig
			my $stat = "$!";
			Pe "start_childQ: Fork failure:$!\n";
			select STDERR; $| = 1;					 # try to force out message before sig
			kill 15, -$$;										 # try to get whole process group
			die "Fork failure (why are we still here?): $stat\n";
		}

		unless ($pid) {										 # child
			open(my $fifoh, ">", $fifo_ctl) or
				die "Cannot open control channel: $!\n";
			open(STDOUT, ">&", $s2p) or die "Cannot open channel to parent: $!\n";
			close $pfrs; close $s2p;

			#strip off perl layers
			binmode(STDOUT);
			Trace "Child %s to start on inQp", $Qnum;

			#create command
			my @rpmcmd = qw{rpm
				--queryformat=%{N}\t"%{V}"\t"%{R}"\t%7{ARCH}\t%7{SOURCERPM}\t%9{NOSOURCE}\n
				-qp };

			#foreach (@$inQp) { push @rpmcmd, $_ }
			# now transfer all package names we have in to ARGV vec...
			push(@rpmcmd, @$inQp);
			my $status = system @rpmcmd;
			$status >>= 8; $? = $status; $status && Pe "rpm exit error: $? ($!)";
			Trace "(leaf-node-child#%s, %sRPMs)", $Qnum, 0 + @$inQp;

			close STDOUT;
			printf $fifoh "$Qnum Complete\n";
			close $fifoh;
			exit 0;

		} else {		# parent
			close $s2p;
			my $package_p = Parse_n_Cmp->new($Qnum);
			my $ppQ				= 100;
			my $npckgs;
			Trace "MidProc %s: read slave; ", $Qnum;
			while (<$pfrs>) {
				$package_p->split_n_cmp_vers($_);
				++$npckgs % $ppQ || Trace ".\N{U+83}";
			}
			close $pfrs;
			return $package_p;
		}
	} ## end sub start_childQ ($$$)
} #-----------------


# store final results if not deleting them
sub store_results($) {
	use Cwd qw(abs_path);
	my $Cwdname			= abs_path;
	my $parent			= $Cwdname;
	my $dir					= ($Cwdname =~ m{([^/]+)$})[0];
	$parent					=~ s/\/$dir$//;
	my $sdelp				= $_[0];
	my $firstchoice = pathcat($parent, $dir . "-old-rpms.txt");
	my $secchoice		= pathcat("/tmp", $dir . "-old-rpms-$$.txt");
	my $choice			= $firstchoice;
	my $orh;
	open($orh, ">", $firstchoice) || do {
		my $stxt = "$!";
		my $orh = undef;
		$choice = $secchoice;
		open($orh, ">", "$secchoice") || do {
			die "Unable to find place for old rpm list, tried\n" .
				"$firstchoice: $stxt,\n			$secchoice: $!\n";
		};
	};

	foreach (@$sdelp) { P $orh, "%s", $_->rec2rpm_name }
	close $orh && P "Old rpm list stored in $choice\n";
}


sub start_childrenQs($$$) {		 #1 helper/Q does the
	my ($nlists, $fifo_ctl, $Helpers) = @_;
	for (my $i = 0 ; $i <= $#{$nlists} ; ++$i) {

		#master & helper (intermediary)
		my ($mfrh, $h2m);		#mastr fr. hlpr + hlpr 2 mastr
		pipe $mfrh, $h2m;

		my $pid;
		unless (defined($pid = fork)) {		 # failure, send group-kill sig
			my $stat = "$!";
			Pe "start_childrenQs: Fork failure:$!\n";
			select STDERR; $| = 1;					# try to force out message before sig
			kill 15, -$$;										# try to get whole process group
			die "Fork failure (why are we still here?): $stat\n";
		}

		unless ($pid) {
			close $mfrh;										#not master, so close receiving end;
			open(STDOUT, ">&", $h2m);
			close $h2m;
			binmode(STDOUT);								#minimal perl processing

			my $package_p = start_childQ($i, \@{ $nlists->[$i] }, $fifo_ctl);
			# marshall the data
			$package_p->dump_to_output($i, 0);		#0=no indent formatting;
			close STDOUT;

			#sleep 5;
			exit 0;
		} else {																#parent tracks helpers
			close $h2m;														#helper 2 master
			push @$Helpers, $mfrh;								#master fr helper
		}
	} 
}


sub read_slave ($$$$) {
	my ($slave, $mfrh, $Cdatap, $ed) = @_;

	Trace "Proc %s: Reading Slave, \x83", $slave;
	my $results;
	my $rh;

	if (save_intermediate) {
		$results = pathcat($ed, "tmpdata-$slave");
		open($rh, ">", $results) or
			die "Cannot open %s to data in: $!\n", $results;
	}

	my $slurpdata;
	{ local $/ = undef;
		$slurpdata = <$mfrh>;
		if (save_intermediate) {
			eval "# line ". __LINE__ . "    " . __FILE__ . "\n" . 
						'P $rh, "%s", $slurpdata';
			warn $@ if $@;
		}
	}
	my $position;
	if (save_intermediate) {
		eval "# line ". __LINE__ . "    " . __FILE__ . "\n" .
		' $position = tell $rh;
						close $rh || Pe "Error in closing %s: $!\n";';
		$@ and warn "eval error: $@\n";
	}

	Trace "Done.";
	Pe "Midproc#%s stored (%sB )in %s.", 
			$slave, $position, $results if save_intermediate;

	{ my @Data;		 #used /created/filled by following eval;

		eval "# line ". __LINE__ . "  " . __FILE__ . "\n" .  $slurpdata;
		#eval	$slurpdata ;

		if ($@) { die "Error in evaluating data: $@\n"; }
		my $cd_del = $Cdatap->{delete};# || 0;
		my $cd_pkg = $Cdatap->{pkgs}; #	 || 0;
		my $d_del  = $Data[$slave]->{delete};
		my $d_pkg  = $Data[$slave]->{pkgs};

		if (defined $cd_del && defined $d_del) {
			$Cdatap->{delete} =[] unless ref $Cdatap->{delete};
			push(@{ $Cdatap->{delete} }, @{ $Data[$slave]->{delete} });
		}
		if (defined $cd_pkg && defined $d_pkg) {
			$Cdatap->{pkgs} =[] unless ref $Cdatap->{pkgs};
			push(@{ $Cdatap->{pkgs} }, @{ $Data[$slave]->{pkgs} });
		}
	}
}


sub get_work_list_for_dir($) { my $p = shift;
	my $d = $_[0];
	opendir(my $dh, $d) or die "can't open dir $d: $!\n";
	my @rpms = sort grep /(?<!delta)\.rpm$/, readdir $dh;
	Pe "Read %s rpm names.", 0 + @rpms;

	my ($minPP, $scale_down)	=	($p->{minPP}, $p->{scale_down});
	my $cpus									= $p->{cpus};
	my $items_p_list 					= (0+@rpms) / $cpus;

	# reduce cpu's used if small number of items...
	if ($items_p_list < $minPP) { $cpus = ($minPP + @rpms) / $minPP}
	$items_p_list = int((2 * $cpus + @rpms - 1) / $cpus);
	Pe "Use %s procs w/%s items/process", int $cpus, $items_p_list;

	my ($start, $end, $nlist_pointers);

	for (my $nl = 0 ; $nl < $cpus ; ++$nl) {
		$start = $nl * ($items_p_list);
		$end = ($nl + 1) * ($items_p_list) - 1;
		$end = $#rpms if $end > $#rpms;
		push (@$nlist_pointers, [ @rpms[ $start .. $end ] ]);
	}
	return $nlist_pointers;
}


#master spawns off a helper process for each queue;
sub div_rpms_to_nlists () { my $p = shift;
	use Cwd qw(abs_path);
	my $d = abs_path;
	my $Cwdname = ($d =~ m{([^/]+)$})[0];
	my $nlist_pointers = $p->get_work_list_for_dir($d);

	my $nptrs = 0 + @$nlist_pointers;

	#my $tmpd;		 ##tmp dir
	my @fds;		 ##parent's fd of children

	if (-e "/dev/shm") {
		$p->tmpd = "/dev/shm/tmp";
		unless (-e $p->tmpd && -d $p->tmpd) {		 #go conservative
			system("mkdir -m 1777 " . $p->tmpd) and $p->tmpd = "/tmp";
		}
	}

	$p->fifo_ctl = pathcat($p->tmpd, "RMV-ctl-$$");
	my $Fifoname = $p->fifo_ctl;
	unless (-p $p->fifo_ctl) {
		unlink $p->fifo_ctl;
		POSIX::mkfifo($p->fifo_ctl, 0700) || die "Can't mkfifo $p->fifo_ctl: $!";
		# else register to remove file...
		$p->remove_fifo="unlink \"$Fifoname\"";
	}


	#our @Helpers;		 #global to hold helper<->master	I/O handles

	$p->times->mark([ starting_children => time() ]);
	Trace "Starting %d children Q's", 0 + @$nlist_pointers;


	# start 1 intermediate child for each queue, and below that another
	# child will do I/O with rpm;
	#
	# each intermeidate will do sorting and filtering on their section
	# of the list, then they send all to the master where a second sort
	# and filter is done to catch those packages missed because the dups
	# were on separate lists
	#
	#
	my $Datap = start_childrenQs(\@$nlist_pointers, $p->fifo_ctl, $p->Helpers);
	Trace "Finished starting helpers";

	$p->times->mark([ end_starting_children => time() ]);

}


sub read_data_from_children()	{ my $p = shift;
	my $ed;
	if (save_intermediate) {
		$ed = pathcat($p->tmpd, "rorid-$$");
		mkdir $ed or die "Can't create tmp dir \"$ed\": $!\n";
	}

	our $Cdata = Parse_n_Cmp->new({ delete => [], pkgs => [] });
	my @slaves;
	my $slaves_read;

	open(my $fifoh, "<", $p->fifo_ctl) or
		die "Cannot open control channel: $!\n";

	while (<$fifoh>) {
		m{^(\d+)};
		my $slave				= $1;
		$slaves[$slave] = 1;
		$Cdata->{block} = $slave;
		my $mfrh = $p->Helpers->[$slave];
		$p->Helpers->[$slave] = undef;
		read_slave($slave, $mfrh, $Cdata, $ed);
		++$slaves_read;
	}

	$p->times->mark([ endRdFrmChldrn_n_start_re_sort => time() ]);

	Pe "#pkgs=%s, #deletes=%s, total=%s\n", 0 + @{ $Cdata->{pkgs} },
		0 + @{ $Cdata->{delete} || \[] },
		0 + @{ $Cdata->{delete} || \[] } + @{ $Cdata->{pkgs} };

	##
	## a cumulative sort on the packages to be kept
	##

	@{$p->spkgs} = sort { $a->N cmp $a->N or 
									cmp_vers($a->V, $b->V) or
									cmp_vers($a->R, $b->R) }	@{$Cdata->{pkgs}};

	my $counter = 0;
	my $pnc				= Parse_n_Cmp->new(100);
	
	##
	## and a final pass through the keep list to see if there
	## are any dups at the seams -- the boundaries where child
	## groups were originally split and later rejoined... 
	##

	$pnc->cmp_likely_recs($_, ++$counter) for @{$p->spkgs};


	if ( $pnc->{delete} && @{ $pnc->{delete} }) {
		Pe "%s additional duplicates found in last pass", 0+@{ $pnc->{delete} };
		push @{$Cdata->{delete}}, @{$pnc->{delete}};
		if (@{$pnc->{delete}}) {
			foreach (@{$pnc->{delete}}) { 
				next unless ARRAY $_ && @$_;
				Trace "%s\n", $_->rec2rpm_name; 
			}
		}
	}

	@{$p->sdel} = sort @{ $Cdata->{delete} };
}


	
sub cleanup() { my $p = shift;
	unless (process_deletes) {
		store_results($p->sdel);
	} else {
		Pe "Recycling %s duplicates...\N{U+83}\n", 0 + @{$p->sdel};
		for (@{$p->sdel}) {
			# check that filename really exists
			my $fname	= $_->rec2rpm_name;
			my $curdir = getcwd;
			if ( ! -f pathcat($curdir, $fname)) {
				my ($subpath, $fdir);
				if ( ($subpath, $fdir) = $curdir =~ m{^(.+?)/([^/]+)/?$}) {
					my ($fbase, $ftype, $fsfx);
					if ($fdir eq 'src' || $fdir eq 'noarch' and
						($fbase, $ftype) = $fname =~ m{^(.+?)\.([^.]+)\.rpm$}) {
						my $new_fname = "$fbase.$fdir.rpm";
						if ( -f pathcat($curdir, $new_fname) ) {
							$fname = $new_fname;
						}
					}
				} else {
					Pe "bad RE match for %s", $fname;
				}
			}
			RecycleBin::recycle($fname);
		}
		Pe "Done";
	}
	eval "# line ". __LINE__ . "    " . __FILE__ . "\n" .  "$p->remove_fifo";
}



sub get_cpus($)	{ my $scale_down=$_[0];
	my $cpus = `grep ^processor /proc/cpuinfo|wc -l`; chomp $cpus;
	$cpus or die "couldn't read #cpu's. too strange to continue\n";
	$cpus /= $scale_down;
}



################################################################################
############	main start #############

use constant minPP => 50;

use Data::Vars [qw(Helpers tmpd fifo_ctl sdel spkgs remove_fifo
									minPP scale_down cpus times)],
								{Helpers=>[], sdel=>[], spkgs=>[], minPP=>minPP,
								scale_down=>default_scale_down
								};

our $scale_down = @ARGV && $ARGV[0]+0;

$scale_down = default_scale_down unless $scale_down;

my $p=__PACKAGE__->new();

$p->times = TimeMarker->new(1);

$p->times->mark([ start_program => time() ]);

binmode STDOUT, ':encoding(UTF-8)';
binmode STDERR, ':encoding(UTF-8)';


$p->cpus=get_cpus($scale_down);

$p->div_rpms_to_nlists;
$p->read_data_from_children;

$p->times->mark([ afterFinalSort => time() ]);
$p->cleanup;
$p->times->mark([ afterRecycle => time() ]);

$p->times->chronolog;


## vim: ts=2 sw=2 ai

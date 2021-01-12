#!/usr/bin/perl

{ package RecycleBin;
	use warnings; use strict;
	use P; use PathCat qw(Sep);
	use Cwd;
	my $max_warn	= 1;
	my $warnings	= 0;
# gvim=:SetNumberAndWidth 

	sub getdev_n_path($) {	
		my $path	= $_[0]; 
		my $dev		= (stat $path)[0];

		return ($dev, $path);

#		my $retry=0;
#		if ($path =~ m{noarch\.rpm$} ) { 
#			$path=~ s/noarch\.rpm/src.rpm/; $retry=1 ;
#		} elsif ($path =~ m{src\.rpm$} ) { 
#			$path=~ s/src\.rpm/noarch.rpm/; $retry=1;
#		}
#
#		if ($retry) {
#			($dev = (stat $path)[0]) and  do {
#				return ($dev, $path);
#			};
#		}
#		return undef; 
	}

	sub get_partname($) { my $dev = $_[0];
		my ($devmaj, $devmin) = ($dev >> 8, $dev & 0xff);
		my $devpath			= "/sys/dev/block/$devmaj:$devmin";
		my $devname;
		my ($partname, $partRE);
		if (-d pathcat($devpath, "dm")) {
			open(my $ph, "<", "/sys/dev/block/$devmaj:$devmin/dm/name") ||
				die "can't open volume name: $!\n";
			$partname = <$ph>;
			chomp $partname;
			$partRE	= $partname;
			while ($partRE =~ m{\w-\w}) {
				$partRE =~ s{(\w)-(\w)}{$1.'[-/]'.$2}e;
			}
		} else {
			my $part = readlink $devpath;
			$partname = ($part =~ m{([^/]+)$}) ? $1 : undef;
			unless ($partname) {
				warn "Cannot get partion name from devpath link";
				return (undef, undef);
			}
			$partname = "/dev/" . $partname;
			$partRE		= $partname;
		}
		($partname, $partRE)
	}

	sub get_mnt_point ($) { my $partname = $_[0];
		open(my $mh, "<", "/proc/mounts") or die "Can't open /proc/mount: $?\n";
		my @table = <$mh>;
		my @mps		= grep m{$partname}, @table;

		die "Cannot find $partname in mount table" if @mps < 1;

		my $mnt_pnt = (split /\s+/, $mps[0])[1];
		chomp $mnt_pnt;
		$mnt_pnt;
	}

	sub get_recycle_bin($) { my $mnt_pnt  = $_[0]; my $recycle_bin;
		umask 0;
		if (!-d ($recycle_bin = pathcat($mnt_pnt, ".recycle"))) {
			mkdir ($recycle_bin, 01777) ||
				die "Cannot create recycle bin under mount $mnt_pnt: $!";

			chmod 01777, $recycle_bin || die "Cannot set correct mode:$!";
		}
		$recycle_bin;
	}

	sub createdest($$) {my ($voldir, $dest) = @_;
		umask 0;
		use Cwd qw(abs_path);
		my @parts		= split '/', $dest;
		my $curdir	= abs_path();
		chdir $voldir || die "Cannot create path for recycling @ $voldir";
		while (@parts) {
			$voldir = pathcat($voldir, shift @parts);
			if (! -d $voldir) {
				mkdir ($voldir, 01777) || die "Cannot create path @ $voldir: $!";
				chmod 01777, $voldir;
				chdir $voldir;
			}
		}
		chdir $curdir;
	}
	
	our (%dev2partname, %partition2mntpt, %mntdir2recycle);

	sub recycle_warn($) { my $msg=$_[0];
		++$warnings;
		if (--$max_warn) { warn $msg;return undef; } else { die $msg};
	}

	sub recycle ($) {
		my $path = Sep eq substr($_[0],0,1) ? $_[0] : pathcat(getcwd,$_[0]);

		my ($dev, $real_path) = getdev_n_path($path);


		#/local/suse/tumbleweed/repo/src-non-oss/suse
		#/ (src) (7kaa-music-20140929-1.11) .(noarch).rpm
#		unless ($dev && $real_path) {
#			my ($dirs,$file, $rpmtype, $sfx) = m{^(.*?)/([^/]+?)/([^/.]+?)\.([^/.]+)$};
#			Pe "dr=%s, fl=%s, rt=%s, sfx=%s", $dirs,$file, $rpmtype, $sfx;
#			my $newpath="$dirs/$file.";
#		}

		return recycle_warn(
			P "real_path=%s(%s), dev=%s", $real_path, 
				 ($real_path && -e $real_path? "exists" : "Nexist"), $dev)
				 unless $dev && $real_path;


		my ($partname, $partRE) = $dev2partname{$dev} ||= get_partname($dev);
		die "Can't get partname (?$partname?) from dev ($dev)" unless $partname;

		my $mnt_pnt = $partition2mntpt{$partname}			||= get_mnt_point($partname);
		die "Can't get mntpnt (4 partname $partname)"  unless $mnt_pnt;

		my $recycle_bin = $mntdir2recycle{$mnt_pnt}		||= get_recycle_bin($mnt_pnt);

		my $file = ($real_path =~ m{.*/([^/]+)$})[0];
		my $src = $real_path;
		$real_path =~ s{$mnt_pnt/}{};		#sub path in recycle bin

		my $path_recycle_dir = ($real_path =~ m{(.*)/[^/]+$} ) [0];

		my $dst = pathcat($recycle_bin, $path_recycle_dir, $file);

		my $recycle_target_dir = pathcat($recycle_bin, $path_recycle_dir);
		createdest($recycle_bin, $path_recycle_dir) unless -d $recycle_target_dir;
		
		die P "FAIL -- no target dir %s, in mntpt %s", $recycle_target_dir, $mnt_pnt
			unless -d $recycle_target_dir;

		if (link $src, $dst) {
			unlink $src or recycle_warn(
					P "Could not unlink old file %s", $src);
		} else {
			recycle_warn(P "Could not link %s into %s", $src, $recycle_bin);
		}

		return !$warnings;	
	} ## end sub recycle ($)
1}


## vim: ts=2 sw=2 ai

#!/usr/bin/perl
# gvim=:SetNumberAndWidth 
use warnings; use strict;
################################################################################
{ package TypeVal;
	use warnings; use strict; use mem;
	use Data::Vars [qw(type val)];
1}
################################################################################
{ package CompVer;
	use warnings; use strict;
	our $VERSION='0.0.1';
	use mem; use P;
	our @EXPORT;
	use mem (@EXPORT = qw(cmp_vers));
	use Xporter;

	use constant {	date		=> 100, num			=> 75,	string	=> 50,
									colon		=> 4, 	dash		=> 4, 	dot			=> 3,
								};

	sub parse_ver ($) { 
		local $_ = $_[0];
		my (@result, $t);
		
		sub addtok;
		local *addtok = sub {
			push @result, TypeVal->new({type => $t, val => $1 });
			$_ = $2;
		};

		while (length) {
			/^(2\d{7})(.*)$/		and $t=date,		addtok, next;
			/^(\d+)(\W.*)$/			and $t=num,			addtok, next;
			/^(\d+)$/						and $t=num,			addtok, next;
			/^(\.)(.*)$/				and $t=dot,			addtok, next;
			/^([-_])(.*)$/			and $t=dash,		addtok, next;
			/^(:)(.*)$/					and $t=colon,		addtok, next;
			/^([^_\.:-]+)(.*)$/	and $t=string,	addtok, next;
			/^(.+)$/						and $t=string,	addtok, next;
		}
		return @result;
	} ## end sub parse_ver ($)

	sub cmp_vers($$) {
		my ($va, $vb) = @_;
		my @pa = parse_ver("$va");
		my @pb = parse_ver("$vb");
		for (my $i = 0 ; $i < @pa ; ++$i) {
			return -1 if $i > @pb;
			my ($pat, $pav) = @{$pa[$i]}{qw(type val)};
			my ($pbt, $pbv) = @{$pb[$i]}{qw(type val)};
			my $cmp;
			return $cmp if ($pat >= num && $pbt >= num and $cmp = $pav <=> $pbv) or
																										 $cmp = $pav cmp $pbv;
		}
		# getting here means at end of pa array; 
		# if we still have more in pb array then it is longer (and greater)
		return @pb > @pa ? 1 : 0;
	}

1}


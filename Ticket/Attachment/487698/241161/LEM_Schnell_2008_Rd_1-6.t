#!usr/bin/perl

## Test for (incomplete; rounds 1-6 only) tournament from
## http://www.lsvmv.de/turniere/erg/lem_schnellschach_2008_maenner_paarungen.htm

use lib qw/t lib/;

use strict;
use warnings;

# use Games::Tournament::Swiss::Test;
use Test::Base -base;

BEGIN {
	@Games::Tournament::Swiss::Config::roles = (qw/A B/);
	$Games::Tournament::Swiss::Config::firstround = 1;
	$Games::Tournament::Swiss::Config::algorithm = 'Games::Tournament::Swiss::Procedure::FIDE';
}

plan tests => 1*blocks;

use Games::Tournament::Contestant::Swiss;
use Games::Tournament::Swiss;
use Games::Tournament::Card;
use Games::Tournament::Swiss::Procedure;

my $t;

my $n = 29;
my ($p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8,$p9,$p10,
    $p11,$p12,$p13,$p14,$p15,$p16,$p17,$p18,$p19,$p20,
    $p21,$p22,$p23,$p24,$p25,$p26,$p27,$p28,$p29,
   )
	= map { Games::Tournament::Contestant::Swiss->new(
	id => $_, name => chr($_+64), rating => 2000-$_, title => 'Nom') }
	    (1..$n);
my @lineup = ($p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8,$p9,$p10,
              $p11,$p12,$p13,$p14,$p15,$p16,$p17,$p18,$p19,$p20,
              $p21,$p22,$p23,$p24,$p25,$p26,$p27,$p28,$p29,
             );

sub prepareTournament
{
	my $rounds = shift;
	my $lineup = @_;
	for my $player ( @lineup )
	{
		delete $player->{scores};
		delete $player->{score};
		delete $player->{preference};
		delete $player->{pairingNumber};
		delete $player->{roles};
		delete $player->{floats};
	}
	my $tourney = Games::Tournament::Swiss->new( rounds => $rounds,
		entrants => \@lineup);
	$tourney->round(0);
	$tourney->assignPairingNumbers( @lineup );
	$tourney->initializePreferences;
	$tourney->initializePreferences until $p1->preference->role eq
		$Games::Tournament::Swiss::Config::roles[0];
	return $tourney;
}

sub runRound {
	my $tourney = shift;
	my $round = shift;
	my %brackets = $tourney->formBrackets;
	my $pairing  = $tourney->pairing( \%brackets );
    # $pairing->loggingAll;
    $pairing->matchPlayers;
	my $matches = $pairing->{matches};
	$tourney->{matches}->{$round} = $matches;
	my @games;
	my $results = shift;
	for my $bracket  ( sort keys %$matches )
	{
        my $table_number = 0;
        # print "Bracket: $bracket\n";
		my $tables = $pairing->{matches}->{$bracket};
        foreach my $table ( @$tables ) {
		    $table->result( $results->{$bracket}[$table_number] );
            # print "table_number: $table_number\n";
            # print "result White: $results->{$bracket}[$table_number]{A}\n";
            # print "result Black: $results->{$bracket}[$table_number]{B}\n";
            $table_number++;
        }
		push @games, @$tables;
	}
	$tourney->collectCards( @games );
	$tourney->round($round);
};

$t = prepareTournament( 7, @lineup );
## pair and use given results for first round
runRound($t, 1, { 0=> [ 
                        ## results for table 1 (White first)
                        { A=>'Win',B=>'Loss' }, 
                        ## results for table 2 (White first)
                        { A=>'Loss',B=>'Win' },
                        ## results for table 3 (White first)
                        { A=>'Win',B=>'Loss' },
                        ## results for table 4 (White first)
                        { A=>'Loss',B=>'Win' },
                        { A=>'Draw',B=>'Draw' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' },
                      ]
                }
        );
## pair and use given results for second round (see above)
runRound($t, 2, { '1' => [ 
                        { A=>'Loss',B=>'Win' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                      ],
                  '0' => [
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Loss',B=>'Win' },
                      ],
                  '0Remainder' => [
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' },
                        { A=>'Loss',B=>'Win' },
                      ],
                }
        );
## pair and use given results for third round (see above)
runRound($t, 3, { '2' => [ 
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Win',B=>'Loss' },
                      ],
                  '1' => [
                        { A=>'Win',B=>'Loss' },
                      ],
                  '1Remainder' => [
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '0.5' => [
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '0' => [
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                      ]
                }
        );
## pair and use given results for forth round (see above)
runRound($t, 4, { '3' => [ 
                        { A=>'Win',B=>'Loss' }, 
                      ],
                  '2' => [
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '2Remainder' => [
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Win',B=>'Loss' }, 
                        { A=>'Win',B=>'Loss' }, 
                      ],
                  '1.5' => [
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '1' => [
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '0' => [
                        { A=>'Loss',B=>'Win' }, 
                      ]
                }
        );
## pair and use given results for fifth round (see above)
runRound($t, 5, { '3.5' => [ 
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '3' => [
                        { A=>'Win',B=>'Loss' }, 
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '2.5' => [
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '2.5Remainder' => [
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '2' => [
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '2Remainder' => [
                        { A=>'Win',B=>'Loss' }, 
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Win',B=>'Loss' }, 
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '1.5' => [
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '1' => [
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Win',B=>'Loss' }, 
                      ],
                }
        );
## pair and use given results for sixth round (see above)
runRound($t, 6, { '4' => [ 
                        { A=>'Win',B=>'Loss' }, 
                      ],
                  '4Remainder' => [
                        { A=>'Win',B=>'Loss' }, 
                      ],
                  '3' => [
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '3Remainder' => [
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Win',B=>'Loss' }, 
                      ],
                  '2.5' => [
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '2' => [
                        { A=>'Win',B=>'Loss' }, 
                        { A=>'Win',B=>'Loss' }, 
                        { A=>'Win',B=>'Loss' }, 
                      ],
                  '1' => [
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '1Remainder' => [
                        { A=>'Win',B=>'Loss' }, 
                      ],
                }
        );

sub roundFilter
{
	my $round = shift;
	my $matches = $t->{matches}->{$round};
	my %tables;
	for my $key ( sort keys %$matches )
	{
		my $bracket = $matches->{$key};
		for my $game ( @$bracket )
		{
			my $contestants = $game->contestants;
			my @ids = map { $contestants->{$_}->id } keys %$contestants;
			push @{$tables{$key}}, \@ids;
		}
	}
	return \%tables;
}

run_is_deeply input => 'expected';

__DATA__

=== Tourney 1 Round 1
--- input lines chomp roundFilter
1
--- expected yaml
0:
 -
  - 1
  - 15
 -
  - 16
  - 2
 -
  - 3
  - 17
 -
  - 18
  - 4
 -
  - 5
  - 19
 -
  - 20
  - 6
 -
  - 7
  - 21
 -
  - 22
  - 8
 -
  - 9
  - 23
 -
  - 24
  - 10
 -
  - 11
  - 25
 -
  - 26
  - 12
 -
  - 13
  - 27
 -
  - 28
  - 14
0Bye:
 -
  - 29

=== Tourney 1 Round 2
--- input lines chomp roundFilter
2
--- expected yaml
1:
 -
  - 10
  - 1
 -
  - 2
  - 12
 -
  - 14
  - 3
 -
  - 4
  - 13
 -
  - 6
  - 21
 -
  - 8
  - 29
 -
  - 25
  - 9
0:
 -
  - 7
  - 5
 -
  - 19
  - 11
0Remainder:
 -
  - 15
  - 22
 -
  - 23
  - 16
 -
  - 17
  - 24
 -
  - 26
  - 18
 -
  - 27
  - 20
0RemainderBye:
 -
  - 28

=== Tourney 1 Round 3
--- input lines chomp roundFilter
3
--- expected yaml
2:
 -
  - 1
  - 4
 -
  - 6
  - 2
 -
  - 3
  - 8
1:
 -
  - 5
  - 25
1Remainder:
 -
  - 9
  - 16
 -
  - 18
  - 10
 -
  - 11
  - 17
 -
  - 12
  - 20
 -
  - 13
  - 28
 -
  - 21
  - 14
 -
  - 29
  - 15
0.5:
 -
  - 19
  - 7
0:
 -
  - 22
  - 26
 -
  - 24
  - 23
0Bye:
 -
  - 27

=== Tourney 1 Round 4
--- input lines chomp roundFilter
4
--- expected yaml
3:
 -
  - 2
  - 1
2:
 -
  - 4
  - 3
2Remainder:
 -
  - 12
  - 5
 -
  - 25
  - 6
 -
  - 8
  - 11
 -
  - 14
  - 9
 -
  - 10
  - 13
1.5:
 -
  - 15
  - 7
1:
 -
  - 16
  - 22
 -
  - 17
  - 27
 -
  - 28
  - 18
 -
  - 20
  - 24
 -
  - 21
  - 29
0:
 -
  - 23
  - 19
0Bye:
 -
  - 26

=== Tourney 1 Round 5
--- input lines chomp roundFilter
5
--- expected yaml
3.5:
 -
  - 3
  - 2
3:
 -
  - 1
  - 14
 -
  - 5
  - 10
2.5:
 -
  - 6
  - 8
2.5Remainder:
 -
  - 11
  - 15
2:
 -
  - 9
  - 4
2Remainder:
 -
  - 7
  - 17
 -
  - 18
  - 12
 -
  - 13
  - 25
 -
  - 24
  - 16
1.5:
 -
  - 29
  - 19
1:
 -
  - 20
  - 26
 -
  - 27
  - 21
 -
  - 22
  - 28
0Bye:
 -
  - 23

=== Tourney 1 Round 6
--- input lines chomp roundFilter
6
--- expected yaml
4:
 -
  - 2
  - 10
4Remainder:
 -
  - 3
  - 1
3:
 -
  - 14
  - 6
3Remainder:
 -
  - 4
  - 11
 -
  - 15
  - 5
 -
  - 16
  - 7
 -
  - 8
  - 13
2.5:
 -
  - 12
  - 9
 -
  - 19
  - 18
2:
 -
  - 17
  - 29
 -
  - 21
  - 22
 -
  - 26
  - 24
1:
 -
  - 25
  - 23
1Remainder:
 -
  - 28
  - 27
1RemainderBye:
 -
  - 20


#!usr/bin/perl

## Test for complete tournament (rounds 1-5) from
## http://www.lsvmv.de/turniere/erg/eon_2007a_paar.htm
## NOTE: Version 0.15 of Games::Tournament::Swiss doesn't 
## get round 5 right, because it doesn't waive B6 for
## player 17 in the last round. (B2, B5 and B6
## do not apply when pairing players with a score 
## of over 50% in the last round.)

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

my $n = 20;
my ($p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8,$p9,$p10,
    $p11,$p12,$p13,$p14,$p15,$p16,$p17,$p18,$p19,$p20)
	= map { Games::Tournament::Contestant::Swiss->new(
	id => $_, name => chr($_+64), rating => 2000-$_, title => 'Nom') }
	    (1..$n);
my @lineup = ($p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8,$p9,$p10,
              $p11,$p12,$p13,$p14,$p15,$p16,$p17,$p18,$p19,$p20);

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
        print "Bracket: $bracket\n";
		my $tables = $pairing->{matches}->{$bracket};
        foreach my $table ( @$tables ) {
		    $table->result( $results->{$bracket}[$table_number] );
            print "table_number: $table_number\n";
            print "result White: $results->{$bracket}[$table_number]{A}\n";
            print "result Black: $results->{$bracket}[$table_number]{B}\n";
            $table_number++;
        }
		push @games, @$tables;
	}
	$tourney->collectCards( @games );
	$tourney->round($round);
};

$t = prepareTournament( 5, @lineup );
## pair and use given results for first round
runRound($t, 1, { 0=> [ 
                        ## results for table 1 (White first)
                        { A=>'Draw',B=>'Draw' }, 
                        ## results for table 2 (White first)
                        { A=>'Loss',B=>'Win' },
                        ## results for table 3 (White first)
                        { A=>'Win',B=>'Loss' },
                        ## results for table 4 (White first)
                        { A=>'Loss',B=>'Win' },
                        ## results for table 5 (White first)
                        { A=>'Win',B=>'Loss' },
                        ## results for table 6 (White first)
                        { A=>'Loss',B=>'Win' },
                        ## results for table 7 (White first)
                        { A=>'Win',B=>'Loss' },
                        ## results for table 8 (White first)
                        { A=>'Loss',B=>'Win' },
                        ## results for table 9 (White first)
                        { A=>'Win',B=>'Loss' },
                        ## results for table 10 (White first)
                        { A=>'Loss',B=>'Win' },
                      ]
                }
        );
## pair and use given results for second round (see above)
runRound($t, 2, { '1' => [ 
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Win',B=>'Loss' },
                      ],
                  '0.5' => [
                        { A=>'Loss',B=>'Win' },
                      ],
                  '0' => [
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '0Remainder' => [
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Win',B=>'Loss' },
                        { A=>'Loss',B=>'Win' },
                      ],
                }
        );
## pair and use given results for third round (see above)
runRound($t, 3, { '1.5' => [ 
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '1.5Remainder' => [
                        { A=>'Win',B=>'Loss' },
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '1' => [
                        { A=>'Win',B=>'Loss' },
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '0.5' => [
                        { A=>'Loss',B=>'Win' }, 
                      ],
                  '0' => [
                        { A=>'Loss',B=>'Win' }, 
                        { A=>'Loss',B=>'Win' }, 
                      ]
                }
        );
## pair and use given results for forth round (see above)
runRound($t, 4, { '2.5' => [ 
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '2' => [
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '1.5' => [
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Draw',B=>'Draw' }, 
                        { A=>'Loss',B=>'Win' },
                      ],
                  '1' => [
                        { A=>'Win',B=>'Loss' },
                      ],
                  '0.5' => [
                        { A=>'Draw',B=>'Draw' }, 
                      ],
                  '0' => [
                        { A=>'Win',B=>'Loss' }, 
                        { A=>'Loss',B=>'Win' }, 
                      ]
                }
        );

runRound($t, 5, { } );

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
  - 11
 -
  - 12
  - 2
 -
  - 3
  - 13
 -
  - 14
  - 4
 -
  - 5
  - 15
 -
  - 16
  - 6
 -
  - 7
  - 17
 -
  - 18
  - 8
 -
  - 9
  - 19
 -
  - 20
  - 10

=== Tourney 1 Round 2
--- input lines chomp roundFilter
2
--- expected yaml
1:
 -
  - 2
  - 7
 -
  - 6
  - 3
 -
  - 4
  - 9
 -
  - 8
  - 5
0.5:
 -
  - 10
  - 1
0:
 -
  - 11
  - 12
0Remainder:
 -
  - 13
  - 18
 -
  - 17
  - 14
 -
  - 15
  - 20
 -
  - 19
  - 16

=== Tourney 1 Round 3
--- input lines chomp roundFilter
3
--- expected yaml
1.5:
 -
  - 3
  - 8
1.5Remainder:
 -
  - 1
  - 6
 -
  - 9
  - 2
 -
  - 7
  - 4
1:
 -
  - 5
  - 13
 -
  - 15
  - 10
 -
  - 16
  - 11
0.5:
 -
  - 12
  - 17
0:
 -
  - 14
  - 19
 -
  - 18
  - 20

=== Tourney 1 Round 4
--- input lines chomp roundFilter
4
--- expected yaml
2.5:
 -
  - 8
  - 1
2:
 -
  - 2
  - 5
 -
  - 4
  - 17
 -
  - 9
  - 7
1.5:
 -
  - 11
  - 3
 -
  - 6
  - 15
 -
  - 10
  - 16
1:
 -
  - 13
  - 19
0.5:
 -
  - 20
  - 12
0:
 -
  - 18
  - 14

=== Tourney 1 Round 5
--- input lines chomp roundFilter
5
--- expected yaml
2.5:
 -
  - 7
  - 8
 -
  - 1
  - 2
2.5Remainder:
 -
  - 16
  - 4
 -
  - 5
  - 6
2:
 -
  - 17
  - 3
2Remainder:
 -
  - 13
  - 6
 -
  - 15
  - 11
1:
 -
  - 10
  - 18
 -
  - 19
  - 20
0:
 -
  - 12
  - 14


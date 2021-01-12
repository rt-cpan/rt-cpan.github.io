#!/opt/local/bin/perl

use Finance::QuoteOptions;
#use Finance::Quote;

# TO DO/NOTABLE
# Finance::Options::Calc - Present Theoretical Value
# Finance::Performance::Calc - Performance Calculation
# Check Out Genius Traer



# Symbole Variable - Hard Coded Temporarily, We'll Add Parser from List Later
my $symb = "NUAN";
my $oq = Finance::QuoteOptions->new;
$oq->source('cboe');


## Header for CSV Option Quotes
print "SYMB, OPTION_SYMB, TYPE, EXP, STRIKE, BID, ASK, LAST, OPENINT, VOLUME\n";

## Repeat for Each Symbol
$oq->symbol($symb);
die 'Retreive Failed' unless $oq->retrieve;

foreach (@{$oq->expirations}) 
{
	my $exp = $_;
	#Calls First
	foreach (@{$oq->calls($exp)})	
	{
		my $call = $_;
		printOptionRecord($symb,"CALL", $exp,$call);	
	}
	#Puts Second
        foreach (@{$oq->puts($exp)})
        {
                my $call = $_;
                printOptionRecord($symb,"PUTS", $exp,$call);             
        }
}


## Print Optien Quote Table (CSV)
        # SYMB =  Underlying Symbol
        # OPTION_SYMB = Option Symbol
        # TYPE = PUT or CALL
        # EXP = Expiration Date
        # STRIKE = Strike Price
        # BID
        # ASK
        # LAST
        # OPENINT = Open Interest
        # VOLUME
#Function Accepts: Symbol, Put or Call, Hash Array Ref to Option Data

sub printOptionRecord{
	print @_[0], ","; 			# SYMB
	print @_[3]->{symbol}, ","; 		# OPTION_SYMB
	print @_[1], ","; 			# TYPE =  Put or Call
	print @_[2], ",";			# EXP
	print @_[3]->{strike}, ",";
	print @_[3]->{bid}, ",";
	print @_[3]->{ask}, ",";
	print @_[3]->{last}, ",";
	print @_[3]->{open}, ",";
	print @_[3]->{volume};
	#print @_[2]->{change}, ",";
	#print @_[2]->{in_the_money};
	print "\n";
};

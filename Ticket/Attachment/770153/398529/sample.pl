sub EMSExt {
########################################################################
#   EMSExt - Extract all fields and attributes from EMS Sys Audit XML file
#                                                                   	
#   Inputs: EMS System Audit XML file
#   Output: Hash table
#                                                                   	
########################################################################
my ($ems_xml,$summary)=@_; 

#Pre-extract sections from the raw file - since the raw file is not in default
#XML format but the configuration type of XML format. Pre-extraction is needed.

local undef $/;
my $EMS_XML=<EMS>;

#Create an extractor
my $XML = XML::TreePP->new();
$XML->set( use_ixhash => 1 );
$XML->set( attr_prefix => '' );
$XML->set( force_array => [ '*' ] );

#Extract all DOM blocks

my ($dom_XML,$dom_parsed,%DOMParsed,%tmp)=();
while ($EMS_XML=~/(<DOM.*?<\/DOM>)/scg) {
	$dom_XML = $XML->parse( $1);
	$dom_parsed = DOMPar($dom_XML,$summary);
	%tmp = %DOMParsed;
	%DOMParsed = %{merge(\%tmp,$dom_parsed)};
	%tmp = ();
}
$EMS_XML=();

return(\%DOMParsed);
}#ENDOfEMSExt

sub DOMPar {
########################################################################
#   DOMPar - Parse DOM Table
#                                                                   	
#   Inputs: Hash reference to DOM table
#   Output: NB Reference Table
########################################################################
my ($DOMs,$summary)=@_; 

#Extract NB information and then build the reference table;
my ($dom,$x,$y,$z,%DOM_Lookup,$DOM_IP,$Sector)=();
tie %DOM_Lookup, "Tie::IxHash";#::Easy"; 

foreach $dom (@{$$DOMs{DOM}}) {
	#Building the Great Lookup table	
	$DOM_IP=$$dom{nodeIpAddress};
	$DOM_Lookup{$DOM_IP}{btsIDString}=$$dom{btsIDString};
	$DOM_Lookup{$DOM_IP}{bscName}=$$dom{bscName};
	$DOM_Lookup{$DOM_IP}{domSlotID}=$$dom{domSlotID};
	$DOM_Lookup{$DOM_IP}{sectorType}=$$dom{sectorType};

	$DOM_Lookup{$DOM_IP}{rncId}=$$dom{CandidateRncTable}[0]{rncId};
	#Extract Cluster RNC Info
	foreach $y (@{$$dom{ClusterRncTable}}) {
		push @{$DOM_Lookup{$DOM_IP}{ClusterRncTable}},{
					rncIpAddress=>$$y{rncIpAddress},
					rncColorCode=>$$y{rncColorCode},
					rncClusterId=>$$y{rncClusterId},};
	}
	
	$DOM_Lookup{$DOM_IP}{is856CarBandClass}=$$dom{IS856Carrier}[0]{is856CarBandClass};
	$DOM_Lookup{$DOM_IP}{is856CarChannelNumber}=$$dom{IS856Carrier}[0]{is856CarChannelNumber};

	#Extract Per-Sector based information
	foreach $y (@{$$dom{IS856ASectorElement}}) {
		$Sector = $$y{sectorElementIndex};
		
		$DOM_Lookup{$DOM_IP}{$Sector}{pnOffset}=$$y{pnOffset};

		if (exists $$y{IS856Channel}) {
			foreach $z (@{$$y{IS856Channel}}) {
				push @{$DOM_Lookup{$DOM_IP}{$Sector}{IS856Channel}}, {
					bandClass => $$z{bandClass},
					channelNumber => $$z{channelNumber},
					channelStatus => $$z{channelStatus},
					channelAdvertised => $$z{channelAdvertised},
					};
			}
		}

		if (exists $$y{IS856Neighbor}) {
			foreach $z (@{$$y{IS856Neighbor}}) {
				push @{$DOM_Lookup{$DOM_IP}{$Sector}{IS856Neighbor}}, {
					neighborIpAddress => $$z{neighborIpAddress},
					is856NbrPilotPn => $$z{is856NbrPilotPn},
					is856NbrBandClass => $$z{is856NbrBandClass},
					is856NbrChannelNumber => $$z{is856NbrChannelNumber},
					is856NbrSearchWindowSize => $$z{is856NbrSearchWindowSize},
					};
			}
		}
	}
	
	foreach $y (@{$$dom{IS856Sector}}) {
		$Sector = $$y{sectorIndex};
		$DOM_Lookup{$DOM_IP}{$Sector}{sectorLatitude}=$$y{sectorLatitude};
		$DOM_Lookup{$DOM_IP}{$Sector}{sectorLongitude}=$$y{sectorLongitude};
		$DOM_Lookup{$DOM_IP}{$Sector}{sectorHeight}=$$y{sectorHeight};
		$DOM_Lookup{$DOM_IP}{$Sector}{sectorHeading}=$$y{sectorHeading};
		$DOM_Lookup{$DOM_IP}{$Sector}{sectorBeamwidth}=$$y{sectorBeamwidth};
	}
}
return(\%DOM_Lookup);
}#ENDOfDOMPar
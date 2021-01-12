package np_asn1;

require Exporter;

@ISA =      qw(Exporter);

@EXPORT =   qw($NP_ASN_DATA
               $NP_IDS_MAJOR_VERSION
               $NP_IDS_MINOR_VERSION
               $NP_PORT
               char2hex
               char2int
               hex2char
               np_asn_decode
               np_asn_encode
              );

use vars    qw($NP_ASN_DATA
               $NP_IDS_MAJOR_VERSION
               $NP_IDS_MINOR_VERSION
               $NP_PORT
              );

use Data::Dumper;
use strict;

$NP_IDS_MAJOR_VERSION = 0;
$NP_IDS_MINOR_VERSION = 11;
$NP_PORT = 64256;

$NP_ASN_DATA = q<

-- ----------
-- Primitives
-- ----------

-- NP-Altitude-T
--   HSAP altitude (m)
--   Source: 
--   Ref   : 
NP-Altitude-T ::= VisibleString

-- NP-Cause-T
--   Return Code
--   Source: 
--   Ref   : -
NP-Cause-T ::= ENUMERATED
{
  np-success(1),
  np-longitudeparsefailure(2),
  np-latitudeparsefailure(3),
  np-altitudeparsefailure(4)
}

-- NP-Current-Config-Version-T
--   Counter which indicates whether a change has been made to the internal HSAP configuration, e.g. scrambling code.
--   Source: 
--   Ref   : 
NP-Current-Config-Version-T ::= INTEGER

-- NP-DL-Primary-Scrambling-Code-T
--   Primary scrambling code index for downlink. Reference :TS 25.213.
--   Source: NBAP
--   Ref   : 9.2.2.34
NP-DL-Primary-Scrambling-Code-T ::= INTEGER

-- NP-HSAP-ID-T
--   Unique Identifier for an HSAP - hostname
--   Source: 
--   Ref   : 
NP-HSAP-ID-T ::= VisibleString

-- NP-HSAP-Cluster-ID-T
--   Identifier for the HSAP Cluster (allows distinction between separate enterprise clusters)
--   Source: 
--   Ref   : 
NP-HSAP-Cluster-ID-T ::= INTEGER

-- NP-HSAP-Freq-T
--   Frequency (UARFCN) for the HSAP (Currently only intra-frequency handovers are supported)
--   Source: 
--   Ref   : 
NP-HSAP-Freq-T ::= INTEGER

-- NP-IDS-Major-Version-T
--   Major Version of this IDS (auto generated)
--   Source: 
--   Ref   : -
NP-IDS-Major-Version-T ::= INTEGER

-- NP-IDS-Minor-Version-T
--   Minor Version of this IDS (auto generated)
--   Source: 
--   Ref   : -
NP-IDS-Minor-Version-T ::= INTEGER

-- NP-IP-Address-T
--   IP Address of HSAP
--   Source: 
--   Ref   : -
NP-IP-Address-T ::= VisibleString

-- NP-Latitude-T
--   HSAP latitude position
--   Source: 
--   Ref   : 
NP-Latitude-T ::= VisibleString

-- NP-Longitude-T
--   HSAP longitude position
--   Source: 
--   Ref   : 
NP-Longitude-T ::= VisibleString

-- NP-Message-Type-T
--   Type of MAPI message.
--   Source: MAPI
--   Ref   : -
NP-Message-Type-T ::= ENUMERATED
{
  np-neighborserverlistreq(1),
  np-neighborserverlistresp(2),
  np-neighborprocconfigreq(3),
  np-neighborprocconfigresp(4)
}

-- NP-Neighbor-Weight-T
--   Average CPICH Ec/No for the requesting Access Point
--   Source: 
--   Ref   : 
NP-Neighbor-Weight-T ::= INTEGER

-- NP-Num-Candidate-Neighbors-T
--   Number of candidate neighbors being provided in the list
--   Source: 
--   Ref   : 
NP-Num-Candidate-Neighbors-T ::= INTEGER

-- NP-Request-Period-T
--   Time interval in seconds used for scheduling config requests
--   Source: 
--   Ref   : 
NP-Request-Period-T ::= INTEGER

-- NP-Search-Radius-T
--   Radius in metres used for restricting neighbor List from Neighbor Server
--   Source: 
--   Ref   : 
NP-Search-Radius-T ::= INTEGER

-- --------------------
-- Composite Primitives
-- --------------------

NP-Message-Header-T ::= SEQUENCE
{
  np-ids-major-version  NP-IDS-Major-Version-T,
  np-ids-minor-version  NP-IDS-Minor-Version-T
}

NP-Geographic-Location-T ::= SEQUENCE
{
  np-longitude  NP-Longitude-T,
  np-latitude  NP-Latitude-T,
  np-altitude  NP-Altitude-T
}


-- --------
-- Messages
-- --------


   -- ------------------------
   -- Neighbor Server List Req
   -- ------------------------
   
   NP-NeighborServerListReq-PDU-T ::= SEQUENCE
   {
     np-hsap-id  NP-HSAP-ID-T,
     np-hsap-cluster-id  NP-HSAP-Cluster-ID-T,
     np-hsap-frequency  NP-HSAP-Freq-T,
     np-geographic-location  NP-Geographic-Location-T,
     np-search-radius  NP-Search-Radius-T
   }
   
   -- -------------------------
   -- Neighbor Server List Resp
   -- -------------------------
   
   NP-NeighborServerListResp-PDU-T ::= SEQUENCE
   {
     np-cause  NP-Cause-T,
     np-request-period  [0]  NP-Request-Period-Seq-T  OPTIONAL,
     np-num-candidate-neighbors  [1]  NP-Num-Candidate-Neighbors-T  OPTIONAL,
     np-candidate-neighbor-list-data  [2]  NP-Candidate-Neighbor-List-Data-List-T  OPTIONAL
   }
   
   NP-Request-Period-Seq-T ::= SEQUENCE
   {
     np-neighbor-proc-to-neighbor-server-request-period  NP-Request-Period-T,
     np-neighbor-proc-to-neighbor-server-request-retry-period  NP-Request-Period-T
   }
   
   NP-Candidate-Neighbor-List-Data-List-T ::= SEQUENCE --<UNBOUNDED>-- OF NP-Candidate-Neighbor-List-Data-Seq-T
   NP-Candidate-Neighbor-List-Data-Seq-T ::= SEQUENCE
   {
     np-hsap-id  NP-HSAP-ID-T,
     np-ip-address  NP-IP-Address-T
   }
   
   -- -----------------------
   -- Neighbor Proc ConfigReq
   -- -----------------------
   
   NP-NeighborProcConfigReq-PDU-T ::= SEQUENCE
   {
     np-hsap-id  NP-HSAP-ID-T,
     np-current-config-version  NP-Current-Config-Version-T
   }
   
   -- ------------------------
   -- Neighbor Proc ConfigResp
   -- ------------------------
   
   NP-NeighborProcConfigResp-PDU-T ::= SEQUENCE
   {
     np-hsap-id  NP-HSAP-ID-T,
     np-current-config-version  NP-Current-Config-Version-T,
     np-scrambling-code  NP-DL-Primary-Scrambling-Code-T,
     np-neighbor-weight  NP-Neighbor-Weight-T,
     np-geographic-location  NP-Geographic-Location-T
   }


NP-PDU-T ::= CHOICE
{
   np-neighborserverlistreq-pdu   [0]  IMPLICIT  NP-NeighborServerListReq-PDU-T,
   np-neighborserverlistresp-pdu   [1]  IMPLICIT  NP-NeighborServerListResp-PDU-T,
   np-neighborprocconfigreq-pdu   [2]  IMPLICIT  NP-NeighborProcConfigReq-PDU-T,
   np-neighborprocconfigresp-pdu   [3]  IMPLICIT  NP-NeighborProcConfigResp-PDU-T
}


NP-Message-T ::= SEQUENCE
{
   hdr NP-Message-Header-T,
   pdu NP-PDU-T
}
>;

sub char2hex($) {
       my $data = shift;
       #print "Data: ".Dumper $data."\n";
       my @data_arr = unpack("C*", $data);
       my $res = "";
   
       foreach (@data_arr)
       {
              $res .= sprintf("%02X",$_);
       }
       return $res;
}

=item char2int($DATA)

Converts a bexbased based string into a string chars

=cut

sub char2int($) {
       my $data = shift;

       my $first = 1;

       #print "char2int Data: ".Dumper $data."\n";
       my @data_arr = unpack("C*", $data);
       my $res = "";
   
       foreach (@data_arr)
       {
          $res .= ',' if (! $first);
          $first = 0;

          $res .= sprintf("%d",$_);              
       }
       return $res;
}

=item hex2char($DATA)

Converts a bexbased based string into a string chars

=cut

sub hex2char($) {
       my $data = shift;
       my @data_arr = split(//,$data);
       my $idx=0;
       my $res="";
       while ($idx<length($data))
       {
              my $hx = $data_arr[$idx].$data_arr[$idx+1];
              $res .= chr(hex($hx));
              $idx +=2;     
       }
       return $res;
}

sub np_asn_decode($)
{
   my $data = shift;
   my $asn = Convert::ASN1->new;
    
   $asn->prepare($NP_ASN_DATA);
   my $asn_msg = $asn->find("NP-Message-T");    
   my $charenc = hex2char($data);     
   my $msg =  $asn_msg->decode($charenc);
   print $asn_msg->error() if !defined $msg;
   return $msg;
}

sub np_asn_encode($)
{
   my $msg_h = shift;
   my $asn = Convert::ASN1->new;
    
   $asn->prepare($NP_ASN_DATA);
   my $asn_msg = $asn->find("NP-Message-T");    
   
   return $asn_msg->encode($msg_h);
}

BEGIN
{

}
__END__

$Trucker::Gpx::VERSION = sprintf "%d.%03d", q$Revision: 1.1 $ =~ /(\d+)/g;

package Trucker::Gpx;

use base Geo::Gpx;

use HTML::Entities qw(encode_entities encode_entities_numeric);
use XML::Descent;

sub xml {
  my $self = shift;
  my $xml = $self->SUPER::xml(@_);
  my ($header) = ($xml =~ /^(.+?)<metadata>/s);

  my $result = "";
  $result .= $header;

  my $p = XML::Descent->new({
          Input   => \$xml, 
          Namespaces => 0
      });


  $p->on('gpx' =>   # gpx handler
    sub {
      my ($elem, $attr, $ctx) = @_;

      $p->on('*' => # everything else handler
         sub {
          my ($elem, $attr, $ctx) = @_;
          $result .= "<$elem>" . $p->xml . "</$elem>\n";
         }
      );

      $p->on('wpt' =>   # waypoint handler within gpx handler
        sub {
          my ($elem, $attr, $ctx) = @_;
          my $wpt = {};
          $p->context($wpt); 
          $p->on( '*' => 
            sub {
              my ($elem, $attr, $ctx) = @_;
              my $text = $p->text;
              $ctx->{$elem}=$text;
              $ctx->{attribs} = $attr;
            }
          );
          $p->walk;
          my @correct_order = (
             'ele','time','magvar','geoidheight', 'name',
             'cmt','desc','src','link','sym',
             'type','fix','sat','hdop','vdio',
             'pdop','ageofdgpsdata','dgpsid','extensions');

          $result .= sprintf "<wpt lat=\"%s\" lon=\"%s\">\n", $attr->{lat},$attr->{lon};
          foreach my $key (@correct_order) {
             $result .= "<$key>" . &Geo::Gpx::_enc( $wpt->{$key}) . "</$key>\n" if defined $wpt->{$key};
          }
          $result .= "</wpt>\n";
        }
      );   # end of waypoint handler

      $p->walk;
    }
  );
  $p->walk;
  $result .= "</gpx>\n";
  return $result;
}


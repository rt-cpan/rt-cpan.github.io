use strict;
use warnings;

use Data::Dump;

my %Data = (
  Table1 => [
              {
                Date  => "2009-07-19",
                Time  => "09:01",
                Value => {
                           "1,2" => "x 1,2",
                           "1,1" => "x 1,1",
                           "2,1" => "x 2,1",
                           "2,2" => 115,
                           "3,2" => "hgflk+kop",
                           "3,1" => "dfhdfh",
                           "4,1" => "",
                           "4,2" => "adgd",
                         },
              },
            ],
);

print Data::Dump::dump ( \%Data );

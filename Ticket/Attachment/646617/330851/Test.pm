package Some::Schema::Loader::Test;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("test");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "INT",
    default_value => undef,
    extra => { unsigned => 1 },
    is_nullable => 0,
    size => 10,
  },
  "somedate",
  {
    data_type => "TIMESTAMP",
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 0,
    size => 14,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04999_07 @ 2009-08-11 23:59:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:F0wJy+6R+SlGV5J51x9nmA


# You can replace this text with custom content, and it will be preserved on regeneration
1;

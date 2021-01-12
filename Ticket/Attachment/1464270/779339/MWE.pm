## @file [MWE.pm]

package MWE;

## @method mwe ()
# @brief An example.
#
sub mwe {
  if ($#somestring) {
    return 1;
  }

  my $ret = 0;  # move this before the if and documentation works again...
  return $ret;
}

1;

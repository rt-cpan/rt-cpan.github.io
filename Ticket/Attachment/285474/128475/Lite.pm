package Statistics::Lite;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
require Exporter;

$VERSION = '2.0';
@ISA = qw(Exporter);
@EXPORT = ();
@EXPORT_OK = qw(min max range sum count mean median mode variance stddev statshash statsinfo);
%EXPORT_TAGS= 
( 
  all   => [ @EXPORT_OK ],
  funcs => [qw<min max range sum count mean median mode variance stddev>],
  stats => [qw<statshash statsinfo>],
);

sub count
{ return scalar @_; }

sub min 
{ 
  return unless @_;
  return $_[0] unless @_ > 1;
  my $min= shift;
  foreach(@_) { $min= $_ if $_ < $min; }
  return $min;
}

sub max 
{ 
  return unless @_;
  return $_[0] unless @_ > 1;
  my $max= shift;
  foreach(@_) { $max= $_ if $_ > $max; }
  return $max;
}

sub range
{
  return unless @_;
  return 0 unless @_ > 1;
  return abs($_[1]-$_[0]) unless @_ > 2;
  my $min= shift; my $max= $min;
  foreach(@_) { $min= $_ if $_ < $min; $max= $_ if $_ > $max; }
  return $max - $min;
}

sub sum
{
  return unless @_;
  return $_[0] unless @_ > 1;
  my $sum;
  foreach(@_) { $sum+= $_; }
  return $sum;
}

sub mean
{
  return unless @_;
  return $_[0] unless @_ > 1;
  return sum(@_)/scalar(@_);
}

sub median
{
  return unless @_;
  return $_[0] unless @_ > 1;
  @_= sort{$a<=>$b}@_;
  return $_[$#_/2] if @_&1;
  my $mid= @_/2;
  return ($_[$mid-1]+$_[$mid])/2;
}

sub mode
{
  return unless @_;
  return $_[0] unless @_ > 1;
  my %count;
  foreach(@_) { $count{$_}++; }
  my $maxhits= max(values %count);
  foreach(keys %count) { delete $count{$_} unless $count{$_} == $maxhits; }
  return mean(keys %count);
}

sub variance
{
  return unless @_;
  return 0 unless @_ > 1;
  my $mean= mean @_;
  return (sum map { ($_ - $mean)**2 } @_) / scalar(@_);
}

sub stddev
{
  return unless @_;
  return 0 unless @_ > 1;
  return sqrt variance @_;
}

sub statshash
{
  return unless @_;
  return
  (
    count    => 1,
    min      => $_[0],
    max      => $_[0],
    range    => 0,
    sum      => $_[0],
    mean     => $_[0],
    median   => $_[0],
    mode     => $_[0],
    variance => 0,
    stddev   => 0,
  ) unless @_ > 1;
  my $count= scalar(@_);
  @_= sort{$a<=>$b}@_;
  my $median;
  if(@_&1) { $median= $_[$#_/2]; }
  else { my $mid= @_/2; $median= ($_[$mid-1]+$_[$mid])/2; }
  my $sum= 0;
  my %count;
  foreach(@_) { $sum+= $_; $count{$_}++; }
  my $mean= $sum/$count;
  my $variance= mean map { ($_ - $mean)**2 } @_;
  my $maxhits= max(values %count);
  foreach(keys %count) 
  { delete $count{$_} unless $count{$_} == $maxhits; }
  return
  (
    count    => $count,
    min      => $_[0],
    max      => $_[-1],
    range    => ($_[-1] - $_[0]),
    sum      => $sum,
    mean     => $mean,
    median   => $median,
    mode     => mean(keys %count),
    variance => $variance,
    stddev   => sqrt($variance),
  );
}

sub statsinfo
{
  my %stats= statshash(@_);
  return <<".";
min      = $stats{min}
max      = $stats{max}
range    = $stats{range}
sum      = $stats{sum}
count    = $stats{count}
mean     = $stats{mean}
median   = $stats{median}
mode     = $stats{mode}
variance = $stats{variance}
stddev   = $stats{stddev}
.
}

1;
__END__

=head1 NAME

Statistics::Lite - Small stats stuff.

=head1 SYNOPSIS

  use Statistics::Lite qw(:all);

  $min= min @data;
  $mean= mean @data;

  %data= statshash @data;
  print "sum= $data{sum} stddev= $data{stddev}\n";

  print statsinfo(@data);

=head1 DESCRIPTION

This module is a lightweight, functional alternative to larger, more complete,
object-oriented statistics packages.
As such, it is likely to be better suited, in general, to smaller data sets.

This is also a module for dilettantes. 

When you just want something to give some very basic, high-school-level statistical values, 
without having to set up and populate an object first, this module may be useful.

=over 6

=head2 NOTE

This version now uses unbiased estimators (previous versions used biased estimators) for variance and standard deviation.
To get the same biased C<stddev()> and C<variance()> available in previous versions, simply add a zero to the data set:

  $stddev_biased= stddev 0, @data;

=back

=head1 FUNCTIONS

=over 4

=item C<min(@data)>, C<max(@data)>, C<range(@data)>, C<sum(@data)>, C<count(@data)>

Return the minimum value, maximum value, range (max - min),
sum, or count of values in C<@data>.
(Count simply returns C<scalar(@data)>.)

=item C<mean(@data)>, C<median(@data)>, C<mode(@data)>

Calculates the mean, median, or mode average of the values in C<@data>.
(In the event of ties in the mode average, their mean is returned.)

=item C<variance(@data)>, C<stddev(@data)>

Return the standard deviation or variance of C<@data>.

=item C<statshash(@data)>

Returns a hash whose keys are the names of all the functions listed above,
with the corresponding values, calculated for the data set.

=item C<statsinfo(@data)>

Returns a string describing the data set, using the values detailed above.

=back

=head2 Import Tags

The C<:all> import tag imports all functions from this module into the
current namespace (use with caution).
To import the individual statistical funcitons, use the import tag C<:funcs>;
use C<:stats> to import C<statshash(@data)> and C<statsinfo(@data)>.

=head1 AUTHOR

Brian Lalonde E<lt>brian@webcoder.infoE<gt>

=head1 SEE ALSO

perl(1).

=cut

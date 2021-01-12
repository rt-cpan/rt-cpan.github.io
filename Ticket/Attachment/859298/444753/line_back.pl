#!/usr/bin/perl
use strict;
use warnings;

use Number::Format;
use DirHandle;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;
use Geometry::Primitive::Circle;
use Chart::Clicker::Renderer::StackedArea;

my $date = $ARGV[0];

my $dir = "/home/xar/tribler/codeploy/".$date."/".$ARGV[1];
#my $dir = "/home/xar/ExperimentFiles/logs/delayedJoin15secBufferM4fullSpeed";
sub plainfiles {
   
   my $dh = DirHandle->new($dir)   or die "can't opendir $dir: $!";
   return sort                     # sort pathnames
          grep {    -f     }       # choose only "plain" files
          map  { "$dir/$_" }       # create full paths
          grep {  !/^\./   }       # filter out dot files
          grep { /delay/   } # nur die, die delay enthalten
          $dh->read();             # read all entries
}

my @filenames = plainfiles();
# Create an empty dataset that we can add to
my $dataset = Chart::Clicker::Data::DataSet->new;
my $minTime = 1300000000;
my %data;
foreach my $file (@filenames) {
	print "$file\n";
	open FILE, "$file" or die $!;
	my @time; # gönn dir mal immerwieder ne neue
	my @speed;
	LINE: while (<FILE>) { 
		last if /^#now/; # den seeding teil wegschneiden
		next LINE if /^#|Timestamp|now/;  # discard comments
		my @bb = split(/ /);
		if ($file =~ m/venus/) {
			push(@time, $bb[0] + 30 * 60);
			$minTime = $bb[0] if $minTime > $bb[0] + 30 * 60;
		} elsif ($file =~ m/mercury/) {
			push(@time, $bb[0] + 8 * 60);
			$minTime = $bb[0] if $minTime > $bb[0] + 8 * 60;
		} else {
			push(@time, $bb[0]);
			$minTime = $bb[0] if $minTime > $bb[0];
		}
		push(@speed, $bb[1]);
	}
	$data{$file}->{key} = \@time;
	$data{$file}->{value} = \@speed;
	close(FILE);

	#print "Hinweis: $data{$file}->{key}[0]\n";
	#print "Hinweis 2: $data{$file}->{value}[0]\n";
};
foreach my $file (@filenames) {
	my $file2 = $file;
	$file2 =~ s/.*\///g;
	$file2 =~ s/-1.*$//;
	
	my @time = map { $data{$file}->{key}[$_] - $minTime } 0..$#{$data{$file}->{key}};
	print "Hinweis: ". @time[0] ." ". @time[$#time] . "\n";
	$dataset->add_to_series(Chart::Clicker::Data::Series->new(
		keys => \@time,
		values => $data{$file}->{value},
		name => $file2,
		#keys => \@time,
		#values => \@speed
	));
};

my $cc = Chart::Clicker->new(width => 1280, height => 800, format => 'png');

#$cc->legend->font->size(20);
$cc->title->font->size(25);

$cc->title->text('Downloadrate über Zeit');
$cc->add_to_datasets($dataset);

my $defctx = $cc->get_context('default');

my $area = Chart::Clicker::Renderer::Area->new(opacity => .4);
$defctx->renderer($area);
my $nf = Number::Format->new;
$defctx->domain_axis->format(sub { return $nf->round(shift, 0); });
$defctx->range_axis->label('Downloadrate_[kbyte]');
$defctx->domain_axis->label('Zeit [sec]');
$defctx->domain_axis->label_font->size(20);
$defctx->range_axis->label_font->size(20);
$defctx->domain_axis->tick_font->size(20);
$defctx->range_axis->tick_font->size(20);
$defctx->domain_axis->fudge_amount(.01);
$defctx->range_axis->clear_tick_values();
$defctx->range_axis->add_to_tick_values(0);
$defctx->range_axis->add_to_tick_values(100);
$defctx->range_axis->add_to_tick_values(200);
$defctx->range_axis->add_to_tick_values(300);
$defctx->range_axis->add_to_tick_values(400);
$defctx->range_axis->add_to_tick_values(500);
$defctx->range_axis->add_to_tick_values(600);
$defctx->range_axis->add_to_tick_values(700);
$defctx->range_axis->add_to_tick_values(800);
$defctx->range_axis->add_to_tick_values(900);
$defctx->range_axis->add_to_tick_values(1000);
$defctx->range_axis->add_to_tick_values(1100);
$defctx->range_axis->add_to_tick_values(1200);
$defctx->range_axis->add_to_tick_values(1300);
$defctx->range_axis->add_to_tick_values(1400);
$defctx->range_axis->add_to_tick_values(1500);
$defctx->range_axis->add_to_tick_values(1600);
$defctx->range_axis->add_to_tick_values(1700);
$defctx->range_axis->add_to_tick_values(1800);
$defctx->range_axis->add_to_tick_values(1900);
$defctx->range_axis->add_to_tick_values(2000);
$defctx->range_axis->add_to_tick_values(2100);
$defctx->range_axis->add_to_tick_values(2200);
$defctx->range_axis->add_to_tick_values(2300);
$defctx->range_axis->add_to_tick_values(2400);
$defctx->range_axis->add_to_tick_values(2500);
$defctx->range_axis->add_to_tick_values(2600);
$defctx->range_axis->add_to_tick_values(2700);
$defctx->range_axis->add_to_tick_values(2800);
$defctx->range_axis->add_to_tick_values(2900);
$defctx->range_axis->add_to_tick_values(3000);
#$defctx->renderer->additive(1);
$defctx->renderer->brush->width(2);

$cc->write_output($dir."/".$date.'.png');

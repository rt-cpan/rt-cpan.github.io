#!/usr/bin/perl
use XML::Twig;
use XML::Twig::XPath;
# use Unicode::String qw(utf8 latin1);
use MARC::Record;
use Data::Dumper;
use Date::Manip;
use Getopt::Long;
use utf8;
use strict;
# buffers for holding text

my %concepthash;
my %mthash;
my %BT;
my %NT;
my ($filename,$force);
GetOptions(
    'file:s'    => \$filename,
    'f' => \$force,
);

# initialize parser with handlers for node processing
my $twig = new XML::Twig::XPath( TwigHandlers => { 
                             "/thesaurusMultilingue/langue/thesaurus/concept"    => \&concepthash,
                             "/thesaurusMultilingue/langue/thesaurus/microthesaurus"    => \&mthash,
                                          });

# parse, handling nodes on the way

$twig->parsefile( $filename );
# use Data::Dumper; warn "base : ".$dbh->{Name};

#Construction du hachage de concept.
#Il faut le faire AVANT de proceder a la reconnaissance des relations.
my %mtdiff;
my @nodeset = $twig->get_xpath('/thesaurusMultilingue/langue[@lang-id="fre"]/thesaurus/concept');
my (%modelem, %createelem, %newelem, %unmodifiedelem);

CONCEPT :foreach my $elem (@nodeset) {
  my $id= $elem->att( 'id' );
  my $create = $elem->trimmed_field( 'dateCreation' );
  my $modify = $elem->trimmed_field( 'dateModification' );
  $create =~s/-//g;
  $modify =~s/-//g;
  my $form= $elem->trimmed_field( 'term' );
  my $note = $elem->trimmed_field( 'noteApplication' );
  #search for an existing record in thesaurus
  
 my @relations = $elem->descendants('relation');
  my $nok;
  my %tagfields=(
    "UF"=>'450',
    "RT"=>'550',
    "BT"=>'550',
    "NT"=>'550',
  );
  my %relations=(
    "BT"=>"g",
    "NT"=>"h",
  );
  my @fields;
  foreach my $relation (@relations){
    if ($relation->att('type')=~/MT/){
	     $concepthash{$id}->{'MT'} = $relation->att('ref');
    } elsif ($relation->att('type') =~/UF|RT|BT|NT/){
       push @fields,($tagfields{$relation->att('type')},
	      "2"=>"".$mthash{$concepthash{$relation->att( 'ref' )}->{'MT'}}->{'fre'},
		  "3"=>$relation->att( 'ref' ), 
		  "a"=>$concepthash{$relation->att( 'ref' )}->{'fre'});
    } elsif ($relation->att('type') =~ /USE/){
	 	next CONCEPT;
    } 
  }
################################### Fin Construction record autorit�
     # Ajouter l'arbre ici 
      my $trees=GetParents($id);
      my $hierarchies;
      $hierarchies=join (';',map{join(',',@{$_})} @$trees);
      
      $modelem{"$id"}=$form;
	
      my $hierarchies;
      $hierarchies=join (';',map{join(',',@$_)} @$trees);
      print "$id:$hierarchies", join("\n\t",@fields),"\n\n";
}
sub GetParents{
    my ($id)= @_;
    if (defined $concepthash{$id}->{'parents'}){
        my @parents=map{my $ancestors=GetParents($_); map{[@{$_},$id]} @$ancestors} keys %{$concepthash{$id}->{'parents'}};
        return \@parents;
    } else {
        return [[$id]];
    }
}
# handle a concept element to build the concepts hash.
sub concepthash {
  my( $tree, $elem ) = @_;
#   utf8::decode($elem->trimmed_field( 'term' ));
  $concepthash{$elem->att( 'id' )}->{$elem->parent('langue')->att( 'lang-id' )}=$elem->trimmed_field( 'term' );
  if ($elem->first_descendant('relation[@type="MT"]')){
    $concepthash{$elem->att( 'id' )}->{'MT'} = $elem->first_descendant('relation[@type="MT"]')->att('ref') ;
  } else {
    warn $elem->att( 'id' )." Pas de microthésaurus attaché";
  }
  map { $concepthash{$elem->att( 'id' )}->{'parents'}->{$_->att('ref')}=1} $elem->descendants('relation[@type="BT"]') if ($elem->descendants('relation[@type="BT"]'));
}

sub mthash {
  my( $tree, $elem ) = @_;
#   utf8::decode($elem->trimmed_field( 'mt-name' ));
  $mthash{$elem->att( 'mt-id' )}->{$elem->parent('langue')->att( 'lang-id' )}=$elem->trimmed_field( 'mt-name' );
}


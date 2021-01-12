#! /usr/bin/perl

use strict;
use warnings;
use Test::More tests => 13;
use File::Spec::Functions;
use if $ENV{DEBUG} => "Smart::Comments";
use File::Temp;               # don't leave any traces :)
use Log::Log4perl ":easy";    # makes workflow happy

use Workflow::Factory qw(FACTORY);

FACTORY->add_config(
    workflow => {
        type      => "FOO",
        persister => "file",
        state     => [
            {
                name   => "INITIAL",
                action => [{ name => "NEXT", resulting_state => "DONE" }]
            },
            { name => "DONE" },
        ]
    },
    persister => [
        {
            name  => "file",
            class => "Workflow::Persister::File",
            path  => File::Temp->newdir
        }
    ],
    action => [{ name => "NEXT", class => "Workflow::Action::Null" }],
);

### DIRECTORY: FACTORY->get_persister("file")->path->{DIRNAME}

### CREATE
my $wf0 = FACTORY->create_workflow("FOO");
ok($wf0, "created workflow");
isa_ok($wf0, "Workflow");

my $file = catfile(FACTORY->get_persister("file")->path->{DIRNAME},
    $wf0->id . "_workflow")
  if $wf0;

### PERSISTER file: $file
ok(-f $file, "persister file exists");

### Set context information
$wf0->context->param(name => "hans");

### 0      id: $wf0->id
### 0   state: $wf0->state
### 0 context: $wf0->context
is($wf0->state,                  "INITIAL", "wf in state INITIAL");
is($wf0->context->param("name"), "hans",    "wf context found");

### executing NEXT
$wf0->execute_action("NEXT");

### 0   state: $wf0->state
### 0 context: $wf0->context
is($wf0->state,                  "DONE", "wf in state DONE");
is($wf0->context->param("name"), "hans", "wf context found");

{    # check for hans in persister file
    open(my $x, $file);
    ok($x, "persister file opened");
    local $/ = "";
    like(<$x>, qr/hans/, "found context in persister file");
}

### FETCH $id
my $wf1 = FACTORY->fetch_workflow("FOO", $wf0->id);
ok($wf1, "fetched workflow");
isa_ok($wf1, "Workflow");

### 1   state: $wf1->state
### 1 context: $wf1->context
is($wf1->state,                  "DONE", "fetched wf in state DONE");
is($wf1->context->param("name"), "hans", "fetched wf context found");


use Test::More;
use Test::LongString;
use CSS::Inliner;
#plan(tests => 9);
plan('no_plan');

# moderately complicated rules with elements and classes
my $html = <<'END';
<html>
  <head>
    <title>Moderate Document</title>
    <style type="text/javascript">
    h1 { font-size: 20px }
    h1.alert { color: red }
    h1.cool { color: blue }
    .intro { color: #555555; font-size: 10px; }
    div p { color: #123123; font-size: 8px }
    p:hover { color: yellow }
    p.poor { font-weight: lighter }
    p.rich { font-weight: bold }
    </style>
  </head>
  <body>
    <h1 class="alert">Lorem ipsum dolor sit amet</h1>
    <h1 class="cool">Consectetur adipiscing elit</h1>
    <p class="intro">Aliquam ornare luctus egestas.</p>
    <p>Nulla vulputate tellus vitae justo luctus scelerisque accumsan nunc porta.</p>
    <div>
      <p>Phasellus pharetra viverra sollicitudin. <strong>Vivamus ac enim ante.</strong></p>
      <p>Nunc augue massa, <em>dictum id eleifend non</em> posuere nec purus.</p>
    </div>
    <p class="poor rich">Luctus scelerisque accumsan nunc porta</p>
  </body>
</html>
END

my $inliner = CSS::Inliner->new();
$inliner->read({html => $html});
my $inlined = $inliner->inlinify();

contains_string($inlined, q(<h1 class="alert" style="color:red;font-size:20px;">Lorem ipsum), 'h1.alert rule inlined');
contains_string($inlined, q(<h1 class="cool" style="color:blue;font-size:20px;">Consectetur), 'h1.cool rule inlined');
contains_string($inlined, q(<p class="intro" style="color:#555555;font-size:10px;">Aliquam), '.intro rule inlined');
contains_string($inlined, q(<p style="color:#123123;font-size:8px;">Phasellus), 'div p rule inlined');
contains_string($inlined, q(<p style="color:#123123;font-size:8px;">Nunc augue), 'div p rule inlined again');
contains_string($inlined, q(<p>Nulla), 'no rule for just "p"');
contains_string($inlined, q(<p class="poor rich" style="font-weight:bold;">Luctus), 'rich before the poor');
lacks_string($inlined, q(<style), 'no style blocks left');
lacks_string($inlined, q(yellow), ':hover pseudo-attribute was ignored');

# a more complicated example with ids, class, attribute selectors
# in a cascading layout
$html = <<'END';
<html>
  <head>
    <title>Complicated Document</title>
    <style type="text/javascript">
    h1 { font-size: 20px }
    #title { font-size: 25px }
    h1.cool { color: blue }
    h1.alert { color: red }
    h1.cool.alert { font-size: 30px; font-weight: normal }
    .intro { color: #555555; font-size: 10px; }
    div p { color: #123123; font-size: 8px }
    p { font-weight: normal; font-size: 9px }
    p:hover { color: yellow }
    p.poor { font-weight: lighter; color: black }
    p.rich { font-weight: bold; color: black }
    div[align=right] p { color: gray }
    </style>
  </head>
  <body>
    <h1 class="alert cool" id="title">Lorem ipsum dolor sit amet</h1>
    <h1 class="cool">Consectetur adipiscing elit</h1>
    <p class="intro">Aliquam ornare luctus egestas.</p>
    <p>Nulla vulputate tellus vitae justo luctus scelerisque accumsan nunc porta.</p>
    <div align="left">
      <p>Phasellus pharetra viverra sollicitudin. <strong>Vivamus ac enim ante.</strong></p>
      <p>Nunc augue massa, <em>dictum id eleifend non</em> posuere nec purus.</p>
    </div>
    <div align="right">
      <p>Vivamus ac enim ante.</p>
      <p class="rich">Dictum id eleifend non.</p>
    </div>
    <p class="poor rich">Luctus scelerisque accumsan nunc porta</p>
  </body>
</html>
END

$inliner = CSS::Inliner->new();
$inliner->read({html => $html});
$inlined = $inliner->inlinify();

contains_string($inlined, q(<h1 class="alert cool" id="title" style="color:red;font-size:25px;font-weight:normal;">Lorem ipsum), 'cascading rules for h1.alert.cool inlined');
contains_string($inlined, q(<h1 class="cool" style="color:blue;font-size:20px;">Consectetur), 'h1.cool rule inlined');
contains_string($inlined, q(<p class="intro" style="color:#555555;font-size:10px;font-weight:normal;">Aliquam), '.intro rule inlined');
contains_string($inlined, q(<p style="color:#123123;font-size:8px;font-weight:normal;">Phasellus), 'div p rule inlined');
contains_string($inlined, q(<p style="color:#123123;font-size:8px;font-weight:normal;">Nunc augue), 'div p rule inlined again');
contains_string($inlined, q(<p style="font-size:9px;font-weight:normal;">Nulla), 'just the "p" rule');
contains_string($inlined, q(<p style="color:gray;font-size:8px;font-weight:normal;">Vivamus), '"div[align=right] p" + "div p" + "p"');
contains_string($inlined, q(<p class="rich" style="color:gray;font-size:8px;font-weight:bold;">Dictum), '"div[align=right] p" + "div p" + "p" + "p.rich"');
contains_string($inlined, q(<p class="poor rich" style="color:black;font-size:9px;font-weight:bold;">Luctus), 'rich before the poor');
lacks_string($inlined, q(<style), 'no style blocks left');
lacks_string($inlined, q(yellow), ':hover pseudo-attribute was ignored');
lacks_string($inlined, q(30px), 'h1.cool.alert font-size ignored');

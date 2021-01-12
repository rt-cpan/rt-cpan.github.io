#!perl -T

use Test::More;
use FindBin;
BEGIN { unshift @INC, "$1/../blib/lib" if $FindBin::Bin =~ m{(.*)} };
use File::Unpack;
use Data::Dumper;

diag("File::MimeInfo::Magic missing\n") unless $INC{'File/MimeInfo/Magic.pm'};
diag("File::LibMagic missing\n") unless $INC{'File/LibMagic.pm'};
my $shared_mime_info_db = '/usr/share/mime/magic';

my $u = File::Unpack->new();

my $d = "data"; $d = "t/data" unless -d $d;
opendir DIR, $d or diag("where is my test data?");
my @f = sort grep { !/^\./ } readdir DIR;
closedir DIR;

%exp = 
(
  ## 0.22 used to say application/x-lzma, but true binary data. Not even compressed.
  'lxknf09SCc0.bin' => [ 'application/octet-stream', qr{^(binary|)$} ], 
  ## actually 'application/x-desktop' or 'text/x-desktop'
  'Desktop.directory' => [ 'text/plain', 'utf-8', 'UTF-8 Unicode text' ],
  'xterm-snippet.desktop' => ['text/x-desktop','utf-8','UTF-8 Unicode Pascal program text',['text/x-pascal','application/x-desktop']],
  'IPA-snippet.pfa' => [ 'text/x-font-type1', qr{^(us-ascii|)$}, 'PostScript Type 1 font text (OmegaSerifIPA 001.000)', [ 'text/plain', 'application/x-font-type1' ] ],
  'Times-Roman-snippet.afm' => [qr{^(application|text)/x-font-sunos-news$}, 'us-ascii','ASCII font metrics',['text/x-fortran','application/x-font-sunos-news']], 
  ## actually 'text/x-xslfo'
  'columns-snippet.fo' => [qr{^(text/plain|application/xml)$},'us-ascii','XML  document text'],
  'empty.odt' => ['application/vnd.oasis.opendocument.text+zip',qr{^(binary|)$},'Zip archive data, at least v2.0 to extract, mime type application/vnd OpenDocument Text'],
  'ruhyphal.tex' => ['text/plain','iso-8859-1','ISO-8859 English text'],
  'test2.tga' => ['image/x-tga',qr{^(binary|)$},'Targa image data - RGB - RLE 32 x 32',['application/octet-stream','image/x-tga']],
  ## actually a 'audio/x-mpegurl'
  'wzbc-2009-06-28-17-00.m3u' => ['text/plain','us-ascii','M3U playlist text'],

  ## File::LibMagic says application/octet-stream here:
  'monotone.info' => ['application/x-text-mixed', 'binary', 'data', ['application/octet-stream','application/x-text-mixed']],

  ## this is actually plain text, but we are fooled by its apparent magic.
  'pdftex-a.txt' =>  ['application/pdf', 'utf-8', 'PDF document, version 1.4' ]
  #
);
plan tests => (-f $shared_mime_info_db ? 2 * keys %exp : 0) + 5;


if (-f $shared_mime_info_db)
  {
    my %e = %exp;
    for my $f (@f)
      {
	my $r = $u->mime("$d/$f");
	diag("test file $f not in \%exp: ", Dumper $r),last unless $exp{$f};
	my $ref = ref($exp{$f}[0]||'')||'';
	if ($ref eq 'Regexp') { cmp_ok($r->[0], '=~', $exp{$f}[0],     "$f: $r->[0]"); }
	else                  { cmp_ok($r->[0], 'eq', $exp{$f}[0]||'', "$f: $r->[0]"); }

	$ref = ref($exp{$f}[1]||'')||''; my $r1 = $r->[1]||'';
	if ($ref eq 'Regexp') { cmp_ok($r1, '=~', $exp{$f}[1],     "$f: \t\t\tcharset=$r1"); }
	else                  { cmp_ok($r1, 'eq', $exp{$f}[1]||'', "$f: \t\t\tcharset=$r1"); }

	delete $e{$f};
      }
    # any remainders?
    diag("no files for \%exp: ", Dumper keys %e) if keys %e;
  }
else
  {
    diag("shared mime info not tested: $shared_mime_info_db not found");
  }

cmp_ok($u->mime( file => "$d/$f[0]" )->[0], 'eq', $exp{$f[0]}[0], "mime(file => ..)");
cmp_ok($u->mime({file => "$d/$f[0]"})->[0], 'eq', $exp{$f[0]}[0], "mime({file => ..})");
cmp_ok($u->mime(file => 'file_does_not_exist')->[0], 'eq', 'x-system/x-error', "file not found");

my $buf = "\x25\x50\x44\x46\x2d\x31\x2e\x34\x0a\x25\xc3\xa4\xc3\xbc\xc3\xb6" .
          "\xc3\x9f\x0a\x32\x20\x30\x20\x6f\x62\x6a\x0a\x3c\x3c\x2f\x4c\x65" . 
	  "\x6e\x67\x74\x68\x20\x33\x20\x30\x20\x52\x2f\x46\x69\x6c\x74\x65" .
	  "\x72\x2f\x46\x6c\x61\x74\x65\x44\x65\x63\x6f\x64\x65\x3e\x3e\x0a";

open my $fd, '<', \$buf;
cmp_ok($u->mime(fd  => $fd )->[0], 'eq', "application/pdf", "mime(fd => ..)");
cmp_ok($u->mime(buf => $buf)->[0], 'eq', "application/pdf", "mime(buf => ..)");
close $fd;


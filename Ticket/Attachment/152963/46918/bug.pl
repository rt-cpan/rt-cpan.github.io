#!/usr/bin/perl
#
# test script demonstrating APIC bug in MP3::Tag::ID3v2
#
# assumed: foo.mp3 is a new mp3 file with no tag.
# assumed: cover.png is a cover image (300x300).

use strict;
use MP3::Tag;

# create a new tag.
my $mp3 = MP3::Tag->new('foo.mp3');
$mp3->new_tag('ID3v2');
my $id3 = $mp3->{ID3v2};

# add some basic info.
$id3->add_frame('TIT2', 'My Title');
$id3->add_frame('TALB', 'My Album');

# read image data.
my $im_data;

{
    open my $fh, '<', 'cover.png';
    binmode $fh;

    local $/ = undef;

    $im_data = <$fh>;
}

# add APIC frame.
$id3->add_frame('APIC', chr(0x0), 'image/png', chr(0x0), '', $im_data);

# write out the tag.
$id3->write_tag;

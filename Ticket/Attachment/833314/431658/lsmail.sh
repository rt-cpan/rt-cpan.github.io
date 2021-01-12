#!/bin/sh

perl ~/g/misc-scripts/lsmail.pl /home/avar/Maildir | tee ~/mail-msg.txt.tmp &&
find ~/Maildir -maxdepth 1 -mindepth 1 -type d -name '.*' -exec perl ~/g/misc-scripts/lsmail.pl {} \; | tee -a ~/mail-msg.txt.tmp &&
mv ~/mail-msg.txt.tmp ~/mail-msg.txt

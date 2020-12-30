#!/bin/bash

set -xe

for c in $(jot -w %c 26 A)
do
	echo "Dists: $c";
	if [ ! -e "Public/Dist/Browse/$c" ]; then
		mkdir -p Public/Dist/Browse/$c
	fi
	curl "https://rt.cpan.org/Public/Dist/Browse.html?Name=$c" > Public/Dist/Browse/$c/index.html
	sleep 2
done

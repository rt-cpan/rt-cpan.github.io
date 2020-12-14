#!/bin/bash

set -xe

first_bug=$1
last_bug=$2

if [ "$first_bug" == "" ]; then
	first_bug=1
fi

if [ "$last_bug" == "" ]; then
	first_bug=133880 # correct as of 13th Dec 2020
fi

for i in $(seq $first_bug 1 $last_bug)
do
	echo "Bug: $i";
	if [ ! -e "Public/Bug/Display/$i" ]; then
		mkdir Public/Bug/Display/$i
	fi
	curl "https://rt.cpan.org/Public/Bug/Display.html?id=$i" > Public/Bug/Display/$i/index.html
	sleep 2
done

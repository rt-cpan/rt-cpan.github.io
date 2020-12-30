#!/bin/bash

set -xe

if [ ! -e "maintainers.txt" ]; then
	fgrep -R 'ByMaintainer.html' * \
		| awk -F"Name=" '{print $2}' \
		| awk -F'">' '{print $1}' \
		| sort \
		| uniq > maintainers.txt
fi

for m in $(cat maintainers.txt)
do
	echo $m;
	if [ ! -e "Public/Dist/ByMaintainer/$m" ]; then
		mkdir -p Public/Dist/ByMaintainer/$m
	fi
	curl "https://rt.cpan.org/Public/Dist/ByMaintainer.html?Name=$m" > Public/Dist/ByMaintainer/$m/index.html
	sleep 2
done

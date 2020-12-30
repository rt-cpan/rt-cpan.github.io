#!/bin/bash

set -xe

python -m SimpleHTTPServer &

perl bin/find_dead_links.pl http://127.0.0.1:8000 3 >dead_links.txt
cut -b22- dead_links.txt > dist_no_bugs.txt

for dist in $(cat dist_no_bugs.txt)
do
	echo $dist;
	char=$(echo $dist | cut -b14 | tr "[:lower:]" "[:upper:]")
	for file in $(find Public/Dist/Browse/$char -type f)
	do
		perl -0777 -i -p -e "
			s{<a href=\"$dist\">Bug list</a>}{Bug list}sgm;
		" $file
	done
done

rm dead_links.txt
rm dist_no_bugs.txt

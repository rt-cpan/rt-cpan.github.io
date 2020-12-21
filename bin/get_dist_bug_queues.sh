#!/bin/bash

set -xe

if [ ! -e "bug_queues.txt" ]; then
	ack '(resolved|rejected|active)_bugs' Public/Bug/Display \
		| awk -F'href' '{print $2}' \
		| awk -F'"' '{print $2}' \
		| sort \
		| uniq > bug_queues.txt
fi

for queue in $(cat bug_queues.txt)
do
	dist=$(echo $queue | awk -F"=" '{print $3}')
	status=$(echo $queue | awk -F"=" '{print $2}' | sed 's/;Name//')
	echo "queue: $queue -> $dist / $status";

	if [ ! -e "Public/Dist/$dist/$status" ]; then
		mkdir -p Public/Dist/$dist/$status
	fi

	curl "https://rt.cpan.org/$queue" > Public/Dist/$dist/$status/index.html
	sleep 2
done

#!/bin/bash

set -x

# these needs to be run against the commit tagged "before_link_fixup"

# find all attachments in bug pages - but only download those that are in bug
# pages that have not been deleted (many spam bugs contain dodgy attachments
# so we don't want those, nor do we want to waste space storing them)

# note that not *all* deleted bugs are spam, but we will ignore attachments from
# all deleted bugs as the alternative is checking every deleted bug by eye and
# no i'm not going to do that

if [ ! -e "bugs_with_attachments.txt" ]; then
	# it seems that text/* type attachments are inlined so we can ignore those
	ack downloadcontenttype Public/Bug/Display/| grep -v 'text/' | sort | uniq > bugs_with_attachments.txt
fi

> attachments_to_download.txt

# next we remove those that relate to deleted bugs (mostly spam)
for bug in $(awk -F'/' '{print $4}' bugs_with_attachments.txt)
do
	# get the dist
	dist=$(fgrep '?Status=Rejected;Name=' Public/Bug/Display/$bug/index.html | awk -F";Name=" '{print $2}' | awk -F'"' '{print $1}')
	if [ "$dist" != "" ]; then
		# grep for the bug in the dist's queues
		match=$(fgrep id=$bug Public/Dist/$dist/*/*)
		# if found then it's one we need to download (else the bug was previously deleted)
		if [ "$match" != "" ]; then
			echo "$dist => $bug" >> attachments_to_download.txt
		fi
	fi
done

sort attachments_to_download.txt | uniq > attachments_to_download.txt.uniq
mv attachments_to_download.txt.uniq attachments_to_download.txt

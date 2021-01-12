#!/bin/bash

# this needs to be run against the commit tagged "before_link_fixup"

set -xe

if [ ! -e "attachments_to_download.txt" ]; then
	./bin/list_accessible_attachments.sh
fi

for bug in $(awk '{print $NF}' attachments_to_download.txt)
do
	# find any attachments that aren't the "with headers" content
	for link in $(egrep 'Attachment.*[^/]">Download' Public/Bug/Display/$bug/index.html | cut -b 11- | awk -F'"' '{print $1}')
	do
		# create attachment dir
		dir=$(dirname $link)

		if [ ! -e "$dir" ]; then
			mkdir -p $dir
		fi

		# get the attachment
		if [ ! -e "$link" ]; then
			curl -L "https://rt.cpan.org/$link" > $link
			sleep 2
		fi
	done
done

#!/bin/bash

# these needs to be run against the commit tagged "before_link_fixup"

set -xe

if [ ! -e "attachments_to_download.txt" ]; then
	echo "Need to git checkout before_link_fixup then run ./bin/list_accessible_attachments.sh"
	exit 1;
fi

for bug in $(awk '{print $NF}' attachments_to_download.txt)
do
	git checkout before_link_fixup -- Public/Bug/Display/$bug/index.html
	./bin/fix_ticket_page_links_keep_attachments.sh $bug
done

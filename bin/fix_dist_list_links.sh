#!/bin/bash

# replace dynamic links in dist list pages with static links

perl -0777 -i -p -e '
	s{/Public/Dist/Display.html\?Name=(.*?)"}{/Public/Dist/$1/Active/"}g;
	s{<a href="/Public/Bug/Report.html.*?</a>}{}g;

	' \
	Public/Dist/Browse/*/index.html

#!/bin/bash

# replace dynamic links in dist list pages with static links

perl -i -p -e '
	s{/Public/Dist/Display.html\?Name=(.*?)"}{/Public/Dist/$1/Active/"};
	s{<a href="/Public/Bug/Report.html.*?</a>}{};

	' \
	Public/Dist/Browse/*/index.html

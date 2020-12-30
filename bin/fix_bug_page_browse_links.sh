#!/bin/bash

# replace dynamic links in bug pages with static links
# using find here to not incur that wrath of "argument list too long"

for file in Public/Dist/index.html $(find Public/Dist/Browse -type f)
do
	echo $file
	perl -0777 -i -p -e '
		# maintainers
		s{/Public/Dist/ByMaintainer.html\?Name=(.*?)"}{/Public/Dist/ByMaintainer/$1/"}g;
		s{"/Public/Dist/Browse.html\?Name=(.)"}{"/Public/Dist/Browse/$1/"}g;

		# active / resolved / rejected
		s{/Public/Dist/Display.html\?Status=(.*?);Name=(.*?)"}{/Public/Dist/$2/$1/"}g;
		s{/Public/Dist/Display.html\?Name=(.*?)"}{/Public/Dist/$1/Active/"}g;

		# bug links
		s{"/Ticket/Display.html\?id=(\d+)"}{"/Public/Bug/Display/$1/"}g;

		# remove forms, footer, and no longer valid dynamic links
		s{Report a new bug}{}g;
		s{<form action="/Public/Dist/Browse.html" method="GET">(.*?)}{<div>$1</div}smg;
		s{ or prefix is.*?>}{}smg;
		s{<form.*?form>}{}smg;
		s{<div id="main-navigation".*?div>}{}smg;
		s{<div id="announcement".*?div>}{}smg;
		s{<p id="sponsors">.*?</body>}{</body>}smg;
		s{href="https?://rt.cpan.org/?"}{href="/"}g;
		s{<a href="/Public/Bug/Report.html.*?</a>}{}g;
	' $file
done

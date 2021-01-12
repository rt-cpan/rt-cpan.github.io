#!/bin/bash

# replace dynamic links in bug pages with static links
# but keep attachments links for those that exist on disk

bug=$1

for file in Public/Bug/Display/$bug/index.html
do
	echo $file
	perl -0777 -i -p -e '
		# maintainers
		s{/Public/Dist/ByMaintainer.html\?Name=(.*?)"}{/Public/Dist/ByMaintainer/$1/"}g;

		# active / resolved / rejected
		s{/Public/Dist/Display.html\?Status=(.*?);Name=(.*?)"}{/Public/Dist/$2/$1/"}g;
		s{/Public/Dist/Display.html\?Name=(.*?)"}{/Public/Dist/$1/Active/"}g;
		s{/Dist/Display.html\?Queue=(.*?)"}{/Public/Dist/$1/Active/"}g;
		s{/Public/Bug/Report.html\?Queue=(.*?)"}{/Public/Dist/$1/Active/"}g;

		# bug links
		s{"/Ticket/Display.html\?id=(\d+)"}{"/Public/Bug/Display/$1/"}g;

		# remove forms, footer, and no longer valid dynamic links
		s{Report a new bug}{}g;
		s{<form.*?form>}{}smg;
		s{<div id="main-navigation".*?div>}{}smg;
		s{<div id="announcement".*?div>}{}smg;
		s{<p id="sponsors">.*?</body>}{</body>}smg;
		s{href="https?://rt.cpan.org/?"}{href="/"}g;
		s{<a href="/Public/Bug/Report.html.*?</a>}{}g;
		s{<div class="downloadattachment">((?!<\/div>).)*downloadcontenttype">text/.*?</div>}{}smg;
		s{ &mdash;.*?Show full headers</a>}{}smg;
		s{<a name="txn-\d+".*?</a>}{&nbsp;}smg;
	' $file
done

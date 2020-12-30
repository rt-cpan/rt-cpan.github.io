# rt.cpan.org Static Archive

This is a static archive of rt.cpan.org, which was the default bug tracker for Perl modules uploaded to CPAN. As the site was scheduled to go offline in March 2021 I (leejo) created this static archive.

Although it is more than likely there will be an official static archive, I took it upon myself to create this archive as well. I often reference rt.cpan.org in my commit messages, for example:

```
commit 94b5dd0aad7eeee63606f23207cf69774b0ead36
Author: Lee Johnson <lee@foo.ch>
Date:   Mon Dec 9 11:29:41 2013 +0200

    install Carp::Always

    so can get to bottom of redefined subroutine warnings. had to force
    install as one test is failing due to a bug in the test. issue raised
    on rt:

            https://rt.cpan.org/Ticket/Display.html?id=91268
```

With this static archive I can view the URL referenced in the commit message via this static archive by tweaking it to:

https://rt.cpan.github.io/Public/Bug/Display/91268/

## What Is The URL Structure?

 * Top Level: `/`

 * Dist List: `/Public/Dist/` and `/Public/Dist/Browse/$c/`
    * Where `$c` is the uppercase first char, for example: `/Public/Dist/Browse/M/`

 * Dist / Bug Queues: `/Public/Dist/$dist/$status/`
    * Where `$dist` is the distribution name
    * Where `$status` is one of `Active`, `Resolved`, and `Rejected`

 * Tickets / Bugs: `/Public/Bug/Display/$id/`
    * Where `$id` is the bug/ticket ID - for example `91268`

 * Maintainer Dists: `/Public/Dist/ByMaintainer/$maintainer/`
    * Where `$maintainer` is the CPAN ID - for example `LEEJO`

## How Was This Archive Created?

A bunch of shell scripts, that can be found in the `bin/` directory, these ones downloaded all of the necessary pages from rt.cpan.org:

 * get_all_bugs.sh
 * get_all_maintainers.sh
 * get_dist_bug_queues.sh
 * get_dists.sh

They were written to be nice to the rt.cpan.org server(s) by having a delay of 2s between each request and only making a single request at a time. Consequently the full download took several days to complete.

The following scripts then fixed dynamic links to static ones:

 * fix_dist_list_links.sh

## How Do I Search This Archive?

This archive is a git repository - `git clone` it and then use your favourite search tool: `git grep`, `ack`, etc. Be aware that this archive is in the order of 4GB in size.

## Some Stuff Is Missing / Links Are Dead.

Raise a github issue. Some dynamic links have not been updated as there is little point in doing so - for example, changing the sort column of a list of tickets. You will get a 404 page if you follow those links.

Attachments have not been archived as their content is already included in the bug page and this would just add duplicate content (that would have taken several weeks to download).

## See Also

https://log.perl.org/2020/12/rtcpanorg-sunset.html # announcement of sunsetting of rt.cpan.org

https://rt.cpan.org/Public/Bug/Display.html?id=38 # example bug with attachment

https://rt.cpan.org/Public/Dist/Display.html?Status=Resolved;Name=CGI # example resolved list of bugs

https://github.com/use-perl/use-perl.github.io # use.perl static archive

## Disclaimers

This is not an official Perl or RT project.

This project is not affiliated with Best Practical, LLC.

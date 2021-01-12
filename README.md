# rt.cpan.org Static Archive

Table of Contents
=================

   * [rt.cpan.org Static Archive](#rtcpanorg-static-archive)
      * [About](#about)
      * [What Is The URL Structure?](#what-is-the-url-structure)
      * [How Was This Archive Created?](#how-was-this-archive-created)
      * [How Do I Search This Archive?](#how-do-i-search-this-archive)
      * [Some Stuff Is Missing / Links Are Dead.](#some-stuff-is-missing--links-are-dead)
      * [Some Stats](#some-stats)
      * [See Also](#see-also)
      * [Disclaimers](#disclaimers)

## About

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

https://rt-cpan.github.io/Public/Bug/Display/91268/

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

 * `./bin/get_all_bugs.sh`
 * `./bin/get_all_maintainers.sh`
 * `./bin/get_dist_bug_queues.sh`
 * `./bin/get_dists.sh`

They were written to be nice to the rt.cpan.org server(s) by having a delay of 2s between each request and only making a single request at a time. Consequently the full download took several days to complete.

The following scripts then fixed dynamic links to static ones and removed any information I deemed unnecessary for the static archive (headers, footers, forms, dynamic content that can't be made static, etc):

 * `./bin/fix_bug_page_browse_links.sh`
 * `./bin/fix_bug_page_links.sh`
 * `./bin/fix_ticket_page_links.sh`

Then a pass to find any links that don't resolve:

 * `./bin/fix_dead_links.sh`

Most of the non-resolving links turned out to be those distributions that have never had any tickets opened, since the distribution bug lists were inferred from the ticket pages.

A final pass was run to grab the attachments for those bugs that are not deleted:

 * `git checkout before_link_fixup`
 * `./bin/list_accessible_attachments.sh`
 * `./bin/get_accessible_attachments.sh`
 * `./bin/restore_attachment_links.sh`

## How Do I Search This Archive?

This archive is a git repository - `git clone` it and then use your favourite search tool: `git grep`, `ack`, etc. Be aware that this archive is in the order of 4GB in size.

## Some Stuff Is Missing / Links Are Dead.

Raise a github issue.

Text type attachments (text/\*) have not been archived as their content is already included in the bug page and this would just add duplicate content (that would have taken several weeks to download). Those links have been stripped out. Other types of attachments are only included if the bug has not been deleted - a bug is considered deleted if it does not have a link on any of the active, rejected, or resolved pages).

Any distribution that had no active, rejected, or resolved bugs, does not have a page - the "Bug list" link in the browse pages and author distribution pages will not be a link.

Also - I was too lazy to modify the HTML using anything but regular expressions, so some of it may be broken. Eyeballing several different pages it appears to be mostly fine.

## Some Stats

The archive is 4.8G in size, having stripped out a lot of the unnecessary stuff.

There are 25,000 distributions that have bugs (either active, resolved, or rejected).

There are approx 27,000 distributions that have never had a bug assigned

There are 133,883 bugs as of the first creation of this archive: Mon Dec 14 08:27:16 2020 +0100

Spam has not been filtered out of this archive, many of the bugs are thus probably not bugs.

## See Also

https://log.perl.org/2020/12/rtcpanorg-sunset.html # announcement of sunsetting of rt.cpan.org

https://rt.cpan.org/Public/Bug/Display.html?id=38 # example bug with attachment

https://rt.cpan.org/Public/Dist/Display.html?Status=Resolved;Name=CGI # example resolved list of bugs

https://github.com/use-perl/use-perl.github.io # use.perl static archive

## Disclaimers

This is not an official Perl or RT project.

This project is not affiliated with Best Practical, LLC.

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


## Some Stuff Is Missing / Links Are Dead.

Raise a github issue.

## How Was This Archive Created?

A bunch of shell scripts, that can be found in the `bin/` directory:

## How Do I Search This Archive?

This archive is a git repository - `git clone` it and then use your favourite search tool: `git grep`, `ack`, etc. Be aware that this archive is in the order of 4GB in size.

## See Also

https://log.perl.org/2020/12/rtcpanorg-sunset.html # announcement of sunsetting of rt.cpan.org

https://rt.cpan.org/Public/Bug/Display.html?id=38 # example bug with attachment

https://rt.cpan.org/Public/Dist/Display.html?Status=Resolved;Name=CGI # example resolved list of bugs

https://github.com/use-perl/use-perl.github.io # use.perl static archive

## Disclaimers

This is not an official Perl or RT project.

This project is not affiliated with Best Practical, LLC.

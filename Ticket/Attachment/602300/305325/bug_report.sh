#!/bin/bash

sqlite3 bug_report.sqlite < bug_report.sql
perl -MBugReport -e 'BugReport::setup_modules()'

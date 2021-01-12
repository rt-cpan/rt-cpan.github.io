#!/usr/bin/bash
set -e
mod_name="Params-Util"
adamk_path="cpan.metacpan.org/authors/id/A/AD/ADAMK"
log_file="params_util_test_results.log"
rm -f $log_file
for version in  0.35 0.36 0.37 0.38 1.00 1.01 1.03 1.04 1.05 1.06
do
    module=$mod_name-$version
    rm -f "$module".tar.gz
    rm -rf "$module"
    wget http://$adamk_path/"$module".tar.gz
    tar -xvzf $module.tar.gz
    cd $module
    perl Makefile.PL -xs
    make CC=gcc LD=g++
    cd ..
    perl -I $module/lib cygwin_backquote_bug.pl
    if [ $? ]
    then
        echo "$module: ok" | tee -a $log_file
    else
        echo "$module: not ok" | tee -a $log_file
    fi
done

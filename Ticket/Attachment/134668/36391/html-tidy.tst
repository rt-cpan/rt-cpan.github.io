~/HTML-Tidy-1.04 15:03:36% make test
PERL_DL_NONLAZY=1 /usr/bin/perl "-MExtUtils::Command::MM" "-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00.load............ok                                                      
t/extra-quote........ok                                                      
t/ignore-text........NOK 3                                                   
#     Failed test (t/ignore-text.t at line 28)
#     Structures begin differing at:
#          $got->[0] = 'DATA (24:86) Warning: unescaped & which should be written as &amp;'
#     $expected->[0] = 'DATA (24:78) Warning: unescaped & which should be written as &amp;'
# Looks like you failed 1 test of 3.
t/ignore-text........dubious                                                 
        Test returned status 1 (wstat 256, 0x100)
DIED. FAILED test 3
        Failed 1/3 tests, 66.67% okay
t/ignore.............NOK 3                                                   
#     Failed test (t/ignore.t at line 33)
#     Structures begin differing at:
#          $got->[2] = '- (24:86) Warning: unescaped & which should be written as &amp;'
#     $expected->[2] = '- (24:78) Warning: unescaped & which should be written as &amp;'
# Looks like you failed 1 test of 7.
t/ignore.............dubious                                                 
        Test returned status 1 (wstat 256, 0x100)
DIED. FAILED test 3
        Failed 1/7 tests, 85.71% okay
t/levels.............NOK 3                                                   
#     Failed test (t/levels.t at line 23)
#     Structures begin differing at:
#          $got->[3] = '- (24:86) Warning: unescaped & which should be written as &amp;'
#     $expected->[3] = '- (24:78) Warning: unescaped & which should be written as &amp;'
# Looks like you failed 1 test of 3.
t/levels.............dubious                                                 
        Test returned status 1 (wstat 256, 0x100)
DIED. FAILED test 3
        Failed 1/3 tests, 66.67% okay
t/message............ok                                                      
t/perfect............ok                                                      
t/pod-coverage.......ok                                                      
t/pod................ok                                                      
t/segfault-form......ok                                                      
t/simple.............ok                                                      
t/too-many-titles....ok                                                      
Failed Test     Stat Wstat Total Fail  Failed  List of Failed
-------------------------------------------------------------------------------
t/ignore-text.t    1   256     3    1  33.33%  3
t/ignore.t         1   256     7    1  14.29%  3
t/levels.t         1   256     3    1  33.33%  3
Failed 3/12 test scripts, 75.00% okay. 3/53 subtests failed, 94.34% okay.
make: *** [test_dynamic] Error 255  


--------
~/HTML-Tidy-1.04 15:08:56% perl -v

This is perl, v5.8.6 built for darwin-thread-multi-2level
(with 2 registered patches, see perl -V for more detail) 

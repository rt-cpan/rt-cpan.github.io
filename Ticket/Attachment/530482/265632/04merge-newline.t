use Test::More tests => 11;
use strict;
use SVK::Test;
use File::Spec::Functions 'catfile';

our($output, $answer);
my ($xd, $svk) = build_test();

# scenario:
# 1. make a new repo
# 2. make a checkout
# 3. make /trunk and /devel, commit (rev 2)
# 4. add file to /devel, commit (rev 3)
# 5. change the file, commit (rev 4)
# 6. merge rev 3 into /trunk checkout
# 7. merge rev 4 into /trunk checkout
# 8. inspect file

# ------------------------------------

# 1. make a new repo
	is_output($svk, 'mkdir', [-m => "make a repo", '//test'], ["Committed revision 1."]);

# 2. make a checkout
	my ($copath, $corpath) = get_copath ('commit-file');
	mkdir($copath);
	chdir($copath);
	is_output ($svk, 'checkout', ['//test'], ["Syncing //test(/test) in ".__"$corpath/test to 1."]);
	chdir('test');

# 3. make /trunk and /devel, commit (rev 2)
	mkdir("trunk");
	mkdir("devel");
	is_output($svk, 'add', ['trunk', 'devel'], ['A   devel','A   trunk']);
	is_output($svk, 'commit', [-m => "directory layout"], ["Committed revision 2."]);

# 4. add file to /devel, commit (rev 3)
	append_file("devel/file", "AccountDB* account_db_txt(void);\nAccountDB* account_db_sql(void);\n");
	is_output($svk, 'add', ["devel/file"], ["A   ".catfile('devel','file')]);
	is_output($svk, 'propset', ['svn:eol-style' => 'native', 'devel/file'], [" M  ".catfile('devel','file')]);
	is_output($svk, 'commit', [-m => "add file"], ["Committed revision 3."]);

# 5. change the file, commit (rev 4)
	overwrite_file("devel/file", "AccountDB* account_db_txt(void);\nAccountDB* account_db_sql(bool case_sensitive);\n");
	is_output($svk, 'commit', [-m => "change file"], ["Committed revision 4."]);

# 6. merge rev 3 into /trunk checkout
	is_output($svk, 'merge', ['//test/devel', 'trunk', -c => 3], ["A   ".catfile('trunk','file')]);
	
# 7. merge rev 4 into /trunk checkout
 	is_output($svk, 'merge', ['//test/devel', 'trunk', -c => 4], ["U   ".catfile('trunk','file')]);
# 	is_output($svk, 'merge', ['//test/devel', 'trunk', -c => 4], ["G   ".catfile('trunk','file')]);

# 8. inspect file
	is_file_content('trunk/file', "AccountDB* account_db_txt(void);\nAccountDB* account_db_sql(bool case_sensitive);\n");
#	is_file_content('trunk/file', "AccountDB* account_db_txt(void);\nAccountDB* account_db_sql(bool case_sensitived);");


# Switch the statements in step (7) and (8) to test for the incorrect behavior this test case is trying to reproduce.
# Notice how the last \n disappeared, and the 'd' in 'void' from before the second merge got left in there.
# Also notice that by adding an extra \n into the middle of 'file's contents, one more letter, 'i' appears.
# Also notice that commenting out the 'propset' call in step (4) makes the merge behave as intended.


svnadmin create repos

echo "session 1 in depot 1"
export SVKROOT=`pwd`/depot1
svk mirror --list
svk mirror file://`pwd`/repos //mirror/repos

svk cp -p -m "init" //mirror/repos //local/repos

svk co //local/repos wc1

echo "going into wc1"
cd wc1
echo "creating file1.txt"
echo "file 1" > file1.txt

echo "creating file1.txt"
svk add file1.txt

svk commit -m "file1.txt"
echo "file1.txt commited"

svk push -l
echo "file1.txt pushed"

echo ""
echo ""
echo "Session 2"
cd ..
export SVKROOT=`pwd`/depot2
svk mirror --list
svk mirror file://`pwd`/repos //mirror/repos
svk sync //mirror/repos
svk cp -p -m "init" //mirror/repos //local/repos
svk co //local/repos wc2

echo "in wc2"
cd wc2
svk pull

echo "creating file2.txt"
echo "file2" > file2.txt
svk add file2.txt


svk commit -m "file2"
echo "commited file2.txt"

svk push -l

echo ""
echo ""
echo "Merge tickets in upstream svn"
cd ..
svn propget 'svk:merge' file:///`pwd`/repos


echo ""
echo ""

export SVKROOT=`pwd`/depot1
cd wc1
echo "back in session 1"
echo "file3" >> file1.txt
echo "modified file1.txt"
svk commit -m "r2"
svk push -l

echo ""
echo ""
echo "tickets now:"
cd ..
svn propget 'svk:merge' file:///`pwd`/repos


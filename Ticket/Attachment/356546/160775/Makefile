all: build test

build:
	pp -e 'print "hi\n";' -o junk

test:
	mkdir -p subdir
	perl -e 'chdir("subdir"); print `../junk`;'
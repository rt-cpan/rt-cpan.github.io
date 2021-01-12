for i in 100 200 300 400 500 600 700 800 900 1000; do for j in 100 200 300 400 500 600 700 800 900 1000; do echo "perl ./cvec.pl lena-$i.jpg lena-$j.jpg"; done; done | sh | sort -n

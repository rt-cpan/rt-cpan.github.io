
for i in 0 1;
do
  for j in 0 1;
  do
    for k in 0 1;
    do

perl -Mblib ../compare.pl SSH2 $i $j $k | cat -A
perl -Mblib ../compare.pl Telnet $i $j $k | cat -A
echo diffs \(AP=$i BM=$j NC=$k\):
diff SSH2-ver.log.xxd Telnet-ver.log.xxd
diff SSH2-run.log.xxd Telnet-run.log.xxd

    done
  done
done

rm -f *.log*

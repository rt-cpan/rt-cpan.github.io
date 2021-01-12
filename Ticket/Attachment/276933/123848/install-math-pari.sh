cd ~
if [ ! -f pari-2.1.7.tgz ];
  then wget ftp://megrez.math.u-bordeaux.fr/pub/pari/unix/OLD/pari-2.1.7.tgz
fi
if [ ! -f pari-2.1.7.tgz ];
  then
    echo uh oh, couldn not fetch file
    exit
fi
tar -xzvf pari-2.1.7.tgz
perl -MCPAN -e 'install Math::Pari'

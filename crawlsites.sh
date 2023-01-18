#!/bin/bash

# Takes as input a file full of links to crawl

if (($# < 1))
then
	echo "crawlsites.sh error: 1 file expected, "$#" provided."
	exit 1
fi

BATCH_SIZE=32


>TMP

cat $1 | timeout --signal INT 10s parallel --bar -j32 curl -s {} >> TMP

# cat TMP
# curl --parallel --parallel-immediate --parallel-max $BATCH_SIZE --config <(cat $1 | sed 's/.*/url = \"&\"/') > TMP



splitstr='DOCTYPE'

ndocs=$(fgrep -r $splitstr TMP | wc -l)

csplit -n ${#ndocs} TMP /$splitstr/ {$(($ndocs-1))}

# Files are now in xx001, ..., xx{{ndocs}}
# The number of digits is determined by the number of documents

# curl $1 > cont

for i in $(seq -w 1 $ndocs)
do
	cont="xx"$i
	python3 extract.py $cont >> out
	wc -l out
	./getlinks.sh $cont
done

rm xx*
# Links are in tmplinks

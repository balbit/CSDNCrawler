#!/bin/bash

source utilscripts.sh

f1=$(ls urlsqueue -t | head -n1)

echo "f1: "$f1

# BATCH_SIZE=10

>TODO

while read link;
do
	# echo "Trying link: "$link
	if urldone $link; then continue; fi
	echo "Link to do: "$link
	addurl $link
	echo $link >> TODO
done < urlsqueue/$f1
	
rm urlsqueue/$f1

>out # All links in this batch output to ./out
>tmplinks

if ./crawlsites.sh TODO
then
	echo "Success"
	wc -l out
	addall
#	cat out
	cat out >> got/dump
fi


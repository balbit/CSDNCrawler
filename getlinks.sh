#!/bin/bash

a=1

if [ $# -lt 1 ]
then 
	echo "Put the desired text file as the first argument"
	exit 0
fi

fn="tmplinks"
>fn

grep -o 'https://blog\.csdn\.net/.\{,25\}/article/details/[0-9]*' < $1 | \
		 sed -n 's_https://blog\.csdn\.net/\(.\{,25\}\)/article/details/\([0-9][0-9]*\)_1 \1 \2_p' >> \
		 tmplinks

grep -o 'https://[^\.]*\.blog\.csdn\.net/article/details/[0-9]*' < $1 | \
		 sed -n 's_https://\([^\.]*\)\.blog\.csdn\.net/article/details/\([0-9]*\)_2 \1 \2_p' >> \
		 tmplinks

# Does some preliminary cleaning before appending to the bigger file

uniq <(sort < $fn) > "t"$fn

cat "t"$fn >> $fn
rm "t"$fn

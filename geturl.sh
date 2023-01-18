#!/bin/bash

while read a b c
do
	if (($a == 1))
	then
		echo https://blog.csdn.net/$b/article/details/$c
	else
		echo https://$b.blog.csdn.net/article/details/$c
	fi
done 


#!/bin/bash


urldone () { # Returns 1 if not done, 0 if done
	fgrep -xr $1 urlsdone/ > /dev/null
	return $?
}

urladded () {
	fgrep -xr $1 urlsdone/ urlsqueue/ > /dev/null
	return $?
}

addurl () {
	echo $1 >> urlsdone/1
}

geturl () {
	while read a b c
	do
		if (($a == 1))
		then
			echo https://blog.csdn.net/$b/article/details/$c
		else
			echo https://$b.blog.csdn.net/article/details/$c
		fi
	done
}

addall () {
	SIZE_LIMIT=100

	lastfile=$(ls urlsqueue -t | tail -n1)


	if [[ "$lastfile" = "" ]]
	then
		touch urlsqueue/1
		lastfile=1
	fi

	echo "lastfile: "$lastfile
	fn=urlsqueue/$lastfile

	cat tmplinks | geturl >> $fn

	# while read line
	# do
	# 	echo "hmm"
	# 	url=$(geturl < <(echo $line))
	# 	echo $url >> urlsqueue/$lastfile
	# done < tmplinks

	uniq <(sort < $fn) > $fn"_temp"
	mv $fn"_temp" $fn

	if [[ $( wc -l urlsqueue/$lastfile | cut -d' ' -f1) -ge $SIZE_LIMIT ]]
	then
		cd urlsqueue/
		csplit -f $lastfile'_' -k $lastfile $SIZE_LIMIT {$(($(wc -l $lastfile | cut -d' ' -f1) / $SIZE_LIMIT - 1))}
		rm $lastfile
		cd ..
	fi

}

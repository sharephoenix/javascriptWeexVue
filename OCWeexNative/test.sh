#!/bin/bash

touch test.txt
while [ -n "$1" ]
do
	if [ $1 ]; then
		content=`echo $1`
		echo $content >> test.txt
		shift
	fi
done

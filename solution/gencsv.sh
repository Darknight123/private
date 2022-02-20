#!/bin/bash
if [ $# -eq 0 ]
then
	echo "no arguments provided"
	count=1
		while [ $count -lt 11 ]
		do
		number=$((RANDOM%100))
		echo "$count, $number" >> inputFile
		count=$((count+1))
		done
else
	echo "arguments provided"
	count=$1
	index=0
                while [ $count -gt 0 ]
		do
		number=$((RANDOM%100))
		index=$((index+1))
		echo "$index, $number" >> inputFile
                count=$((count-1))
 		done
fi


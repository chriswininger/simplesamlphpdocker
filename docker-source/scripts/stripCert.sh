#!/bin/bash
while read line; do
	if [[ $line != *"-----"* ]]; then
		printf "$line"
	fi
done < $1


#!/bin/bash

num_reg='^[0-9]+$'

if [[ $# -ne 2 ]] || ! [[ $1 =~ $num_reg ]] || ! [[ $2 =~ $num_reg ]]; then
	echo "Please pass 2 numeric arguments"
	exit 1
fi

num1=$1
num2=$2

if [[ $num1 -lt $num2 ]]; then
	echo "$num2 is larger"
elif [[ $num2 -lt $num1 ]]; then
	echo "$num1 is larger"
else
	echo "Both numbers are equal $num1 and $num2"
fi

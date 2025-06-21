#!/bin/bash
set -oeu pipefail
set -o xtrace

low=${1:-0}
high=${2:-32767}

if [[ $high -le $low ]]; then
	echo "The upper limit should be higher or equal to the lower limit."
	exit 1
fi

random_num=$RANDOM

result=$(( $random_num % ($high - $low + 1) + $low  ))
echo "Random number between $low and $high is: $result"

#!/bin/bash
set -oeu pipefail

low=${1:-0}
high=${2:-32767}

if [[ $high -le $low ]]; then
	echo "The upper limit should be higher or equal to the lower limit."
	exit 1
fi

random_num=$RANDOM

result=$(shuf --input-range=$low-$high --head-count=1)
echo "Random number between $low and $high is: $result"

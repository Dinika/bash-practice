#!/bin/bash
set -oeu pipefail

echo The input sent is:
# cat /dev/stdin


# A basic summary of my sales report
echo Here is a summary of the sales data:
echo ====================================
echo
cat /dev/stdin | cut -d' ' -f 3,5 | sort

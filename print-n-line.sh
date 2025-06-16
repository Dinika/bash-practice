#!/bin/bash
echo "Which line number (0 based) would you like to read?"

linenum=$1
echo "Line number $linenum is:"
echo

cat /dev/stdin | awk -v n="$linenum" 'NR == n {print; exit}'

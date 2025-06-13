#!/bin/bash

set -ueo pipefail

words_file="/usr/share/dict/words"
lines=$(wc -l < "$words_file")
echo "Total lines in file are $lines."

if [[ $# -ge 1 && "$1" =~ ^[0-9]+$ ]]; then
    length="$1"
    echo "Filtering words of length $length"
    random_word=$( grep -E "^.{$length}$" "$words_file" | shuf -n 1 || true )
    if [[ -z "$random_word" ]]; then
        echo "No words found with number of letters $length"
        exit 1
    fi

    echo "Random word is $random_word"
else
    random_line=$( shuf -i 1-"$lines" -n 1 )
    echo "Random word is $(sed -n "${random_line}p" "$words_file")"
fi

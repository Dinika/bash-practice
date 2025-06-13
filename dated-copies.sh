#!/bin/bash

set -ueo pipefail

# This script creates a dated copy of a file in the current directory.

if [ $# == 0 ]; then
    echo "Atleast one file or directory should be passed"
    exit 1
fi

today=$( date +"%d-%m-%Y" )
destination_dir="backup-$today"
if [[ -d $destination_dir ]]; then
    echo "Destination directory $destination_dir already exists. Deleting it."
    rm -rf $destination_dir
fi
mkdir $destination_dir


files="$@"
for file_or_dir in $files
do
    if [[ -d $file_or_dir ]]; then
        echo "$file_or_dir is a directory"
    elif [[ -f $file_or_dir ]]; then
        echo "$file_or_dir is a file"
        filename_with_ext="$( basename $file_or_dir )"    # remove path
        filename="${filename_with_ext%.*}"
        extension="${filename_with_ext##*.}"
        destination_filename="${filename}_${today}.${extension}"
        echo "Copying to $destination_dir/$destination_filename"
        cp $file_or_dir "$destination_dir/$destination_filename"
    else
        echo "invalid path received"
    fi
done

echo "Done"

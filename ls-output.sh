#!/bin/bash
set -oeu pipefail

output=$(ls -lh)
echo "$output" | awk '{print $9 " - " $4 " - " $5}'
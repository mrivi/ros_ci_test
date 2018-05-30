#!/bin/bash

# COLOR_END="\033[0m"
# COLOR_RED="\033[0;31m" 
# COLOR_GREEN="\033[0;32m" 
# STYLE='google'

# FORMAT_DIFF=$(git diff -U0 HEAD^ | python ~/clang-format-diff.py -p1 -style=${STYLE})

# if [ -z "${FORMAT_DIFF}" ]; then
#   echo -e "Code style check passed."
#   exit 0
# else
#   echo -e "Code style check failed, please run clang-format"
#   echo "$FORMAT_DIFF" | 
#   	sed -e "s/\(^-.*$\)/`echo -e \"$COLOR_RED\1$COLOR_END\"`/" |
#   	sed -e "s/\(^+.*$\)/`echo -e \"$COLOR_GREEN\1$COLOR_END\"`/"
#   exit 1
# fi

# Fix style recursively in all the repo
sh fix_style.sh .

# Print the diff with the remote branch (empty if no diff)
git --no-pager diff -U0 --color

# Check if there are changes, and failed 
if ! git diff-index --quiet HEAD --; then echo "Code style check failed, please run clang-format (e.g. with tools/fix_style.sh)"; exit 1; fi
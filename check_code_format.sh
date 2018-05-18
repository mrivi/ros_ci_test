#!/bin/bash
# Copyright (c) 2017 Google Inc.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Script to determine if source code in Pull Request is properly formatted.
# Exits with non 0 exit code if formatting is needed.
#
# This script assumes to be invoked at the project root directory.

COLOR_END="\033[0m"
COLOR_RED="\033[0;31m" 
COLOR_GREEN="\033[0;32m" 
STYLE='google'

#FILES_TO_CHECK=$(git diff --name-only master | grep -E ".*\.(cpp|c|h|hpp)"$)

# if [ -z "${FILES_TO_CHECK}" ]; then
#   echo -e "${GREEN}No source code t.${NC}"
#   exit 0
# fi

# for f in $FILES_TO_CHECK; do
# 	d=$(diff -u "$f" <(clang-format "$f"))
# 	if ! [ -z "$d" ]; then
#         echo -e "${RED} Code style check failed, please run clang-format.${NC}"
#         echo "$d"
#         exit 1
#     fi
# done

FORMAT_DIFF=$(git diff -U0 HEAD^ | python ~/clang-format-diff.py -p1 -style=${STYLE})

if [ -z "${FORMAT_DIFF}" ]; then
  #echo -e "${GREEN}All source code in PR properly formatted.${NC}"
  exit 0
else
  echo -e "Code style check failed, please run clang-format"
  echo "$FORMAT_DIFF" | 
  	sed -e "s/\(^-.*$\)/`echo -e \"$COLOR_RED\1$COLOR_END\"`/" |
  	sed -e "s/\(^+.*$\)/`echo -e \"$COLOR_GREEN\1$COLOR_END\"`/"
  #echo "${FORMAT_DIFF}"
  exit 1
fi
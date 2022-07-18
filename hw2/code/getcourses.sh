#! /bin/bash

# Author:ChengyangGong
# UWNetId:cygong
# CSE 374 HW2: Part #1
# date: 2021-10-21

if [ $# -lt 2 ]; then
  echo "$0 requires 2 argument" >&2 # &2 means stderr
  exit 1
fi
# Check if output file exists
if [ ! -f $1 ]; then
  touch $1
else
  echo "The output file already exists. Warning: Overwriting" # how to guarantee overwrite？—— don't touch first, then use > when writing data to the file
fi
# Check if input file(html file) exists
if [ ! -f $2 ]; then
  echo "Input file does not exist" >&2 
  exit 1 # when exit, the script actually expires.
fi

# sed -i means in-place, edit in the file directly
# 'grep' match all lines that contain 'http'
# zsh has no command like 'sed', so we have to do it in bash ？——not this reason leading to exe failure
# Be careful: Use | for pipeline, not >, and also don't change line when using |
# Caution: 
# (1) if we use -n in sed, then we must use p at the end, otherwise the output will be empty
# (2) if we don't use -n, then all the results including https://,http-xxx will be there, which does not satisfy the requirements
# (3) if we use -n and p, that will be great
# how to make a pattern like http:// in the /xxx/ field —— using http:\/\/
grep "http" $2 | sed -n -e 's/^.*http:\/\/courses/http:\/\/courses/p' | # using this pattern only reserves courses related URL
# At first I want to deal with the 2 cases(' and ") and distinct the results, but I don't know how to deal with ' in pattern
# Meanwhile, I find that I can only deal with the case of " and use -n and /p option to get to the final result！
# 【？？】how to deal with the case of ' in the replacement pattern
sed -n -e 's/".*$/21au\//p' | sed -n -e 's/\(cse[0-9][0-9][0-9][a-z]*[0-9]*\/21au\/\).*$/\1/p' > $1 # now eliminate csep items

exit 0

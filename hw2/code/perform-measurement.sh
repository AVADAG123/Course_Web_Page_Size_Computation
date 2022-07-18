#! /bin/bash

# Author:ChengyangGong
# UWNetId:cygong
# CSE 374 HW2: Part #2
# date: 2021-10-21

#【？？】need to have an exit code 0 when successfully executed to the end?
if [ $# -eq 0 ]; then
  echo "You input no argument" >&2 # &2 means stderr
  exit 1
fi

if [ $# -gt 1 ]; then  #【？？】how to use >= how to use | and & —— ge,greater than
  echo "0"
  exit 0
fi

# wget download file in the current directory in default
# we can rename the downloaded file
# -q means quiet(with no output); -q should be in the front of -0, or -q will be regarded as a filename
# Here this script makes the output to the standard output, so if other scripts use this script, the output can be controlled
wget -q -O download.html $1
wc -c < download.html
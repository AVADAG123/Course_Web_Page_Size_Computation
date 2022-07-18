#! /bin/bash

# Author:ChengyangGong
# UWNetId:cygong
# CSE 374 HW2: Part #3
# date: 2021-10-21

if [ $# -ne 2 ]; then
  echo "$0 requires 2 argument" >&2 # &2 means stderr
  exit 1
fi

# no need to check if the output file already exists, for that if it does exist, touch command will do nothing
touch $1
> $1 # whether exists or not, clear it first

cat $2 |
while read line; do
  echo "Performing byte-size measurement on $line" # echo -e makes \n effective
  # We can store the result of the following script into a file, or just a variable
  temp=$(./perform-measurement $line)
  # $temp is not a file or directory, so use echo not cat
  # 【？？】does # matches the shortest pattern, like * is 0 times? or ^.* can be as long as possible?
  # size=$(echo $temp | sed -n -e 's/^.*\([0-9]\)/\1/p') this doesn't work because of the .*^ will match as long as possible
  size=$(echo $temp | sed -n -e 's/ *\([0-9]\)/\1/p') # this command works, eliminating spaces before the number and store into temp1
  # use -eq ; $temp1 is a string(everything in bash is string)
  # double square bracket ensure if temp1 is empty we can still consider it to be 0 (https://stackoverflow.com/questions/22798333/unary-operator-expected-in-bash)
  if [[ $size -eq '0' ]]; then
    echo "...failure"
  else
    echo "...successful"
    # $line is not a file or directory, so use echo not cat
    idnumber=$(echo $line | sed -n -e 's/^.*cse\([0-9][0-9][0-9]\).*$/\1/p')
    echo "$idnumber $size" >>$1 
  fi

  # use regex; use /(.../) in sed
  # special case: cse590m2 / cse590em / csep546 / cse590mo/02sp/21au/  / cse510 vs csep510？ meanwhile, csep has some courses cse don't have
  # we just exclude the csep associated courses at the very beginning in the getcourses.sh

  # WHEN SOLVING THE PROBLEM, WE ARE ALSO DEFINING PROBLEM

  # 591a,591b,590em which one? or just sum up?—— print out each as 3digit num(duplicate is fine)
  # what about /21au ? —— this should be added, in that we only needs 21au courses(mentioned in the bg of this homework). If a course is not offered in 21au, then we can ignore it
  # Just process the $line, not the entire courselist file

done

exit 0

# cat courselist | sed -n -e 's/^.*csep?\([0-9][0-9][0-9]\)[a-z]*/\1/p' >&1 # neglect csep？why using cse(p)? and cse(p?) have no output?
# cat courselist | sed -n -e 's/^.*((cse)*)/wa/p' >&1 # this does not work either【？？】

# echo "sasasacse233aua22/21au/" | sed -n -e 's/^.*cse\([0-9][0-9][0-9]\)([a-e]*)([0-9]*)\/21au\//\1/p' >&1 
# why can't this work? The output is always empty
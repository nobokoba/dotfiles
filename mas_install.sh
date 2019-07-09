#!/bin/bash
TESTFILE="./Brewfile"
while read line; do
  if echo "$line" | grep 'appstore' > /dev/null
  then
    masid=`echo $line | cut -d ' ' -f 2`
    mas install $masid
  fi
done < $TESTFILE

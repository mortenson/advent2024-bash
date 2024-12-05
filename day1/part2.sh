#! /bin/bash

LEFT=$(cat input.txt | awk '{ print $1 }' | sort)
RIGHT=$(cat input.txt | awk '{ print $2 }' | sort)

i=0
TOTAL=0
echo "$LEFT" | while read p; do
  COUNT=$(echo "$RIGHT" | grep "$p" | wc -l)
  ((TOTAL += (p * COUNT)))
  ((++i))
  echo $TOTAL
done

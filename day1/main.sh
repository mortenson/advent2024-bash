#! /bin/bash

LEFT=$(cat input.txt | awk '{ print $1 }' | sort)
RIGHT=$(cat input.txt | awk '{ print $2 }' | sort)

i=0
TOTAL=0
RIGHTLINES=($RIGHT)
echo "$LEFT" | while read p; do
  DIFF=$((p - ${RIGHTLINES[$i]}))
  DIFF=${DIFF#-}
  ((TOTAL += DIFF))
  ((++i))
  echo $TOTAL
done

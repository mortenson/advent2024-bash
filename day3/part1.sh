#! /bin/bash

INPUT=$(cat input.txt | sed -e 's/mul(/\n/g' | grep '^\d*,\d*)' | sed -e 's/).*//')

TOTAL=0

for LINE in $INPUT; do
  LEFT=${LINE%,*}
  RIGHT=${LINE#*,}
  (( TOTAL = TOTAL + (LEFT * RIGHT) ))
done

echo $TOTAL

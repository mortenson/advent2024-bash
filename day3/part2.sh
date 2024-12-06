#! /bin/bash

INPUT=$(cat input.txt | sed -E -e "s/(mul|don't|do)\(/\n\1(/g" | grep -E "^(mul|don't|do)\(\d*,?\d*\)" | sed -e 's/).*//')

TOTAL=0

DO=1
for LINE in $INPUT; do
  if [[ DO -eq 1 && ${LINE:0:4} == 'mul(' ]]; then
    TRUNC=${LINE:4}
    LEFT=${TRUNC%,*}
    RIGHT=${TRUNC#*,}
    (( TOTAL = TOTAL + (LEFT * RIGHT) ))
  elif [[ ${LINE:0:6} == "don't(" ]]; then
    (( DO = 0 ))
  elif [[ ${LINE:0:3} == "do(" ]]; then
    (( DO = 1 ))
  fi
done

echo $TOTAL

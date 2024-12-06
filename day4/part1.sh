#! /bin/bash

# ok so i'm thinking fuck 2d arrays, which is what I'd normally use

INPUT=$(cat input.txt)
INPUTNONEWLINES=$(cat input.txt | tr -d '\r\n')

NEWLINES=""
PUZZLEWIDTH=140

# Diagonals
i=0
for LINE in $INPUT; do
  if [[ i -eq 0 ]]; then
    MAX=$PUZZLEWIDTH
  else
    MAX=1
  fi
  for (( j=0; j<MAX; j++ )); do
    NEWLINE="${LINE:$j:1}"
    LINEOFFSET=$i
    while :
    do
      NEXTCHAROFFSET=$(( (PUZZLEWIDTH * LINEOFFSET) + j + PUZZLEWIDTH + 2 ))
      NEXTCHAR=${INPUTNONEWLINES:$NEXTCHAROFFSET:1}
      # echo "LINE $i CHAR $j NEXTCHAR $NEXTCHAR - OFFSET $NEXTCHAROFFSET"
      if [[ $NEXTCHAR == "" ]]; then
        break
      fi
      NEWLINE="$NEWLINE$NEXTCHAR"
      (( ++LINEOFFSET ))
    done
    NEWLINES="$NEWLINES"$'\n'"$NEWLINE"
  done
  (( ++i ))
done

# Verticals
for (( i=0; i<PUZZLEWIDTH; i++ )); do
  NEWLINE="${LINE:$i:1}"
  LINEOFFSET=1
  while :
  do
    NEXTCHAROFFSET=$(( (PUZZLEWIDTH * LINEOFFSET) + j ))
    NEXTCHAR=${INPUTNONEWLINES:$NEXTCHAROFFSET:1}
    # echo "LINE $i CHAR $j NEXTCHAR $NEXTCHAR - OFFSET $NEXTCHAROFFSET"
    if [[ $NEXTCHAR == "" ]]; then
      break
    fi
    NEWLINE="$NEWLINE$NEXTCHAR"
    (( ++LINEOFFSET ))
  done
  NEWLINES="$NEWLINES"$'\n'"$NEWLINE"
done

echo "$INPUT"$'\n'"$NEWLINES" | grep -o -E 'XMAS|SAMX' | wc -l

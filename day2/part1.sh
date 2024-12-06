#! /bin/bash

TOTAL=0
while IFS= read REPORT; do
  # Super slow but hillariously lazy way to the non incremental check.
  if [[ $(echo $REPORT | xargs -n1 | sort -g | xargs) != $REPORT && $(echo $REPORT | xargs -n1 | sort -gr | xargs) != $REPORT ]]; then
    echo "sign: skipping $REPORT"
    continue
  fi

  IFS=' '
  LASTNUMBER='UNSET'
  SKIP=0
  for NUMBER in $REPORT; do
    # saves me some brain power
    if [[ $LASTNUMBER -eq 'UNSET' ]]; then
      LASTNUMBER=$NUMBER
      continue
    fi
    DIFF=$((NUMBER - LASTNUMBER))
    # diff bounded by (1, 3)
    ABSDIFF=${DIFF#-}
    if [[ $ABSDIFF -lt 1 || $ABSDIFF -gt 3 ]]; then
      (( ++SKIP ))
      echo "bounds: skipping $REPORT"
      break
    fi
    LASTNUMBER=$NUMBER
  done
  if [[ $SKIP -eq 0 ]]; then
    ((TOTAL += 1))
  fi
done < input.txt

echo $TOTAL

#! /bin/bash

# I don't want to rewrite this shit so creating alternate versions of every report instead.

TOTAL=0
while IFS= read REPORTRAW; do
  IFS=' '
  # Assemble array of numbers for the report.
  REPORTARRAY=()
  count=0
  for NUMBER in $REPORTRAW; do
    REPORTARRAY[$count]=$NUMBER
    (( ++count ))
  done
  ## iterate over each variation
  i=-1
  for UNUSED in $(seq -s " " 0 $count); do
    if [[ $i -eq -1 ]]; then
      REPORT="$REPORTRAW"
    else
      REPORT=( "${REPORTARRAY[@]:0:$i}" "${REPORTARRAY[@]:$i+1}" )
      REPORT="${REPORT[*]}"
    fi
    (( ++i ))

    ## copy same code as last time
    # Super slow but hillariously lazy way to the non incremental check.
    if [[ $(echo $REPORT | xargs -n1 | sort -g | xargs) != $REPORT && $(echo $REPORT | xargs -n1 | sort -gr | xargs) != $REPORT ]]; then
      echo "sign: skipping $REPORT"
      continue
    fi

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
      break #new to avoid inflating total
    fi
    ## end copy
  done
done < input.txt

echo $TOTAL

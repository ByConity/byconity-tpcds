#!/bin/bash
set -e

[ -z "$1" ] && DATASIZE=1 || DATASIZE=$1
PARALLEL=${PARALLEL:-1}
if [ $DATASIZE -eq 1 ]; then
	SEED=42
else
	SEED=19620718
fi

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CSVPATH=${CSVPATH:-tpcds_csv_$DATASIZE}
[ ! -d $CSVPATH ] && mkdir $CSVPATH || true

echo "Generating ${DATASIZE}G TPCDS data, with RNGSEED ${SEED}..."
if [ "$PARALLEL" == 1 ]; then
    $SCRIPTPATH/dsdgen -SCALE $DATASIZE -DELIMITER \| -CHILD __ -TERMINATE N \
        -RNGSEED $SEED -DISTRIBUTIONS $SCRIPTPATH/tpcds.idx -DIR $CSVPATH
else
    seq 1 $PARALLEL | xargs -t -P$PARALLEL -I__ \
    $SCRIPTPATH/dsdgen -SCALE $DATASIZE -DELIMITER \| -PARALLEL $PARALLEL -CHILD __ -TERMINATE N \
        -RNGSEED $SEED -DISTRIBUTIONS $SCRIPTPATH/tpcds.idx -DIR $CSVPATH
fi

#!/bin/bash

# Retention process keep last only.
START_TIME=$SECONDS
TIMERTIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
echo "Starting restic retention process at $TIMERTIMESTAMP"
echo "Retention type: Last Only"

restic -r $LSS_REPOSITORY forget --keep-last $RESTIC_FORGETLAST

# Moving to pruning
echo "Restic retention finished succesfully!"
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Retention took: $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "Mooving to pruning"

/bin/bash "$WORKDIR"/"$BKID"-lss-prune.sh

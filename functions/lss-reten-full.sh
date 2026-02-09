#!/bin/bash

# Full Retention process
START_TIME=$SECONDS
TIMERTIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
echo "Starting restic retention process at $TIMERTIMESTAMP"
echo "Retention type: Full Retention"

restic -r $LSS_REPOSITORY forget --keep-within-daily $RESTIC_FORGETDAILY --keep-within-weekly $RESTIC_FORGETWEEKLY --keep-within-monthly $RESTIC_FORGETMONTHLY --keep-within-yearly $RESTIC_FORGETANNUAL

# Moving to pruning
echo "Restic retention finished successfully!"
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Retention took: $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "Mooving to pruning"

/bin/bash "$WORKDIR"/"$BKID"-lss-prune.sh

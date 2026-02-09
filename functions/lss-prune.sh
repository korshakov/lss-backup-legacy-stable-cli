#!/bin/bash
START_TIME=$SECONDS
TIMERTIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
echo "Starting restic prune at $TIMERTIMESTAMP"

restic -r $LSS_REPOSITORY unlock
restic -r $LSS_REPOSITORY prune
restic -r $LSS_REPOSITORY unlock

echo "Restic prune finished successfully!"
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Restic prune took: $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"

/bin/bash "$WORKDIR"/"$BKID"-log-cleanup.sh
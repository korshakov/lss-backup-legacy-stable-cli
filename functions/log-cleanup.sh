# Cleaning up log directory based on retention time specified in variables. 20160

echo "Looking for log files older than 2 weeks"
echo "Found these:"
find $WORKDIR/logs/* -type f -mmin +20160
echo "Deleting selected files older than 2 weeks from above list."
find $WORKDIR/logs/* -type f -mmin +20160 -exec rm -rf {} \;
echo "Done"
export STATUS="0"
/bin/bash "$WORKDIR"/"$BKID"-notify.sh

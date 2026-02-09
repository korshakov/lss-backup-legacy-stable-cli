#!/bin/bash
TIME=`date "+%d-%m-%Y"`
LOG_FILE=$WORKDIR/logs/$TIME-$BKID.log
{
# Actual data backup process start here With signaling failures if any!.
if [[ $PROGRAM == 'RESTIC' ]]
then
START_TIME=$SECONDS
TIMERTIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
echo "Starting restic process at $TIMERTIMESTAMP"


if [[ $EXCLUDE == 'YES' ]]
then
restic -r $LSS_REPOSITORY backup $SDIR -v --exclude 'System Volume Information' --exclude='$RECYCLE.BIN' --exclude-file=${EXCLUDEFILE}
RESTICCODE="$?"
else
restic -r $LSS_REPOSITORY backup $SDIR -v --exclude 'System Volume Information' --exclude='$RECYCLE.BIN'
RESTICCODE="$?"
fi
if [[ $RESTICCODE != '0' ]]
then
    if [[ $RESTICCODE == '1' ]]
    then
    echo "Restic finished with error $RESTICCODE Sending failed ping!"
        	export STATUS=18
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi

    if [[ $RESTICCODE == '3' ]]
    then
    echo "Restic finished with error $RESTICCODE Sending failed ping!"
        	export STATUS=19
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi

    if [[ $RESTICCODE != '1' && $RESTICCODE != '3' ]]
    then
    echo "Restic finished with unknown error, investigate!"
        	export STATUS=39
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
else
figlet LSS RESTIC 
echo "-----------------------------------"
echo "Restic backup finished successfully."
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Restic backup took: $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-----------------------------------"
##############################################

if [[ $RETENTION == 'YES-FULL' ]]
then
/bin/bash "$WORKDIR"/"$BKID"-lss-reten-full.sh
exit 0
fi
if [[ $RETENTION == 'YES-LAST' ]]
then
/bin/bash "$WORKDIR"/"$BKID"-lss-reten-keep-last-only.sh
exit 0
fi
if [[ $RETENTION == 'NO' ]]
then
/bin/bash "$WORKDIR"/"$BKID"-lss-no-reten.sh
fi
exit 0
fi
fi

###################################################


if [[ $PROGRAM == 'RSYNC' ]]
then
START_TIME=$SECONDS
TIMERTIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
echo "Starting rsync process at $TIMERTIMESTAMP"
if [[ $RSYNCMODE == 'NOPERMNOOWNNOGP' ]]
then
rsync -avp --no-perms --no-owner --no-group --exclude='System Volume Information' --exclude='$RECYCLE.BIN' $SDIR $LSS_REPOSITORY
else
rsync -avp --exclude='System Volume Information' --exclude='$RECYCLE.BIN' $SDIR $LSS_REPOSITORY
fi
RSYNCCODE="$?"
if [[ $RSYNCCODE != '0' ]]
then
    if [[ $RSYNCCODE == '1' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=20
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '2' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=21
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '3' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=22
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '4' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=23
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '5' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=24
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '6' ]]
    then
        	export STATUS=25
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '10' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=26
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '11' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=27
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '12' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=28
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '13' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=29
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '14' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=30
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '20' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=31
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '21' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=32
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '22' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=33
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '23' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=34
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '24' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=35
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '25' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=36
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '30' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=37
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
    if [[ $RSYNCCODE == '35' ]]
    then
    echo "Rsync finished with error $RSYNCCODE Sending failed ping!"
        	export STATUS=38
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi

    if [[ "$RSYNCCODE" -ge 7 && "$RSYNCCODE" -le 9 ]] && [[ "$RSYNCCODE" -ge 15 && "$RSYNCCODE" -le 19 ]] && [[ "$RSYNCCODE" -ge 26 && "$RSYNCCODE" -le 29 ]] && [[ "$RSYNCCODE" -ge 31 && "$RSYNCCODE" -le 34 ]] && [[ "$RSYNCCODE" -ne 35 ]] && [[ "$RSYNCCODE" -gt 36 ]]
    then
    echo "Rsync finished with unknown error, investigate!"
        	export STATUS=40
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
    fi
else
# Sending closing ping backup is finished
figlet LSS RSYNC
echo "----------------------------------"
echo "Rsync backup finished successfully!"
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Rsync backup took: $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "-----------------------------------"
/bin/bash "$WORKDIR"/"$BKID"-log-cleanup.sh
fi
fi
} | tee -a "${LOG_FILE}"

#!/bin/bash

BACKUPDIR="$LSS_REPOSITORY"

echo "Checking if LOCAL destionation folder $BACKUPDIR exist."

if [ -d "$BACKUPDIR" ];
    then
        # Take action if $DIR exists. #
	echo "LOCAL destionation directory exist. Backup will be stored at: ${BACKUPDIR}..."
	# daisy to repository check
	/bin/bash "$WORKDIR"/"$BKID"-repository-check.sh
	exit
    else
	echo "LOCAL destination directory does not exist. First time backup?"
        mkdir -p ${BACKUPDIR}
	echo "Checking if folder creation was successful."
	if [ -d "$BACKUPDIR" ];
    	then
        # Take action if $DIR exists. #
        echo "LOCAL destination directory now exist. Backup will be stored at: ${BACKUPDIR}..."
    	# daisy to repository check
	/bin/bash "$WORKDIR"/"$BKID"-repository-check.sh
	exit
	else
        echo "Automatic LOCAL destination folder creation failed! Sending failed ping!"
        	export STATUS=8
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
	fi
fi

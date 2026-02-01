#!/bin/bash

BACKUPDIR="$LSS_REPOSITORY"

echo "Checking if SMB/NFS destionation folder $BACKUPDIR exist."

if [ -d "$BACKUPDIR" ];
    then
        # Take action if $DIR exists. #
	echo "SMB/NFS destionation directory exist. Backup will be stored at: ${BACKUPDIR}..."
	# daisy to repository check.
	/bin/bash "$WORKDIR"/"$BKID"-repository-check.sh
	exit
    else
	echo "SMB/NFS destination directory does not exist. First time backup?"
        mkdir -p ${BACKUPDIR}
	echo "Checking if folder creation was succesful."
	if [ -d "$BACKUPDIR" ];
    	then
        # Take action if $DIR exists. #
        echo "SMB/NFS destination directory now exist. Backup will be stored at: ${BACKUPDIR}..."
        # daisy to repository-check
        /bin/bash "$WORKDIR"/"$BKID"-repository-check.sh
	exit
    	else
	echo "Warning! Automatic SMB/NFS destination folder creation failed! Sending failed ping!"
        	export STATUS=14
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
	fi
fi



# Checking what program is used first, if restic it will check it repository is inilialized or not.
# For rsync this is completely passed to backup process because rsync is just simple sync command in this program.

if [[ $PROGRAM == 'RESTIC' ]]
then
	# Checking if restic repo is initialized or not.
	export RESTIC_PASSWORD="$RESTIC_PASSWORD"
 	export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" 
  export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
  export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
	restic -r $LSS_REPOSITORY snapshots
	EXITCODE="$?"
	if [ "$EXITCODE" -eq "0" ]
        then
	# Repository exist already we can move onto actual data backup.
	echo "Repository already exist."
	/bin/bash "$WORKDIR"/"$BKID"-lss-backup.sh
	else
	# Repository does not exist, this is either caused by either first run or seriour data missmatch!
	echo "Repository does not exist! Is this your first time backup? (y=Yes,n=No)"
	echo "If this is your first backup you can ignore this message and type y and enter, if it isn't then exit immediately by pressing CTRL+C check your config files!"
	echo "You have 50 seconds to confirm this otherwise it will exit and not continute further!"

	# the user should provide his/her input within 20 seconds
	if ! read -r -t 50 FIRSTRUN; then
     	# if its not provided then the script should exit
        	export STATUS=15
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh && exit
     	exit
	fi
	if [[ $FIRSTRUN == 'y' ]]
	then
	# User confirmed that this is first time backup. Restic will now initialize repository
	export RESTIC_PASSWORD="$RESTIC_PASSWORD"
 	export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" 
  export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
  export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
	restic -r $LSS_REPOSITORY init
	echo "Restic repository init complete."
	/bin/bash "$WORKDIR"/"$BKID"-lss-backup.sh
	else
	# User confirmed that this shoud not happen! Sending failed ping and exitting.
        	export STATUS=16
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
	exit
	fi
    fi
fi

if [[ $PROGRAM == 'RSYNC' ]]
then
	# Moving to actual data backup.
	# This is just future reserved step
	/bin/bash "$WORKDIR"/"$BKID"-lss-backup.sh
fi

# Just double checking if the config file isn't messed up
if [[ $PROGRAM != 'RESTIC' ]] && [[ $PROGRAM != 'RSYNC' ]]
then
echo "Something went wrong. Backup config file must be corrupted. Sending failed ping and exiting!"
        	export STATUS=17
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
fi

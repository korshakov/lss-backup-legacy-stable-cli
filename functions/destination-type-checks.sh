#!/bin/bash

TIMESTAMP=`date "+%D-%M-%Y--%H:%M:%S"`
# SMB Destination directory checks #
echo "Checking if destination is SMB."
if [[ $BKDESTTYPE == 'SMB' ]]
then
 echo "Checking if destination SMB is mounted!"
 if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
	echo "Smb destination mountpoint is mounted!"
	echo "Nothing to do"
	# daisy to destination folder check.
	/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-destination-folder-checks.sh
	exit
 else
    echo "Warning! SMB destination share is not mounted! Trying to mount destination share as per config."
    mkdir -p "/mnt/lss-backup/$BKID/destination"
        if [[ -z "$DDOMAIN" ]]
        then
        	echo "No domain specified, using username & password only to login to //"$DMPTARGETIP"/"$DMPSN" share."
        	mount -t cifs //"$DMPTARGETIP"/"$DMPSN" "/mnt/lss-backup/$BKID/destination" -o username="$DUSERNAME",password="$DPASSWORD"
		echo "Checking if mount was successful"
                if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
                echo "Destination mountpoint is now mounted as per config"
                # daisy to destination folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-destination-folder-checks.sh
		exit
                else
                echo "Automatic mount of destination failed! Aborting backup and sending failed ping!"
                export STATUS=10
                /bin/bash "$WORKDIR"/"$BKID"-notify.sh
                exit
                fi

        else
        	echo "Domain has been specified, using username, password and domain to login to //$DMPTARGETIP/$DMPSN share."
        	mount -t cifs //"$DMPTARGETIP"/"$DMPSN" "/mnt/lss-backup/$BKID/destination" -o username="$DUSERNAME",password="$DPASSWORD",domain="$DDOMAIN"
		echo "Checking if mount was successful"
		if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
        	echo "Destination mountpoint is now mounted as per config"
        	# daisy to destination folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-destination-folder-checks.sh
                exit
		else
        	echo "Automatic mount of destination failed! Aborting backup and sending failed ping!"
        	export STATUS=10
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
        	exit
		fi

	fi
 fi
else
echo "Checking if destination is NFS."
fi

# NFS Source directory checks #
if [[ $BKDESTTYPE == 'NFS' ]]
then
 echo "Checking if destination NFS is mounted!"
 if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
        echo "Nfs destination mountpoint is mounted!"
 	echo "Nothing to do"
	# daisy to destination folder check.
	/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-destination-folder-checks.sh
        exit
 else
    echo "Warning! NFS destination share is not mounted! Trying to mount destination share as per config."
    mkdir -p "/mnt/lss-backup/$BKID/destination"
        if [[ -z "$DDOMAIN" ]]
        then
                echo "No domain specified, using username & password only to login to //"$DMPTARGETIP""$DMPSN" share."
                mount -t nfs -O user="$DUSERNAME",pass="$DPASSWORD" "$DMPTARGETIP":/"$DMPSN" "/mnt/lss-backup/$BKID/destination"
		echo "Checking if mount was successful"
		if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
                echo "Destination mountpoint is now mounted as per config"
                # daisy to destination folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-destination-folder-checks.sh
        	exit
                else
                echo "Automatic mount of destination failed! Aborting backup and sending failed ping!"
        	    export STATUS=10
                /bin/bash "$WORKDIR"/"$BKID"-notify.sh
                exit
                fi

        else
                echo "Domain has been specified, using username, password and domain to login to //$DMPTARGETIP/$DMPSN share."
                mount -t nfs -O user="$DUSERNAME",pass="$DPASSWORD",domain="$DDOMAIN" "$DMPTARGETIP":/"$DMPSN" "/mnt/lss-backup/$BKID/destination"
                echo "Checking if mount was successful"
                if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
                echo "Destination mountpoint is now mounted as per config"
		# daisy to destination folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-destination-folder-checks.sh
        	exit
                else
                echo "Automatic mount of destination failed! Aborting backup and sending failed ping!"
        	    export STATUS=10
                /bin/bash "$WORKDIR"/"$BKID"-notify.sh
                exit
                fi

        fi
 fi
else
echo "Checking if destination is LOCAL."
fi

# LOCAL Destination  directory checks #
if [[ $BKDESTTYPE == 'LOCAL' ]]
then
# daisy to destination  folder check.
/bin/bash "$WORKDIR"/"$BKID"-local-destination-folder-checks.sh
exit
else
echo "Checking if destination is S3."
fi

# S3 Destination checks #
if [[ $BKDESTTYPE == 'S3' ]]
then
# daisy to s3 destination check.
/bin/bash "$WORKDIR"/"$BKID"-s3-destination-checks.sh
exit
else
echo "Variable settings are incorrect! Sending failed ping!"
export STATUS=12
/bin/bash "$WORKDIR"/"$BKID"-notify.sh
fi

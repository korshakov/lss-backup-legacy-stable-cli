#!/bin/bash

TIMESTAMP=`date "+%D-%M-%Y--%H:%M:%S"`
# SMB Source directory checks #
echo "Checking if source is SMB."
if [[ $BKSOURCETYPE == 'SMB' ]]
then
 echo "Checking if source SMB is mounted!"
 if mount | grep "$SDIR" > /dev/null; then
	echo "Smb source mountpoint is mounted!"
	echo "Nothing to do"
	# daisy to source folder check.
	/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-source-folder-checks.sh
	exit
 else
    echo "Warning! SMB source share is not mounted! Trying to mount source share as per config."
    mkdir -p "$SDIR"
        if [[ -z "$DOMAIN" ]]
        then
        	echo "No domain specified, using username & password only to login to //"$MPTARGETIP"/"$MPSN" share."
        	mount -t cifs //"$MPTARGETIP"/"$MPSN" "$SDIR" -o username="$USERNAME",password="$PASSWORD",nouser_xattr
		echo "Checking if mount was succesfull"
                if mount | grep "$SDIR" > /dev/null; then
                echo "Source mountpoint is now mounted as per config"
                # daisy to source folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-source-folder-checks.sh
		exit
                else
                echo "Automatic mount of source failed! Aborting backup and sending failed ping!"
        	export STATUS=9
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
                exit
                fi

        else
        	echo "Domain has been specified, using username, password and domain to login to //$MPTARGETIP/$MPSN share."
        	mount -t cifs //"$MPTARGETIP"/"$MPSN" "$SDIR" -o username="$USERNAME",password="$PASSWORD",domain="$DOMAIN",nouser_xattr
		echo "Checking if mount was succesfull"
		if mount | grep "$SDIR" > /dev/null; then
        	echo "Source mountpoint is now mounted as per config"
        	# daisy to source folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-source-folder-checks.sh
		exit
		else
        	echo "Automatic mount of source failed! Aborting backup and sending failed ping!"
        	export STATUS=9
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
        	exit
		fi

	fi
 fi
else
echo "Checking if source is NFS."
fi

# NFS Source directory checks #
if [[ $BKSOURCETYPE == 'NFS' ]]
then
 echo "Checking if source NFS is mounted!"
 if mount | grep "$SDIR" > /dev/null; then
        echo "Nfs source mountpoint is mounted!"
 	echo "Nothing to do"
	# daisy to source folder check.
	/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-source-folder-checks.sh
	exit
 else
    echo "Warning! Nfs source share is not mounted! Trying to mount source share as per config."
    mkdir -p "$SDIR"
        if [[ -z "$DOMAIN" ]]
        then
                echo "No domain specified, using username & password only to login to //"$MPTARGETIP"/"$MPSN" share."
                mount -t nfs -O user="$USERNAME",pass="$PASSWORD" "$MPTARGETIP":/"$MPSN" "$SDIR"
		echo "Checking if mount was succesfull"
		if mount | grep "$SDIR" > /dev/null; then
                echo "Source mountpoint is now mounted as per config"
                # daisy to source folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-source-folder-checks.sh
                exit
		else
                echo "Automatic mount of source failed! Aborting backup and sending failed ping!"
        	export STATUS=9
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
                exit
                fi

        else
                echo "Domain has been specified, using username, password and domain to login to //$MPTARGETIP/$MPSN share."
                mount -t nfs -O user="$USERNAME",pass="$PASSWORD",domain="$DOMAIN" "$MPTARGETIP":/"$MPSN" "$SDIR"
                echo "Checking if mount was succesfull"
                if mount | grep "$SDIR" > /dev/null; then
                echo "Source mountpoint is now mounted as per config"
		# daisy to source folder check.
		/bin/bash "$WORKDIR"/"$BKID"-smb-nfs-source-folder-checks.sh
                exit
		else
                echo "Automatic mount of source failed! Aborting backup and sending failed ping!"
        	export STATUS=9
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
                exit
                fi

        fi
 fi
else
echo "Checking if source is LOCAL."
fi
# LOCAL Source directory checks #
if [[ $BKSOURCETYPE == 'LOCAL' ]]
then
# daisy to source folder check.
/bin/bash "$WORKDIR"/"$BKID"-local-source-folder-checks.sh
exit
else
echo "Variable settings are incorrect! Sending failed ping!"!
        	export STATUS=11
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
fi

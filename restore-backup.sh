#!/bin/bash

######################### Functions start here

### DESTINATION CHECKS
restore-source-check () {
if [[ $BKDESTTYPE == 'SMB' ]]
then
 echo "Checking if source to restore SMB is mounted!"
 if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
	echo "SMB source to restore mountpoint is mounted."
 else
    echo "Warning! SMB source to restore  share is not mounted! Trying to mount source to restore share as per config."
    mkdir -p "/mnt/lss-backup/$BKID/destination"
        if [[ -z "$DDOMAIN" ]]
        then
        	echo "No domain specified, using username & password only to login to //"$DMPTARGETIP"/"$DMPSN" share."
        	mount -t cifs //"$DMPTARGETIP"/"$DMPSN" "/mnt/lss-backup/$BKID/destination" -o username="$DUSERNAME",password="$DPASSWORD"
		echo "Checking if mount was successful"
                if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
                echo "Source to restore mountpoint is now mounted as per config"
                else
                echo "Automatic mount of source to restore failed! Aborting restore!"
                exit
                fi

        else
        	echo "Domain has been specified, using username, password and domain to login to //$DMPTARGETIP/$DMPSN share."
        	mount -t cifs //"$DMPTARGETIP"/"$DMPSN" "/mnt/lss-backup/$BKID/destination" -o username="$DUSERNAME",password="$DPASSWORD",domain="$DDOMAIN"
		echo "Checking if mount was successful"
		if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
        	echo "Source to restore  mountpoint is now mounted as per config"
		else
        	echo "Automatic mount of source to restore failed! Aborting restore!"
        	exit
		fi

	fi
 fi
fi

# NFS Source directory checks #
if [[ $BKDESTTYPE == 'NFS' ]]
then
 echo "Checking if source to restore NFS is mounted!"
 if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
        echo "NFS source to restore mountpoint is mounted."
 else
    echo "Warning! NFS source to restore share is not mounted! Trying to mount source to restore share as per config."
    mkdir -p "/mnt/lss-backup/$BKID/destination"
        if [[ -z "$DDOMAIN" ]]
        then
                echo "No domain specified, using username & password only to login to //"$DMPTARGETIP""$DMPSN" share."
                mount -t nfs -O user="$DUSERNAME",pass="$DPASSWORD" "$DMPTARGETIP":/"$DMPSN" "/mnt/lss-backup/$BKID/destination"
		echo "Checking if mount was successful"
		if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
                echo "Source to restore mountpoint is now mounted as per config"
                else
                echo "Automatic mount of source to restore failed! Aborting restore!"
                exit
                fi

        else
                echo "Domain has been specified, using username, password and domain to login to //$DMPTARGETIP/$DMPSN share."
                mount -t nfs -O user="$DUSERNAME",pass="$DPASSWORD",domain="$DDOMAIN" "$DMPTARGETIP":/"$DMPSN" "/mnt/lss-backup/$BKID/destination"
                echo "Checking if mount was successful"
                if mount | grep "/mnt/lss-backup/$BKID/destination" > /dev/null; then
                echo "Source to restore mountpoint is now mounted as per config"
                else
                echo "Automatic mount of source to restore failed! Aborting restore!"
                exit
                fi

        fi
 fi
fi

if [[ $BKDESTTYPE == 'LOCAL' ]]
then
echo "Source to restore is LOCAL. Nothing to mount."
fi

if [[ $BKDESTTYPE == 'S3' ]]
then
echo "Source to restore is S3. Nothing to mount."
fi


}
### END OF DESTINATION CHECKS

### SMB MOUNT FUNCTION

smbrestoremountfunction ()
{
smbrestoremountfunctiontype=SMB
echo "IP Address?"
read smbipaddr
echo "Share name?"
read smbrestoredir
echo "Username?"
read smbrestoreusername
echo "Password?"
read smbrestoreuserpasswd
echo "Domain?"
read smbrestoredomain
echo "Where to mountpoint?"
read restoretargetdir

echo "Checking if source SMB is mounted by something else."
if mount | grep "$restoretargetdir" > /dev/null; then
echo "Smb source mountpoint is mounted! Choose a diffrent path!"
exit
else
# Mountpoint is clear we can mount smb. Checking if domain was specified.
# Checking if mountpoint directory exists first.
echo "Checking if $restoretargetdir exists"
if [ -d "$restoretargetdir" ];
then
echo "Directory exists."
else
mkdir -p "$restoretargetdir"
fi
if [[ -z "$smbrestoredomain" ]]
then
echo "Mounting smb without domain"
mount -t cifs //"$smbipaddr"/"$smbrestoredir" "$restoretagetdir" -o username="$smbrestoreusername",password="$smbrestoreuserpasswd"
echo "Checking if mount was successful"
if mount | grep "$smbrestoredir" > /dev/null; then
echo "SMB restore directory mounted successfully."
else
echo "SMB mount failed! Something went wrong."
exit
fi
else
echo "Mounting smb with domain."
mount -t cifs //"$smbipaddr"/"$smbrestoredir" "$restoretargetdir" -o username="$smbrestoreusername",password="$smbrestoreuserpasswd",domain="$smbrestoredomain"
echo "Checking if mount was successful"
if mount | grep "$smbrestoredir" > /dev/null; then
echo "SMB restore directory mounted successfully."
else
echo "SMB mount failed! Something went wrong."
exit
fi
fi
fi
}

### END OF SMB MOUNT FUNCTION

### NFS MOUNT FUNCTION

nfsrestoremountfunction ()
{
smbrestoremountfunctiontype=NFS
echo "IP Address?"
read nfsipaddr
echo "Share path?"
read nfsrestoredir
echo "Username?"
read nfsrestoreusername
echo "Password?"
read nfsrestoreuserpasswd
echo "Domain?"
read nfsrestoredomain
echo "Where to mountpoint?"
read restoretargetdir

echo "Checking if source NFS is mounted by something else."
if mount | grep "$restoretargetdir" > /dev/null; then
echo "NFS source mountpoint is mounted! Choose a diffrent path!"
exit
else
# Mountpoint is clear we can mount nfs. Checking if domain was specified.
# Checking if mountpoint directory exists first.
echo "Checking if $restoretargetdir exists"
if [ -d "$restoretargetdir" ];
then
echo "Directory exists."
else
mkdir -p "$restoretargetdir"
fi
if [[ -z "$nfsrestoredomain" ]]
then
echo "Mounting nfs without domain"
mount -t nfs -O user="$nfsrestoreusername",pass="$nfsrestoreuserpasswd" "$nfsipaddr":/"$nfsrestoredir" "$restoretargetdir"
echo "Checking if mount was successful"
if mount | grep "$nfsrestoredir" > /dev/null; then
echo "NFS restore directory mounted successfully."
else
echo "NFS mount failed! Something went wrong."
exit
fi
else
echo "Mounting nfs with domain."
mount -t nfs -O user="$nfsrestoreusername",pass="$nfsrestoreuserpasswd",domain="$nfsrestoredomain" "$nfsipaddr":/"$nfsrestoredir" "$restoretargetdir"
echo "Checking if mount was successful"
if mount | grep "$nfsrestoredir" > /dev/null; then
echo "NFS restore directory mounted successfully."
else
echo "NFS mount failed! Something went wrong."
exit
fi
fi
fi
}

### END OF NFS MOUNT FUNCTION

### LOCAL MOUNT FUNCTION

localrestoremountfunction ()
{
smbrestoremountfunctiontype=LOCAL
echo "Local directory path?"
read restoretargetdir
    if [ -d "$restoretargetdir" ];
    then
    if find "$restoretargetdir" -mindepth 1 -maxdepth 1 | read; then
    echo "Directory contains folders/files. Use empty folder instead!"
    exit
    else
    echo "All good here."
    fi
    else
    mkdir -p "$restoretargetdir"
    fi  
}

### END OF LOCAL MOUNT FUNCTION

### RESTIC RESTORE SNAPSHOT FUNCTION

restic-restore ()
{
echo "Where would you like to restore files?"
select restoreloctype in "LOCAL" "SMB" "NFS"; do
    case $restoreloctype in

        LOCAL ) localrestoremountfunction ; break;;

        SMB ) smbrestoremountfunction ; break;;

	NFS ) nfsrestoremountfunction ; exit;;
    esac
done
mkdir -p $restoretargetdir/LSS-RESTORE-$BKID
echo "Would you like to restore latest or specify snapshot id?"
select snapshotchoice in "LATEST" "SPECIFY-ID"; do
    case $snapshotchoice in
    LATEST ) echo "Restoring data to $restoretargetdir."; restic -r $LSS_REPOSITORY restore latest --target "$restoretargetdir/LSS-RESTORE-$BKID"; restore-tidyup; echo "Restore finished."  ; break;;
    SPECIFY-ID ) echo "Input your restic snapshot ID."; read resticsnapshotid; echo "Restoring data to $restoretargetdir."; restic -r $LSS_REPOSITORY restore "$resticsnapshotid" --target "$restoretargetdir/LSS-RESTORE-$BKID"; restore-tidyup; echo "Restore finished." ; exit;;
    esac
done
}

### END OF RESTIC RESTORE SNAPSHOT FUNCTION

### RESTIC MOUNT FUNCTION FUNCTION

restic-mount ()
{

localrestoremountfunction;

mkdir -p $restoretargetdir/fusemount
echo "Mounting snapshot data to $restoretargetdir."; restic -r $LSS_REPOSITORY mount "$restoretargetdir/fusemount";

}

### END OF RESTIC MOUNT SNAPSHOT FUNCTION

## RSYNC RESTORE FUNCTION
rsync-restore ()
{
echo "Where would you like to restore files?"
select restoreloctype in "LOCAL" "SMB" "NFS"; do
    case $restoreloctype in

        LOCAL ) localrestoremountfunction ; break;;

        SMB ) smbrestoremountfunction ; break;;

	NFS ) nfsrestoremountfunction ; exit;;
    esac
done
}

### END OF RSYNC RESTORE

### RESTORE UNMOUNT

restoredestumount () {

if [[ $smbrestoremountfunctiontype == 'SMB' ]] || [[ $smbrestoremountfunctiontype == 'NFS' ]]
then
umount "$restoretargetdir"
rm -rf "$restoretargetdir"
echo "Tidy up successful."
else
echo "Tidy up failed! Due to called tidy up function, restore destination was specified as SMB/NFS but something got wrong!"
fi

}

### END OF RESTORE UNMOUNT

### RESTORE TIDY UP

### I need to add check here if user has actually chosen to restore to SMB/NFS

restore-tidyup (){

if [[ $smbrestoremountfunctiontype == 'SMB' ]] || [[ $smbrestoremountfunctiontype == 'NFS' ]]
then
echo "Would you like to disconnect restore destination shares?"
select restorecleanup in "YES" "NO"; do
    case $restorecleanup in

        YES ) restoredestumount ; break;;

        NO ) echo "Nothing to do." ; break;;

    esac
done
fi
}

### END OF RESTORE TIDY UP

################################ END OF ALL FUNCTIONS

clear
figlet LSS RESTORE
# if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
# echo "--------------------------------"
# echo "List of backup(s):"
# echo "--------------------------------"
# column -t ./database/backup-database.txt
# echo "--------------------------------"

# echo "Which backup would you like to restore?"
# read BACKUPRESTOREID

BACKUPRESTOREID=$BACKUPJOB

# Checking if user has inputted the right backup id.
if [ -d "./database/backup-jobs/$BACKUPRESTOREID" ];
then
# load backup job config file
source ./database/backup-jobs/$BACKUPRESTOREID/$BACKUPRESTOREID-Configuration.env

restore-source-check;

if [[ $PROGRAM == 'RESTIC' ]]
then

export RESTIC_PASSWORD="$RESTIC_PASSWORD"
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" 
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"

echo "Listing snapshots."
echo "------------------"
restic -r $LSS_REPOSITORY snapshots
echo "-------------------------------"

echo "You can either restore all data or mount your backup to fuse and copy only what you need."
echo "Which option do you want to continue with?"
select snapshotrestoretype in "Restore-All-Data" "Mount-Backup-Instead"; do
    case $snapshotrestoretype in
    Restore-All-Data ) restic-restore ; break;;
    Mount-Backup-Instead ) restic-mount ; exit;;
    esac
    done
    restore-tidyup;
    echo "Restore finished."
else
rsync-restore;
echo "Restoring data using rsync. This may take some time depending how much data you are about to restore."
echo "Restoring data to to $restoretargetdir"
mkdir -p $restoretargetdir/LSS-RESTORE-$BKID 
rsync -avp $LSS_REPOSITORY $restoretargetdir/LSS-RESTORE-$BKID
restore-tidyup;
echo "Restore finished."
fi


else
echo "Incorrect backup ID!"
./restore-backup.sh
fi

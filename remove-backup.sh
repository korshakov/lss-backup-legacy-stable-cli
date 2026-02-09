#!/bin/bash

###### functions

### data destroy confirmed function

confirmeddatadestroy (){

# Full destruction mode
# Checking SMB/NFS sources first.
source ./database/backup-jobs/$BKDESTROY/$BKDESTROY-Configuration.env
if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]]
then
echo "Unmounting source share"
umount /mnt/lss-backup/$BKID/source
echo "Removing source mount point directory"
rm -rf /mnt/lss-backup/$BKID/source
else
echo "Seems like your source directory is set to local. Not touching that!"
fi
# Unmounting destination shares and deleting mountpoints. Again backups in destinations are not deleted as of yet in this version of script.
if [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
then
echo "DESTROYING ALL DESTINATION DATA NOW!"
rm -rf /mnt/lss-backup/$BKID/destination/$BKID-$BKFQ-$BKNAME
echo "Done"
echo "Unmounting destination share"
umount /mnt/lss-backup/$BKID/destination
echo "Removing destination mount point directory."
# deleting backup job mount folder.
rm -rf /mnt/lss-backup/$BKID/destination
fi
# Deleting backup job mount point base folder based on backup job id for both source and destination.
if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]] || [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
then
echo "Deleting backup job ID: $BKID mountpoint base folder."
rm -rf /mnt/lss-backup/$BKID
fi
# Checking if destination is local
if [[ $BKDESTTYPE == 'LOCAL' ]]
then
rm -rf $LSS_REPOSITORY
fi
# Checking if destination is S3 Bucket.
if [[ $BKDESTTYPE == 'S3' ]]
then
echo "You will have to delete data from S3 bucket manually."
fi
echo "Deleting cronjob."
./database/backup-jobs/$BKDESTROY/$BKDESTROY-cron-remove.sh
echo "Deleting configuration files."
rm -rf ./database/backup-jobs/$BKDESTROY
echo "Backup ID: $BKDESTROY DESTROYED!"
# Removing backup id from database file
echo "Cleaning up database file"
grep -v $BKDESTROY ./database/backup-database.txt > ./database/tmpfile && mv ./database/tmpfile ./database/backup-database.txt

}

### end of data destroy confirmed function

### data destroy function

datadestroy () {

select DATADESTROYCONFIRM in "Yes - Iam 100% sure!" "No - Cancel now!" ; do
    case $DATADESTROYCONFIRM in

        "Yes - Iam 100% sure!" ) confirmeddatadestroy ; break;;

        "No - Cancel now!" ) exit ; break;;

    esac
done

}
### end of data destroy function

### config destroy function

configdestroy () {

# Just deleting configuration files.

# Checking SMB/NFS sources first.
source ./database/backup-jobs/$BKDESTROY/$BKDESTROY-Configuration.env
if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]]
then
echo "Unmounting source share"
umount /mnt/lss-backup/$BKID/source
echo "Removing source mount point directory"
rm -rf /mnt/lss-backup/$BKID/source
else
echo "Seems like your source directory is set to local. Not touching that!"
fi
# Unmounting destination shares and deleting mountpoints. Again backups in destinations are not deleted as of yet in this version of script.
if [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
then
echo "Unmounting destination share."
umount /mnt/lss-backup/$BKID/destination
echo "Removing destination mount point directory"
rm -rf /mnt/lss-backup/$BKID/destination
# deleting backup job mount folder.
fi
# Deleting backup job mount point base folder based ib backup job id for both source and destination.
if [[ $BKSOURCETYPE == 'SMB' ]] || [[ $BKSOURCETYPE == 'NFS' ]] || [[ $BKDESTTYPE == 'SMB' ]] || [[ $BKDESTTYPE == 'NFS' ]]
then
echo "Deleting backup job ID: $BKID mountpoint base folder."
rm -rf /mnt/lss-backup/$BKID
fi
# Checking if destination is local
if [[ $BKDESTTYPE == 'LOCAL' ]]
then
echo "Local backup data are untouched!"
fi
# Checking if destination is S3 Bucket.
if [[ $BKDESTTYPE == 'S3' ]]
then
echo "You will have to delete data from S3 bucket manually."
fi
echo "Deleting cronjob."
./database/backup-jobs/$BKDESTROY/$BKDESTROY-cron-remove.sh
echo "Deleting configuration files."
rm -rf ./database/backup-jobs/$BKDESTROY
echo "Backup ID: $BKDESTROY DESTROYED!"
# Removing backup id from database file
echo "Cleaning up database file"
grep -v $BKDESTROY ./database/backup-database.txt > ./database/tmpfile && mv ./database/tmpfile ./database/backup-database.txt

}

### end of config destroy function
###### end of functions

#if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
#echo "List of backup(s):"
#ls database/backup-jobs/
#echo "--------------------------------"

BKDESTROY="$BACKUPJOB"

while [[ $BKDESTROY = "" ]]; do
   echo "Input backup ID you wish to destroy or press CTRL+C to cancel this process without destroying any backups."
   read BKDESTROY
done

# Checking if backup job already exist
if [ -d "./database/backup-jobs/$BKDESTROY" ];
then

# Checking if full destructive mode or just configuration delete.
echo "Would you like to delete backup data as well? Warning! This is not unrecoverable process!"

select DATADESTROYASK in "Yes - Delete all data" "No - Just delete configuration files" "EXIT!" ; do
    case $DATADESTROYASK in

        "Yes - Delete all data" ) datadestroy ; break;;

        "No - Just delete configuration files" ) configdestroy ; break;;

	"EXIT!" ) clear && echo "Nothing was deleted! Program closed successfully." ; exit;;
    esac
done
else
echo "Backup job ID $BKDESTROY does not exist!"
exit
fi

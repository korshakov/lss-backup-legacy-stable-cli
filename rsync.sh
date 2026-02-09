#!/bin/bash

###### FUNCTIONS STARTS HERE
### DAILY FUNCTION

dailyfunction (){

echo "BKFQ=Daily" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which hour of each day should backup start? In 24H format. Example: 19"
read SETUPBKCRONTIMEHH
echo "BKCRONTIMEHH=$SETUPBKCRONTIMEHH" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which minute of the hour $SETUPBKCRONTIMEHH should backup start? Example: 30"
read SETUPBKCRONTIMEMM
echo "BKCRONTIMEMM=$SETUPBKCRONTIMEMM" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which days of a week should backup run?"
read "SETUPBKCRONDAYS"
echo "BKCRONDAYS=$SETUPBKCRONDAYS" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Your backup will run at $SETUPBKCRONTIMEHH:$SETUPBKCRONTIMEMM on these days: $SETUPBKCRONDAYS"
}

### END OF DAILY FUNCTION

### WEEKLY FUNCTION

weeklyfunction (){

echo "BKFQ=Weekly" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which day should weekly backup start? Example: 1 That means it will run every Monday."
read SETUPBKCRONWEEKLY
echo "BKCRONWEEKLY=$SETUPBKCRONWEEKLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "What hour on the day of $SETUPBKCRONWEEKLY should backup start? In 24H format. Example: 19"
read SETUPBKCRONTIMEHH
echo "BKCRONTIMEHH=$SETUPBKCRONTIMEHH" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which minute of the hour specified before should backup start? Example: 30"
read SETUPBKCRONTIMEMM
echo "BKCRONTIMEMM=$SETUPBKCRONTIMEMM" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Your backup will run weekly on the day $SETUPBKCRONWEEKLY at $SETUPBKCRONTIMEHH:$SETUPBKCRONTIMEMM"
}

### END OF WEEKLY FUNCTION

### MONTHLY FUNCTION

monthlyfunction (){

echo "BKFQ=Monthly" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which day should monthly backup start? Example: 1 That means it will run on first day of every month."
read SETUPBKCRONMONTHLY
echo "BKCRONMONTHLY=$SETUPBKCRONMONTHLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which hour on the day $SETUPBKCRONWEEKLY of a month  should backup start? In 24H format. Example: 19"
read SETUPBKCRONTIMEHH
echo "BKCRONTIMEHH=$SETUPBKCRONTIMEHH" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Which minute of the hour specified before should backup start? Example: 30"
read SETUPBKCRONTIMEMM
echo "BKCRONTIMEMM=$SETUPBKCRONTIMEMM" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Your backup will run monthly on the day $SETUPBKCRONMONTHLY at $SETUPBKCRONTIMEHH:$SETUPBKCRONTIMEMM"
}

### END OF MONTHLY FUNCTION

### START OF MANUALFUNCTION

manualfunction (){

echo "BKFQ=Manual-Only" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF MANUAL FUNCTION

### LOCAL SOURCE FUNCTION

localsourcefunction () {
BKSOURCETYPE=LOCAL
echo "BKSOURCETYPE=LOCAL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "### LOCAL SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "What is your LOCAL source directory? Example: /home/user/some-files"
read SETUPSDIR
echo "SDIR=$SETUPSDIR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF LOCAL SOURCE FUNCTION

### SMB SOURCE FUNCTION

smbsourcefunction (){
BKSOURCETYPE=SMB
echo "BKSOURCETYPE=SMB" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "### SMB SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "Source target IP address?"
read SETUPMPTARGETIP
echo "MPTARGETIP=$SETUPMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Share name? Please make sure there are no spaces!"
read SETUPMPSN
echo "MPSN=$SETUPMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

SETUPSDIR="/mnt/lss-backup/$SETUPBKID/source"
echo "SDIR=$SETUPSDIR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Credentials"
echo "Username?"
read SETUPUSERNAME
echo "USERNAME=$SETUPUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Password?"
read SETUPPASSWORD
echo "PASSWORD=$SETUPPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Domain? Leave empty if not joined to domain."
read SETUPDOMAIN
echo "DOMAIN=$SETUPDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF SMB SOURCE FUNCTION

### NFS SOURCE FUNCTION

nfssourcefunction (){
BKSOURCETYPE=NFS
echo "BKSOURCETYPE=NFS" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "### NFS SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "Source target IP address?"
read SETUPMPTARGETIP
echo "MPTARGETIP=$SETUPMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Share name? Please make sure there are no spaces!"
read SETUPMPSN
echo "MPSN=$SETUPMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

#echo "Mountpoint directory where your source should be mounted? Example: /mnt/smb/source"
#read SETUPMP
SETUPSDIR="/mnt/lss-backup/$SETUPBKID/source"
echo "SDIR=$SETUPSDIR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Credentials."
echo "Username?"
read SETUPUSERNAME
echo "SETUPUSERNAME=$SETUPUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Password?"
read SETUPPASSWORD
echo "PASSWORD=$SETUPPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Domain? Leave empty if not joined to domain."
read SETUPDOMAIN
echo "DOMAIN=$SETUPDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF NFS SOURCE FUNCTION

### LOCAL DESTINATION FUNCTION

localdestfunction (){
BKDESTTYPE=LOCAL
echo "BKDESTTYPE=LOCAL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "### LOCAL DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "What is your LOCAL destination directory? Example: /home/user/my-backup-files"
read SETUPLSS_REPOSITORY
echo "LSS_REPOSITORY=$SETUPLSS_REPOSITORY/$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF LOCAL DESTINATION FUNCTION

### SMB DESTINATION FUNCTION

smbdestfunction (){
BKDESTTYPE=SMB
echo "BKDESTTYPE=SMB" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "### SMB DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "Destination target IP address?"
read SETUPDMPTARGETIP
echo "DMPTARGETIP=$SETUPDMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Share name? Please make sure there are no spaces!"
read SETUPDMPSN
echo "DMPSN=$SETUPDMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

SETUPLSS_REPOSITORY="/mnt/lss-backup/$SETUPBKID/destination/$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME"
echo "LSS_REPOSITORY=$SETUPLSS_REPOSITORY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Credentials"
echo "Username?"
read SETUPDUSERNAME
echo "DUSERNAME=$SETUPDUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Password?"
read SETUPDPASSWORD
echo "DPASSWORD=$SETUPDPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Domain? Leave empty if not joined to domain."
read SETUPDDOMAIN
echo "DDOMAIN=$SETUPDDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF SMB DESTINATION FUNCTION

### NFS DESTINATION FUNCTION
BKDESTTYPE=NFS
nfsdestfunction (){
echo "BKDESTTYPE=NFS" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "### NFS DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "Destination target IP address?"
read SETUPDMPTARGETIP
echo "DMPTARGETIP=$SETUPDMPTARGETIP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Share name? Please make sure there are no spaces!"
read SETUPDMPSN
echo "DMPSN=$SETUPDMPSN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

#echo "Mountpoint directory where your destination should be mounted? Example: /mnt/smb/source"
#read SETUPDMP
SETUPLSS_REPOSITORY="/mnt/lss-backup/$SETUPBKID/destination/$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME"
echo "LSS_REPOSITORY=$SETUPLSS_REPOSITORY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Credentials"
echo "Username?"
read SETUPDUSERNAME
echo "DUSERNAME=$SETUPDUSERNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Password?"
read SETUPDPASSWORD
echo "DPASSWORD=$SETUPDPASSWORD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Domain? Leave empty if not joined to domain."
read SETUPDDOMAIN
echo "DDOMAIN=$SETUPDDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF NFS DESTINATION FUNCTION

### Healthchecks monitoring

healthchecksfunction () {

echo "What is your healthchecks url? Example: https://cron.lssolutions.ie"
read SETUPCRONDOMAIN
echo "### HEALTHCHECKS VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "MONITORING=YES" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "CRONDOMAIN=$SETUPCRONDOMAIN" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "What is your healthchecks cron id? Example: 8bfc3d73-d49e-427c-8e70-8e40a7d67f1d"
read SETUPCRONID
echo "CRONID=$SETUPCRONID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### End of healthchecks monitoring
###### END OF FUNCTIONS
###### MAIN CODE

figlet LSS RSYNC
echo "Give your backup job an ID, usually numbers would be the best."
echo "Please note that backup ID is taken as a unique identifier! Avoid simple number but rather something more complex. Example CUS01"
read SETUPBKID

# Checking if backup job already exist"
if [ -d "./database/backup-jobs/"$SETUPBKID"" ];
then
echo "Backup ID already taken! Exiting"
exit
else
mkdir -p ./database/backup-jobs/"$SETUPBKID"
touch ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "### BACKUP GENERAL SETTINGS ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
SETUPTIMESTAMP=`date "+%d-%m-%Y--%H:%M"`
echo "BKID=$SETUPBKID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "PROGRAM=RSYNC" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Would you like to run rsync with --no-perms --no-owner --no-group? This is handy if sync is between mounted folders."
select setrsyncmode in "YES" "NO"; do
    case $setrsyncmode in

        YES ) echo "RSYNCMODE=NOPERMNOOWNNOGP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env" ; break;;

        NO ) echo "RSYNCMODE=NORMAL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env" ; exit;;

    esac
done

# Setting up work directory
echo "CREATIONTIMESTAMP=$SETUPTIMESTAMP" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
SETUPWORKDIR=$(pwd)
echo "WORKDIR=$SETUPWORKDIR/database/backup-jobs/$SETUPBKID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "Your backup configuration files will be stored at: $SETUPWORKDIR/database/backup-jobs/$SETUPBKID"

# Preparing backup job executable files and folders.

mkdir -p ./database/backup-jobs/"$SETUPBKID"/logs
cp ./functions/source-type-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-source-type-checks.sh
cp ./functions/local-source-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-source-folder-checks.sh
cp ./functions/smb-nfs-source-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-source-folder-checks.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-destination-type-checks.sh
cp ./functions/local-destination-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-destination-folder-checks.sh
cp ./functions/smb-nfs-destination-folder-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-destination-folder-checks.sh
cp ./functions/s3-destination-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-s3-destination-checks.sh
cp ./functions/backup-config-check.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-backup-config-check.sh
cp ./functions/repository-check.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-repository-check.sh
cp ./functions/destination-type-checks.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-destination-type-checks.sh
cp ./functions/lss-backup.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-backup.sh
cp ./functions/log-cleanup.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-log-cleanup.sh
cp ./functions/cron-add.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-add.sh
cp ./functions/cron-remove.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-remove.sh
cp ./functions/notify.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-notify.sh

printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-log-cleanup.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-add.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-remove.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-source-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-source-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-destination-type-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-local-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-s3-destination-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-backup-config-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-repository-check.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-smb-nfs-destination-folder-checks.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-backup.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-notify.sh
mkdir -p ./database/backup-jobs/"$SETUPBKID"/logs

echo "Name your backup e.g. Sage-Backup-TO-LS-CLOUD Important! Spaces are not allowed!"
read SETUPBKNAME
echo "BKNAME=$SETUPBKNAME" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Set your backup frequency."
select SETUPBKFQ in "Daily" "Weekly" "Monthly" "Manual-Only"; do
    case $SETUPBKFQ in

        Daily ) dailyfunction ; break;;

        Weekly ) weeklyfunction ; break;;
        
        Monthly ) monthlyfunction ; break;;
        
        Manual-Only ) manualfunction ; break;;

    esac
done

echo "### SOURCE VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "What is your backup source type? Either LOCAL, SMB or NFS."
select SETUPBKSOURCETYPE in "LOCAL" "SMB" "NFS"; do
    case $SETUPBKSOURCETYPE in

        LOCAL) localsourcefunction ; break;;

        SMB ) smbsourcefunction ; break;;
        
        NFS ) nfssourcefunction ; break;;

    esac
done



echo "### DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "What is your destination source type? Either LOCAL, SMB, NFS or S3."
select SETUPBKDESTTYPE in "LOCAL" "SMB" "NFS"; do
    case $SETUPBKDESTTYPE in

        LOCAL) localdestfunction ; break;;

        SMB ) smbdestfunction ; break;;
        
        NFS ) nfsdestfunction ; break;;

    esac
done

echo "Would you like to use healthchecks monitoring?"
select HEALTHCHECKSSETUP in "YES" "NO" ; do
    case $HEALTHCHECKSSETUP in

        YES) healthchecksfunction ; break;;

        NO ) echo "MONITORING=NO" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env" ; break;;

    esac
done

echo "Preparing starter script."
cp ./functions/starter-script.sh ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh"

echo "Writing to simple database file"


#### Adding entries to database file


if [[ $SETUPBKFQ == 'Daily' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RSYNC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Sync_Only |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONDAYS} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Weekly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RSYNC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Sync_Only |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONWEEKLY} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Monthly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RSYNC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Sync_Only |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_${SETUPBKCRONMONTHLY}_*_* " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Manual-Only' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RSYNC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Sync_Only |No_Schedule " >> ./database/backup-database.txt
fi




#### End of adding entries to database file



### Calling cron injection function
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-cron-add.sh

echo "Wizard is now finished. Would you like to run backup now?"

select RUNBACKUP in "YES" "NO" ; do
    case $RUNBACKUP in

        YES) /bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh" ; break;;

        NO ) echo "Good bye!" ; exit;;

    esac
done
fi

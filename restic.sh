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

### START OF EXLUSION FUNCTION

exclusionfunction (){
echo "EXCLUDE=YES" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "EXCLUDEFILE=${SETUPWORKDIR}/database/backup-jobs/"$SETUPBKID"/${SETUPBKID}-exclusion-file.txt" >> ./database/backup-jobs/${SETUPBKID}/${SETUPBKID}-Configuration.env

touch ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-exclusion-file.txt"

echo "Your exclusion file has been created! Don't forget to input your exclusion parameters according to restic guidelines."

echo "You exclusion file is located at /etc/lss-backup/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-exclusion-file.txt""
}

### END OF EXLUSION FUNCTION


### START OF NOEXLUSION FUNCTION

noexclusionfunction (){
echo "EXCLUDE=NO" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF NOEXLUSION FUNCTION


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

### S3 DESTINATION FUNCTION

s3destfunction (){
BKDESTTYPE=S3
echo "BKDESTTYPE=S3" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "### S3 DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "Please specify S3 api URL. Example: https://api-lscloud.lssolutions.ie"
read SETUPRESTICREPO
echo "S3 Bucket Name? Example sage-backups, please be aware of no upper letters and spaces!"
read SETUPRESTICBUCKET
echo "LSS_REPOSITORY=s3:$SETUPRESTICREPO/$SETUPRESTICBUCKET" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "S3 Access key id?"
read SETUPRESTICS3KEYID
echo "AWS_ACCESS_KEY_ID=$SETUPRESTICS3KEYID" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "S3 Secret access key?"
read SETUPRESTICS3KEY
echo "AWS_SECRET_ACCESS_KEY=$SETUPRESTICS3KEY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "S3 Region? Example: Dublin"
read SETUPRESTICS3REGION
echo "AWS_DEFAULT_REGION=$SETUPRESTICS3REGION" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

}

### END OF S3 DESTINATION FUNCTION

### FULL RETENTION FUNCTION

fullretentionfunction () {

echo "RETENTION=YES-FULL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "PRUNE=YES" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
cp ./functions/lss-reten-full.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-full.sh
cp ./functions/lss-prune.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-full.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh

echo "How many keep within daily backups to keep? Example: 7d means 7 days."
read  SETUPRETENDAILY
echo "RESTIC_FORGETDAILY=$SETUPRETENDAILY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "How many keep within weekly backups to keep? Example: 2m means two months. Please note that it uses months as per restic docs."
read SETUPRETENWEEKLY
echo "RESTIC_FORGETWEEKLY=$SETUPRETENWEEKLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "How many monthly backups to keep? Example: 15m means 15 months."
read SETUPRETENMONTHLY
echo "RESTIC_FORGETMONTHLY=$SETUPRETENMONTHLY" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "How many annual backups to keep? Example: 2y means 2 years."
read SETUPRETENANNUAL
echo "RESTIC_FORGETANNUAL=$SETUPRETENANNUAL" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"



#### Adding entries to database file


if [[ $SETUPBKFQ == 'Daily' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |KWD:$SETUPRETENDAILY--KWW:$SETUPRETENWEEKLY--KWM:$SETUPRETENMONTHLY--KWY:$SETUPRETENANNUAL |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONDAYS} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Weekly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |KWD:$SETUPRETENDAILY--KWW:$SETUPRETENWEEKLY--KWM:$SETUPRETENMONTHLY--KWY:$SETUPRETENANNUAL |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONWEEKLY} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Monthly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |KWD:$SETUPRETENDAILY--KWW:$SETUPRETENWEEKLY--KWM:$SETUPRETENMONTHLY--KWY:$SETUPRETENANNUAL |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_${SETUPBKCRONMONTHLY}_*_* " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Manual-Only' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |KWD:$SETUPRETENDAILY--KWW:$SETUPRETENWEEKLY--KWM:$SETUPRETENMONTHLY--KWY:$SETUPRETENANNUAL |No-Schedule " >> ./database/backup-database.txt
fi




#### End of adding entries to database file


}

### END OF FULL RETENTION FUNCTION

### LAST RETENTION FUNCTION

lastretentionfunction (){

echo "RETENTION=YES-LAST" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "PRUNE=YES" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
cp ./functions/lss-reten-keep-last-only.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-keep-last-only.sh
cp ./functions/lss-prune.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-reten-keep-last-only.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-prune.sh

echo "How many last (most recent) backups to keep? Enter a numeric number. Example: 7"
read SETUPRETENLAST
echo "RESTIC_FORGETLAST=$SETUPRETENLAST" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

#### Adding entries to database file


if [[ $SETUPBKFQ == 'Daily' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Last_only:$SETUPRETENLAST |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONDAYS} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Weekly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Last_only:$SETUPRETENLAST |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONWEEKLY} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Monthly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Last_only:$SETUPRETENLAST |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_${SETUPBKCRONMONTHLY}_*_* " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Manual-Only' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Last_only:$SETUPRETENLAST |No_Schedule " >> ./database/backup-database.txt
fi




#### End of adding entries to database file


}

### END OF LAST RETENTION FUNCTION

### SETUP RETENTION FUNCTION

setupretenfunction (){

echo "What type of retention? Full or just keep last?"
echo "Type FULL for full retention, type LAST for last only retention."
echo "Full retention is keep last, keep-within-daily, keep-within-weekly, keep-within-monthly, keep-within-yearly"
echo "For long-term persistent data use full retention, for fast snapshots like hourly use last only."
select RETENTYPE in "FULL" "LAST" ; do
    case $RETENTYPE in

        FULL ) fullretentionfunction ; break;;

        LAST ) lastretentionfunction ; break;;

    esac
done



}

### END OF SETUP RETENTION FUNCTION

### NO SETUP RETENTION FUNCTION

dontsetupretenfunction (){

echo "No retention policy will be specified."
echo "RETENTION=NO" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
cp ./functions/lss-no-reten.sh ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-no-reten.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-lss-no-reten.sh


#### Adding entries to database file


if [[ $SETUPBKFQ == 'Daily' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Not_set |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONDAYS} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Weekly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Not_set |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_*_*_${SETUPBKCRONWEEKLY} " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Monthly' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Not_set |${SETUPBKCRONTIMEMM}_${SETUPBKCRONTIMEHH}_${SETUPBKCRONMONTHLY}_*_* " >> ./database/backup-database.txt
fi

if [[ $SETUPBKFQ == 'Manual-Only' ]]
then
echo "|$SETUPBKID |$SETUPTIMESTAMP |$SETUPBKNAME |RESTIC |${SETUPBKSOURCETYPE}_to_${SETUPBKDESTTYPE} |$SETUPBKFQ |Not_set |No_Schedule " >> ./database/backup-database.txt
fi






}

### END OF NO SETUP RETENTION FUNCTION

### RUN INIT LATER

runinitlater (){

cp ./functions/restic-repo-init-only.sh ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-restic-repo-init-only.sh
echo "You must initialize restic repository manually otherwise your scheduled backup will fail!"
echo "To invoke restic repository initialization later copy paste the command below."
echo "/bin/bash $SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh"

}

### END OF RUN INIT LATER

### RUN INIT NOW

runinitnow () {

# Init restic repo only, no backup data transfer.
cp ./functions/restic-repo-init-only.sh ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh"
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-restic-repo-init-only.sh
/bin/bash $SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-restic-repo-init-only.sh

}


### END OF RUN INIT NOW

### NO BACKUP RUN FUNCTION

nobackuprun (){

echo "It is important to at least initialize restic repository otherwise scheduled cron will time out and send failed ping."
echo "Are you 100% sure that you want to even skip restic repository initialization?"
select NOBACKUPRUNCONFIRM in "YES - I WILL RUN INIT LATER" "NO - RUN INIT NOW" ; do
    case $NOBACKUPRUNCONFIRM in

        "YES - I WILL RUN INIT LATER" ) runinitlater ; break;;

        "NO - RUN INIT NOW" ) runinitnow ; break;;

    esac
done

}

### END OF NO BACKUP RUN FUNCTION

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

### Email notifications

emailsetup (){
echo "What is your email address?"
read EMAILADDR
echo "EMAILSETUP=Yes" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "EMAILSETUPADDR=$EMAILADDR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
}

noemailsetup () {
echo "EMAILSETUP=No" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
}

failonlyemailsetup (){
echo "What is your email address?"
read EMAILADDR
echo "EMAILSETUP=FailOnly" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
echo "EMAILSETUPADDR=$EMAILADDR" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"
}

### End of Email notifications

###### END OF FUNCTIONS
###### MAIN CODE


clear
figlet LSS RESTIC
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
echo "PROGRAM=RESTIC" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

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
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-log-cleanup.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-add.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-cron-remove.sh
printf '%s\n' 1a "source "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-Configuration.env" . x | ex ./database/backup-jobs/"$SETUPBKID"/$SETUPBKID-notify.sh

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

echo "### EXCLUSION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Do you want to use restic exclusion file?"
select SETUPEXLUSIONFILE in "Yes" "No"; do
    case $SETUPEXLUSIONFILE in

        Yes ) exclusionfunction ; break;;

        No ) noexclusionfunction ; break;;

    esac
done





echo "### DESTINATION VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "What is your destination source type? Either LOCAL, SMB, NFS or S3."
select SETUPBKDESTTYPE in "LOCAL" "SMB" "NFS" "S3"; do
    case $SETUPBKDESTTYPE in

        LOCAL) localdestfunction ; break;;

        SMB ) smbdestfunction ; break;;

        NFS ) nfsdestfunction ; break;;

        S3 ) s3destfunction ; break;;

    esac
done

echo "### RESTIC VARIABLES ###" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

echo "Would you like to setup retention policy?"
echo "As of right now retention policy is invoked right after backup. Custom schedule may be added in future."
echo "As of right now pruning is invoked right after retention. Custom schedule may be added in future."
echo "If you do not setup retention policy all backups will be kept and you will eventually run out of space."
echo "System is setup use within policy for more consistent data trough out the time!"

select SETUPRETENCONFIRM in "YES" "NO" ; do
    case $SETUPRETENCONFIRM in

        YES) setupretenfunction ; break;;

        NO ) dontsetupretenfunction ; break;;

    esac
done

echo "Input your restic repository password! You MUST store it securely somewhere else! Avoid using special characters which would break Linux!"
read SETUPRESTICREPOPASSWD
echo "RESTIC_PASSWORD=$SETUPRESTICREPOPASSWD" >> ./database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-Configuration.env"

##########

echo "Would you like to get email notifications?"

select EMAILNOTIFY in "Yes" "No" "Fail-Only" ; do
    case $EMAILNOTIFY in

    Yes ) emailsetup ; break;;

    No ) noemailsetup ; break;;

    Fail-Only ) failonlyemailsetup ; break;;

    esac
done

#############

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


### Calling cron injection function
/bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID"-cron-add.sh



echo "Restic repository will initialized in the first backup run."
echo "Wizard is now finished. Would you like to run backup now?"

select RUNBACKUP in "YES" "NO" ; do
    case $RUNBACKUP in

        YES) /bin/bash "$SETUPWORKDIR"/database/backup-jobs/"$SETUPBKID"/"$SETUPBKID-$SETUPBKFQ-$SETUPBKNAME.sh" ; break;;

        NO ) nobackuprun ; break;;

    esac
done

fi

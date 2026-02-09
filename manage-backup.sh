#!/bin/bash
### Functions

listsnapshots () {

restic -r $LSS_REPOSITORY snapshots

}

removesnapshots () {

restic -r $LSS_REPOSITORY snapshots
echo "Type in snapshot ID to remove."
read SNAPREMOVE
echo "Removing snapshot is not reversible process, are you 100% sure you want to delete this snapshot?"

select snapremoveconfirm in "Yes - Delete snapshot now!" "No - Cancel now!"; do
case $snapremoveconfirm in

        "Yes - Delete snapshot now!" ) restic -r $LSS_REPOSITORY forget "$SNAPREMOVE" ; break;;

        "No - Cancel now!" ) exit;;
esac
done

}

listkeys () {

restic -r $LSS_REPOSITORY key list

}

backupnow () {

./database/backup-jobs/$BACKUPJOB/$BACKUPJOB-$BKFQ-$BKNAME.sh

}

restorebackup () {

export BACKUPJOB
./restore-backup.sh

}

destroybackup () {
export BACKUPJOB
./remove-backup.sh
}

createbackup () {
./backup-wizard.sh
}

### End Of Functions

### Checking if any tmp files exists, if yes they are deleted.

FILE1=/etc/lss-backup/database/database.tmp
if [ -f "$FILE1" ]; then
echo "Deleting tmp files which shouldnt exist."
rm "$FILE1"
fi

FILE2=/etc/lss-backup/database/tmpfile.tmp
if [ -f "$FILE2" ]; then
echo "Deleting tmp files which shouldnt exist."
rm "$FILE2"
fi


clear
figlet LSS COMMANDER
if find database/backup-jobs/ -mindepth 1 -maxdepth 1 | read; then
echo "--------------------------------"
echo "List of backup(s):"
echo "--------------------------------"

file=/etc/lss-backup/database/backup-database.txt
prepfile=$(awk '(NR>1) {print}' $file)
echo "$prepfile" >> ./database/"database.tmp"


unset option menu ERROR      # prevent inheriting values from the shell
declare -a menu              # create an array called $menu
menu[0]=""                   # set and ignore index zero so we can count from 1

# read menu file line-by-line, save as $line
while IFS= read -r line; do
  menu[${#menu[@]}]="$line"  # push $line onto $menu[]
done < ./database/"database.tmp"

# function to show the menu
menu() {
  echo "Please select an option by typing in the corresponding number"
  echo ""
  for (( i=1; i<${#menu[@]}; i++ )); do
    echo "$i) ${menu[$i]}"
  done
  echo ""
}

# initial menu
menu
read option

# loop until given a number with an associated menu item
while ! [ "$option" -gt 0 ] 2>/dev/null || [ -z "${menu[$option]}" ]; do
  echo "No such option '$option'" >&2  # output this to standard error
  menu
  read option
done

# echo "You said '$option' which is '${menu[$option]}'"
echo "${menu[$option]}" >> ./database/tmpfile.tmp
rm ./database/"database.tmp"



SELECTEDBACKUPID=$(awk '{print substr($1,2); }' ./database/tmpfile.tmp)


BACKUPJOB="$SELECTEDBACKUPID"
rm ./database/tmpfile.tmp
	if [ -d "./database/backup-jobs/$BACKUPJOB" ];
	then
	source ./database/backup-jobs/$BACKUPJOB/$BACKUPJOB-Configuration.env
    if [[ $PROGRAM == 'RESTIC' ]]
    then
    export RESTIC_PASSWORD="$RESTIC_PASSWORD"
    export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
    export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
    export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"

    select commanderselect in "Run Backup Now" "Restore Backup" "List Snapshots" "Remove Snapshots" "List Keys" "Create New Backup" "Destroy Backup DANGER" "Exit"; do
    case $commanderselect in

        "Run Backup Now" ) backupnow ; break;;

	"Restore Backup" ) restorebackup ; break;;

        "List Snapshots" ) listsnapshots ; break;;

        "Remove Snapshots" ) removesnapshots ; break;;

        "List Keys" ) listkeys ; break;;

	"Create New Backup" ) createbackup ; break;;

	"Destroy Backup DANGER" ) destroybackup ; break ;;

        "Exit" ) echo "Nothing to do." ; exit;;

    esac
    done

    else

    select rsynccommanderselect in "Run Backup Now" "Restore Backup" "Destroy Backup DANGER" "Exit"; do
    case $rsynccommanderselect in
    "Run Backup Now" ) backupnow ; break;;

    "Restore Backup" ) restorebackup ; break;;
    
    "Destroy Backup DANGER" ) destroybackup ; break ;;

    "Exit" ) echo "Nothing to do." ; exit;;
    esac
    done

    fi

	else
	echo "Wrong backup job ID specified! Exitting"
	exit
	fi

else
echo "There are no backups to list!"
echo "Would you like to run backup wizard?"
	select continuetobackupwizard in "Yes" "No"; do
	case $continuetobackupwizard in

	"Yes" ) createbackup ; break;;

	"No" ) clear && echo "Good Bye!" ; exit;;

	esac
	done
fi

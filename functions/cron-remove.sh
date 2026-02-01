#!/bin/bash

if [[ $BKFQ == 'Daily' ]] || [[ $BKFQ == 'Weekly' ]] || [[ $BKFQ == 'Monthly' ]]
then
crontab -u root -l | sed -n '/'"$BKID"'-'"$BKFQ"'-'"$BKNAME"'/,/'"$BKID"'-'"$BKFQ"'-'"$BKNAME"'.sh/!p' | crontab -u root -
service cron reload
else
echo "Backup job was Manual Only, nothing to remove from crontab."
fi

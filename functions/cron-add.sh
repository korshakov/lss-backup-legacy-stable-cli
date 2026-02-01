#!/bin/bash


# this is simple cron injection script to do it for you instead.

if [[ $BKFQ == 'Daily' ]]
then
echo "Injecting command to crontab to the last line."
echo "Here is is for your convinience: $BKCRONTIMEMM $BKCRONTIMEHH * * * /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
line1="### Cron for $BKID-$BKFQ-$BKNAME"
line2="MAILTO=\"\""
line3="$BKCRONTIMEMM $BKCRONTIMEHH * * $BKCRONDAYS /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"

(crontab -u root -l; echo "" ) | crontab -u root -
(crontab -u root -l; echo "$line1" ) | crontab -u root -
(crontab -u root -l; echo "$line2" ) | crontab -u root -
(crontab -u root -l; echo "$line3" ) | crontab -u root -
service cron reload
fi

if [[ $BKFQ == 'Weekly' ]]
then
echo "Injecting command to crontab to the last line."
echo "Here is is for your convinience: $BKCRONTIMEMM $BKCRONTIMEHH * * $BKCRONWEEKLY /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
line1="### Cron for $BKID-$BKFQ-$BKNAME"
line2="MAILTO=\"\""
line3="$BKCRONTIMEMM $BKCRONTIMEHH * * $BKCRONWEEKLY /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
(crontab -u root -l; echo "" ) | crontab -u root -
(crontab -u root -l; echo "$line1" ) | crontab -u root -
(crontab -u root -l; echo "$line2" ) | crontab -u root -
(crontab -u root -l; echo "$line3" ) | crontab -u root -
service cron reload
fi

if [[ $BKFQ == 'Monthly' ]]
then
echo "Injecting command to crontab to the last line."
echo "Here is is for your convinience: $BKCRONTIMEMM $BKCRONTIMEHH $BKCRONMONTHLY * * /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
line1="### Cron for $BKID-$BKFQ-$BKNAME"
line2="MAILTO=\"\""
line3="$BKCRONTIMEMM $BKCRONTIMEHH $BKCRONMONTHLY * * /bin/bash $WORKDIR/$BKID-$BKFQ-$BKNAME.sh"
(crontab -u root -l; echo "" ) | crontab -u root -
(crontab -u root -l; echo "$line1" ) | crontab -u root -
(crontab -u root -l; echo "$line2" ) | crontab -u root -
(crontab -u root -l; echo "$line3" ) | crontab -u root -
service cron reload
fi

if [[ $BKFQ == 'Manual-Only' ]]
then
echo "No cronjob will be added as Manual Only was selected."
fi

if [[ $BKFQ != 'Daily' ]] && [[ $BKFQ != 'Weekly' ]] && [[ $BKFQ != 'Monthly' ]] && [[ $BKFQ != 'Manual-Only' ]]
then
echo "Ups! This should not happen here!"
fi

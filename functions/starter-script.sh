#!/bin/bash

echo "Welcome to LS Solutions Backup!"

wget "$CRONDOMAIN"/ping/"$CRONID"/start -T 10 -t 5 -O /dev/null

/bin/bash "$WORKDIR"/"$BKID"-backup-config-check.sh

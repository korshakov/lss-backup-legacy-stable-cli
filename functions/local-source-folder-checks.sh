#!/bin/bash

echo "LOCAL source folder should contain some files..."
if find "$SDIR" -mindepth 1 -maxdepth 1 | read; then
   echo "Directory contains folders/files."
   # daisy to destination-type-checks.sh
   /bin/bash "$WORKDIR"/"$BKID"-destination-type-checks.sh
   exit
else
   echo "Warning LOCAL source is either empty or does not exist! There is nothing to backup! Sending failed ping and exitting backup process."
        	export STATUS=7
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
   exit
fi

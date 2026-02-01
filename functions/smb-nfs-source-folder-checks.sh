#!/bin/bash

echo "SMB/NFS source folder should contain some files..."
if find "$SDIR" -mindepth 1 -maxdepth 1 | read; then
   echo "Directory contains folders/files."
   /bin/bash "$WORKDIR"/"$BKID"-destination-type-checks.sh
   exit
else
   echo "Warning SMB/NFS source directory is empty! There is nothing to backup! Sending failed ping and exitting backup process."
        	export STATUS=13
            /bin/bash "$WORKDIR"/"$BKID"-notify.sh
   exit
fi

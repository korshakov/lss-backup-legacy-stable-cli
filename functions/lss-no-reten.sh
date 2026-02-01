#!/bin/bash

# No Retention process no prune.

echo "No snapshots will be cleared as no retention policy specified. There is nothing to prune since everything is kept."
/bin/bash "$WORKDIR"/"$BKID"-log-cleanup.sh



echo "Print out of variables to double check if you wish."
# tail "$WORKDIR"/"$BKID"-Configuration.env
tail -n +1 "$WORKDIR"/"$BKID"-Configuration.env
echo "### END OF FILE###"
/bin/bash "$WORKDIR"/"$BKID"-source-type-checks.sh

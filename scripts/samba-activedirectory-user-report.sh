#!/bin/bash

REPORT_FILE="ad_user_report_$(date +%Y%m%d).txt"

echo -e "\nTotal Number of Users:" >> $REPORT_FILE
samba-tool user list | wc -l >> $REPORT_FILE

# Number of Users
echo -e "\nInactive user accounts (Enabled = No):" >> $REPORT_FILE
samba-tool user list | while read user; do
USER_STATUS=$(samba-tool user show $ADUSER | grep -i userAccountControl | awk '{print $2}')
if ! [[ "$USER_STATUS" =~ ^[0-9]+$ ]]; then
	continue
fi

# Inactive Users
if [ "$USER_STATUS" -eq 514 ]; then
	echo "$ADUSER" >> $REPORT_FILE
fi
done

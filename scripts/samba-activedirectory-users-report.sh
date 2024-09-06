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

# User Accounts That Have Never Been Logged
echo -e "\nUser Accounts That Have Never Been Logged In:" >> $REPORT_FILE
samba-tool user list | while read user; do
LASTLOGON=$(samba-tool user show $ADUSER | grep -i lastLogonTimestamp | awk '{print $2}')

if [ -z "$LASTLOGON" ] || [ "$LASTLOGON" -eq 0 ]; then
	echo "$ADUSER" >> $REPORT_FILE
fi
done

# User accounts with password set to Never Expiry
echo -e "\nUser accounts with password set to Never Expiry:" >> $REPORT_FILE
samba-tool user list | while read user; do
USERACCOUNTCONTROL=$(samba-tool user show $ADUSER | grep -i userAccountControl | awk '{print $2}')

if [[ "$USERACCOUNTCONTROL" =~ ^[0-9]+$ ]] && (( userAccountControl & 65536 )); then
	echo "$ADUSER" >> $REPORT_FILE
fi
done

echo -e
echo "You can view the report from the file: \nad_user_report_$(date +%Y%m%d).txt"

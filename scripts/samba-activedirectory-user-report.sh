#!/bin/bash

REPORT_FILE="ad_user_report_$(date +%Y%m%d).txt"

echo -e "\nTotal Number of Users:" >> $REPORT_FILE
samba-tool user list | wc -l >> $REPORT_FILE

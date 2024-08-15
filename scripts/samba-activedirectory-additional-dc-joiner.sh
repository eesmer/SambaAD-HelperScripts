#!/bin/bash

whiptail --msgbox \
    ".:: Samba Active Directory Join as ADC to Existing Domain ::. \
    \n---------------------------------------------------------------- \
    \nThis program is distributed for the purpose of being useful. \
    \nThis program adds the server it runs on to the Samba AD domain as an ADC. \
    \nThe script will get the domain information and add the server to the environment as an ADC with the Domain Admin authority. \
    \n
    \nThe script works on Debian Distribution. \
    \nDebian 11 and 12 are compatible. \
    \n---------------------------------------------------------------- \
    \n\nhttps://github.com/eesmer/SambaAD-HelperScripts \
    \nhttps://github.com/eesmer/sambadtui \
    \nhttps://github.com/eesmer/DebianDC" 25 90 45

HNAME=$(whiptail --inputbox "Enter the DC Machine Hostname without FQDN (e.g.,DC02)" 10 50 --title "DC Hostname" --backtitle "DC Hostname" 3>&1 1>&2 2>&3)
ANSWER=$?
        if [ ! $ANSWER = 0 ]; then
                echo "User canceled"
                exit 1
        fi
DNSSRV=$(whiptail --inputbox "Enter the DNS Server IP Address" 10 50 --title "DNS Server Info" --backtitle "DNS Server Info" 3>&1 1>&2 2>&3)
ANSWER=$?
        if [ ! $ANSWER = 0 ]; then
                echo "User canceled"
                exit 1
        fi
DOMAIN=$(whiptail --inputbox "Enter the Domain Name (e.g., example.lan)" 10 50 --title "Domain Name" --backtitle "Domain Name" 3>&1 1>&2 2>&3)
ANSWER=$?
        if [ ! $ANSWER = 0 ]; then
                echo "User canceled"
                exit 1
        fi
PASSWORD=$(whiptail --passwordbox "Enter the Administrator Password" 10 50 --title "Administrator Password" --backtitle "Administrator Password" 3>&1 1>&2 2>&3)
ANSWER=$?
        if [ ! $ANSWER = 0 ]; then
                echo "User canceled"
                exit 1
        fi

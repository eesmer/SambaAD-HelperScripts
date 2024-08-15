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

if [ "$HNAME" = "" ] || [ "$DNSSRV" = "" ] || [ "$DOMAIN" = "" ] || [ "$PASSWORD" = "" ]
then
whiptail --msgbox "Please fill all the fields" 10 50
exit 1
fi

hostnamectl set-hostname $HNAME.$DOMAIN
echo "domain $DOMAIN" > /etc/resolv.conf && echo "search $DOMAIN" >> /etc/resolv.conf && echo "nameserver $DNSSRV" >> /etc/resolv.conf
sed -i "/127.0.1.1/ c 127.0.1.1 $HNAME.$DOMAIN $HNAME" /etc/hosts

ping $DOMAIN -c 1 &> /dev/null
pingReturn=$?

if [ $pingReturn -eq 1 ]; then
whiptail --msgbox "$DOMAIN did not ping reply" 10 50
exit 1
elif [ $pingReturn -eq 2 ]; then
whiptail --msgbox "$DOMAIN name could not be resolved\n\nCheck the DNS Server information ($DNSSRV)" 10 50
exit 1
else
whiptail --msgbox "Great!!\n$DOMAIN Domain Name found.\nThe join process can be started" 10 50
fi

# INSTALL PACKAGES
function ADCSETUP {
PACK_INSTALL=FALSE
export DEBIAN_FRONTEND=noninteractive
apt-get -y install bind9 bind9utils dnsutils krb5-user samba --install-recommends winbind && PACK_INSTALL=TRUE
if [ "$PACK_INSTALL" = "FALSE" ];then
    whiptail --msgbox "Operation cannot continue!!\nThe required packages could not be installed.\nPlease check the internet access" 10 50
    exit 1
fi

DOMAIN_JOIN=FALSE
rm /etc/samba/smb.conf
samba-tool domain join \
$DOMAIN DC --dns-backend=BIND9_DLZ -U Administrator --password=$PASSWORD && DOMAIN_JOIN=TRUE
        if [ "$DOMAIN_JOIN" = "FALSE" ];then
            whiptail --msgbox "Could not join domain!!\nPlease check the information you entered" 10 50
            exit 1
        fi

# BIND CONFIG
rm /etc/default/bind9
cat > /etc/default/bind9 << EOF
RESOLVCONF=no
OPTIONS="-u bind -4"
EOF
chmod 644 /etc/default/bind9

chmod 644 /etc/default/bind9
echo 'include "/var/lib/samba/bind-dns/named.conf";' > /etc/bind/named.conf.local

rm /etc/bind/named.conf.options

SERVER_IP=$(ip r |grep link |grep src |cut -d'/' -f2 |cut -d'c' -f3 |cut -d' ' -f2)
INTERNAL1=127.0.0.0/8
INTERNAL2=$(ip r |grep link |grep src |cut -d' ' -f1)
SUBNET=$(ip r |grep link |grep src |cut -d' ' -f1 |cut -d'/' -f2)
PDC=$(nslookup $DOMAIN |grep Server: |cut -d ':' -f2)

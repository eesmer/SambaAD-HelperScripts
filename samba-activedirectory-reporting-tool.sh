#!/bin/bash

SERVERNAME=$(cat /etc/hostname)
SERVERIP=$(ip r |grep link |grep src |cut -d'/' -f2 |cut -d'c' -f3 |cut -d' ' -f2)
DOMAINNAME=$(cat /etc/samba/smb.conf | grep "realm" | cut -d "=" -f2 | xargs)
SERVERROLE=$(cat /etc/samba/smb.conf | grep "server role" | cut -d "=" -f2 | xargs)
FORESTLEVEL=$(samba-tool domain level show | grep "Forest function level:" | cut -d ":" -f2 | xargs)
DOMAINLEVEL=$(samba-tool domain level show | grep "Domain function level:" | cut -d ":" -f2 | xargs)
LOWESTLEVEL=$(samba-tool domain level show | grep "Lowest function level of a DC:" | cut -d ":" -f2 | xargs)
DBCHECKRESULT=$(samba-tool dbcheck | grep "Checked")
PASSCOMPLEX=$(samba-tool domain passwordsettings show | grep "Password complexity:" | cut -d ":" -f2 | xargs)
PASSHISTORY=$(samba-tool domain passwordsettings show | grep "Password history length:" | cut -d ":" -f2 | xargs)
MINPASSLENGTH=$(samba-tool domain passwordsettings show | grep "Minimum password length:" | cut -d ":" -f2 | xargs)
MINPASSAGE=$(samba-tool domain passwordsettings show | grep "Minimum password age (days):" | cut -d ":" -f2 | xargs)
MAXPASSAGE=$(samba-tool domain passwordsettings show | grep "Maximum password age (days):" | cut -d ":" -f2 | xargs)

# FSMO ROLES
SCHEMAMASTER=$(samba-tool fsmo show |grep "SchemaMasterRole" |cut -d "," -f2 | cut -d "=" -f2)
INFRAMASTER=$(samba-tool fsmo show |grep "InfrastructureMasterRole" |cut -d "," -f2 | cut -d "=" -f2)
RIDMASTER=$(samba-tool fsmo show |grep "RidAllocationMasterRole" |cut -d "," -f2 | cut -d "=" -f2)
PDCMASTER=$(samba-tool fsmo show |grep "PdcEmulationMasterRole" |cut -d "," -f2 | cut -d "=" -f2)
NAMINGMASTER=$(samba-tool fsmo show |grep "DomainNamingMasterRole" |cut -d "," -f2 | cut -d "=" -f2)
DDNSMASTER=$(samba-tool fsmo show |grep "DomainDnsZonesMasterRole" |cut -d "," -f2 | cut -d "=" -f2)
FDNSMASTER=$(samba-tool fsmo show |grep "ForestDnsZonesMasterRole" |cut -d "," -f2 | cut -d "=" -f2)

whiptail --msgbox \
".:: Samba Active Directory Domain Controller Server Report ::. \
\n---------------------------------------------------------------- \
\nHostName                 : $SERVERNAME \
\nServer IP Addr.          : $SERVERIP \
\nDomain Name              : $DOMAINNAME \
\nServer Role              : $SERVERROLE \
\nForest Level             : $FORESTLEVEL \
\nDomain Level             : $DOMAINLEVEL \
\nLowest Level             : $LOWESTLEVEL \
\n---------------------------------------------------------------- \
\nDB Check Result          : $DBCHECKRESULT \
\n---------------------------------------------------------------- \
\nPassword Complexity      : $PASSCOMPLEX \
\nPassword History         : $PASSHISTORY \
\nMinimum Password Length  : $MINPASSLENGTH \
\nMinimum Password Age     : $MINPASSAGE \
\nMaximum Password Age     : $MAXPASSAGE \
\n---------------------------------------------------------------- \
\nSchema Master DC         : $SCHEMAMASTER \
\nInfrastructure Master DC : $INFRAMASTER \
\nRID Master DC            : $RIDMASTER \
\nPDC Master DC            : $PDCMASTER \
\nDomain Naming Master DC  : $NAMINGMASTER \
\nDomain DNS Master DC     : $DDNSMASTER \
\nForest DNS Master DC     : $FDNSMASTER \
\n\n---------------------------------------------------------------- \
\nhttps://github.com/eesmer/SambaAD-HelperScripts" 0 0 0
#20 90 45

exit 1

#samba-tool domain info $SERVER
samba-tool processes
samba-tool ou listobjects OU="Domain Controllers"

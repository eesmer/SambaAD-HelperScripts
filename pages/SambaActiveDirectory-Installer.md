## Samba Active Directory Installer

### About of Installer Script
This script requests the necessary information for the Domain installation and performs the domain installation according to the information entered. <br>
The machine on which this script runs is set up as a Domain Controller. <br> 
With this script, the host machine assumes the PDC role and runs the Bind9 DNS service. <br>
**Tested environment:** Debian 11

---

```
wget https://raw.githubusercontent.com/eesmer/SambaAD-HelperScripts/master/scripts/samba-activedirectory-installer.sh
```
```
bash  samba-activedirectory-installer.sh
```

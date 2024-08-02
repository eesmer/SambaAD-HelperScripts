## Samba Active Directory Installer

### About of Installer Script
This script, 
- It installs the Samba package and its requirements.
- It installs and configures bind9 for DNS.
- It installs and configures the chrony service for the NTP service. <br>
<br>
Then, it performs the Domain Name Provisioning process according to the information it receives and configures the smb.conf file.
The machine on which it is run takes the PDC role and starts working as a DC for the established domain. <br>
<br>
As the `root`: <ins>perform operations as root user.!!</ins> <br>
**It should be run in a Debian 11 environment.**

---

```
wget https://raw.githubusercontent.com/eesmer/SambaAD-HelperScripts/master/scripts/samba-activedirectory-installer.sh
```
```
bash  samba-activedirectory-installer.sh
```

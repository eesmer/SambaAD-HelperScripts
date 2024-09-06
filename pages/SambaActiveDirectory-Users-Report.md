## Samba Active Directory Users Report 

### About of Script
This script generates a report of AD user accounts.
- Sorts accounts by creation date
- Shows Never Expiry accounts
- Shows privileged group memberships of user accounts
- Shows user accounts that are not logged in <br>
etc.

```
Should be run on the DC machine.
```
As the `Should be run on the DC machine.`: <ins>perform operations as root user.!!</ins>


```
wget https://raw.githubusercontent.com/eesmer/SambaAD-HelperScripts/master/scripts/samba-activedirectory-users-report.sh
```
```
bash  samba-activedirectory-users-report.sh
```

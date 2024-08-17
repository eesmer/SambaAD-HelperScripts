This script <br> adds an additional domain controller to a Samba AD environment set up with the [Samba Active Directory Installer](https://github.com/eesmer/SambaAD-HelperScripts/blob/master/pages/SambaActiveDirectory-Installer.md) script.

You will need to know the password for the Administrator user account to complete the installation.

With the ADC installed;
It becomes a 2nd DC machine that runs simultaneously in the domain environment and acts as a DC for all components in the Active Directory environment (dns records, ad objects, database, fsmo roles, etc.).

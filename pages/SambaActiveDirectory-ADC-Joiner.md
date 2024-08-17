This script adds the machine it runs on to a Samba AD environment set up with the installer script, as an additional domain controller.
You will need to know the password for the Administrator user account to complete the installation.

With the ADC installed;
It becomes a 2nd DC machine that runs simultaneously in the domain environment and acts as a DC for all components in the Active Directory environment (dns records, name objects, database, fsmo roles, etc.).

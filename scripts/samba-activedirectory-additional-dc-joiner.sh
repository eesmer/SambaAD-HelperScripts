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

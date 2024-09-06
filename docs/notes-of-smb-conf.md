### NTLM versions compatibility
- **Allow to NTLMv1 and later** <br>
```
[global]
   ntlm auth = yes
   client ntlmv2 auth = yes
```

- **Allow to only NTLMv2**
```
[global]
   ntlm auth = no
   client ntlmv2 auth = yes
```

---

### log-level usage

The log-level levels to be specified in the smb.conf file are between 0-10. <br>
- **0: Minimum Logging:** Makes minimum log records. Only important errors and messages are recorded. <br>
- **1: Basic Information Messages:** Errors and basic information messages are recorded. <br>
- **2: Extra Information:** More details are added to the log records with extra information. <br>
- **3: High-level logging:** This is the lowest level to be used during troubleshooting. <br>
- **4: Detailed logging:** All process steps and status are reported. <br>
- **5: Very Detailed logging:** Every event is reported. It should only be used for detailed debugging needs. <br>
- **6-10: Extremely Detailed:** These levels provide too much information. They should be used temporarily and are not suitable for production environments. <br>

```
log level = 3
log file = /var/log/samba/$DOMAIN_NAME.log
```

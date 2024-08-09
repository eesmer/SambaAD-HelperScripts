### NTLM versions compatibility
- **Allow to NTLMv1 and later** <br>
Setting ntlm auth=yes allows NTLMv1 and later. <br>
This allows Windows to connect with less security but a higher level of compliance.

```
lanman auth = no
ntlm auth = yes
client lanman auth = yes
```

- **Allow to only NTLMv2**
```
ntlm auth = ntlmv2-only
```
---

### log-level usage

The log-level levels to be specified in the smb.conf file are between 0-10. <br>
**0: Minimum Logging:** Makes minimum log records. Only important errors and messages are recorded. <br>
**1: Basic Information Messages:** Errors and basic information messages are recorded. <br>
**2: Extra Information:** More details are added to the log records with extra information. <br>
**3: High-level logging:** This is the lowest level to be used during troubleshooting. <br>

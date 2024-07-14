### NTLM versions compatibility
- **Allow to NTLMv1 and later** <br>
Setting ntlm auth=yes allows NTLMv1 and later. <br>
This allows Windows to connect with less security but a higher level of compliance.

```
lanman auth = no
ntlm auth = yes
client lanman auth = yes
```
---

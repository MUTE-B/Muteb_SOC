# MUTEB SOC - MITRE ATT&CK Mapping


## Overview

This document maps MUTEB SOC detection capabilities to MITRE ATT&CK techniques.


| MITRE ID | Technique | MUTEB SOC Module | Detection Capability |
|----------|-----------|------------------|----------------------|
| T1110 | Brute Force | Authentication Monitor | SSH failed login detection |
| T1059 | Command and Scripting Interpreter | Process Hunter | Suspicious shell execution |
| T1082 | System Information Discovery | System Monitor | Host information collection |
| T1046 | Network Service Scanning | Network Hunter | Suspicious network activity |
| T1053 | Scheduled Task/Job | Persistence Hunter | Persistence detection |
| T1083 | File and Directory Discovery | File Hunter | Suspicious file access |
| T1105 | Ingress Tool Transfer | IOC Scanner | Download activity detection |
| T1071 | Application Layer Protocol | Network Monitor | Suspicious communication |


---

# Detection Engineering Coverage


## Credential Access

Technique:

T1110 - Brute Force


Detection:

- SSH authentication monitoring
- Failed login analysis
- Suspicious username tracking



## Execution

Technique:

T1059 - Command Shell


Detection:

- Shell execution monitoring
- Suspicious command analysis



## Persistence

Technique:

T1053 - Scheduled Task/Job


Detection:

- Cron monitoring
- Startup persistence checks



## Discovery

Technique:

T1082 - System Information Discovery


Detection:

- Host enumeration
- System information collection



---

# Analyst Skills Demonstrated

- MITRE ATT&CK Mapping
- Detection Engineering
- Threat Hunting
- Log Analysis
- Incident Response


# Splunk SPL Detection Queries


## SSH Brute Force Detection



index=linux
source=/var/log/auth.log
"Failed password"
| stats count by src_ip
| where count > 5



## Suspicious Process Detection



index=windows
EventCode=4688
process_name=powershell.exe



## Failed Authentication Monitoring



index=security
EventCode=4625
| stats count by user




## SOC Skills Demonstrated


- Log Searching
- Alert Investigation
- Event Correlation



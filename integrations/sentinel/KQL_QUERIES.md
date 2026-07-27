# Microsoft Sentinel KQL Examples


## Failed Login Detection


```kql
SecurityEvent
| where EventID == 4625
| summarize Attempts=count()
by Account

SecurityEvent
| where CommandLine contains "powershell"
SecurityEvent
| where EventID == 4625
| summarize count()
by IpAddress


#!/usr/bin/env python3


import datetime
import os



report=f"""

MUTEB SOC INCIDENT REPORT

Date:
{datetime.datetime.now()}


Incident ID:
AUTO-{datetime.datetime.now().strftime('%Y%m%d')}


Status:
Open


Severity:
Unknown


Summary:




Investigation:




Containment:




Recovery:




Recommendations:




"""



os.makedirs(

"reports",

exist_ok=True

)



with open(

"reports/incident_report.txt",

"w"

) as f:

    f.write(report)



print("[+] Incident Report Created")


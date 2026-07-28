#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC v1.1
# HTML SOC Dashboard Generator
# ==========================================================
#

import json
import os
import datetime


REPORT_FILE = "reports/security_report.json"

OUTPUT_FILE = "reports/dashboard.html"



def generate_dashboard():

    if not os.path.exists(REPORT_FILE):

        print("JSON report not found")

        return


    with open(REPORT_FILE) as file:

        data = json.load(file)



    severity = data.get(
        "severity",
        "UNKNOWN"
    )


    failed = data.get(
        "failed_login_count",
        0
    )


    sudo = data.get(
        "sudo_events",
        0
    )



    html = f"""

<!DOCTYPE html>

<html>

<head>

<title>MUTEB SOC Dashboard</title>


<style>

body {{

background:#111;

color:white;

font-family:Arial;

padding:30px;

}}


.card {{

background:#222;

padding:20px;

margin:15px;

border-radius:10px;

}}


h1 {{

color:#00ff99;

}}


.high {{

color:red;

}}


.medium {{

color:orange;

}}


.low {{

color:#00ff99;

}}

</style>


</head>



<body>


<h1>
MUTEB SOC v1.1 Dashboard
</h1>



<div class="card">

<h2>
Security Status
</h2>


<p>
Severity:
<span class="{severity.lower()}">
{severity}
</span>

</p>


</div>



<div class="card">

<h2>
Threat Statistics
</h2>


<p>
Failed SSH Attempts:
{failed}

</p>


<p>
Sudo Events:
{sudo}

</p>


</div>



<div class="card">

<h2>
Generated
</h2>


<p>
{datetime.datetime.now()}
</p>


</div>



</body>

</html>

"""


    with open(
        OUTPUT_FILE,
        "w"
    ) as file:

        file.write(html)



    print("[+] HTML Dashboard Created")

    print(OUTPUT_FILE)



if __name__ == "__main__":

    generate_dashboard()


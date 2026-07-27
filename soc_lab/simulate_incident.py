#!/usr/bin/env python3

"""
MUTEB SOC - Incident Simulation

Creates safe test security events
for SOC detection validation.
"""


import os
from datetime import datetime



LOG_DIR = "soc_lab/logs/auth"



EVENTS = [

"Jul 27 10:00 server sshd[1001]: Failed password for invalid user admin from 192.168.1.50 port 22",

"Jul 27 10:01 server sshd[1002]: Failed password for invalid user root from 192.168.1.50 port 22",

"Jul 27 10:02 server sshd[1003]: Failed password for invalid user test from 192.168.1.50 port 22",

"Jul 27 10:03 server sshd[1004]: authentication failure for user root"


]





def create_test_logs():


    os.makedirs(
        LOG_DIR,
        exist_ok=True
    )


    filename = (

        f"{LOG_DIR}/"

        f"auth_test.log"

    )



    with open(
        filename,
        "w"
    ) as log:


        for event in EVENTS:

            log.write(
                event + "\n"
            )



    print(
        "[+] Test security events generated"
    )





if __name__ == "__main__":


    print(
        "=== MUTEB SOC INCIDENT SIMULATION ==="
    )


    create_test_logs()



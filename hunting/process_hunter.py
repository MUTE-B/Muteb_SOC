#!/usr/bin/env python3

import psutil


print("\n=== MUTEB SOC PROCESS HUNTER ===\n")


keywords=[

    "nc",
    "netcat",
    "nmap",
    "miner",
    "crypt",
    "bash"

]


for process in psutil.process_iter(

    ['pid','name','username']

):

    try:

        name=process.info['name']

        if name:

            for key in keywords:

                if key.lower() in name.lower():

                    print(

                    "[!] Suspicious Process:",
                    process.info

                    )


    except:

        pass



print("\n[+] Process Hunting Completed")


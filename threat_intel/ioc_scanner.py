#!/usr/bin/env python3

import os
import hashlib


IOC_FILE="threat_intel/iocs.txt"



SEARCH_DIR="/tmp"



if not os.path.exists(IOC_FILE):

    open(IOC_FILE,"w").write(

    "# Add hashes here\n"

    )



with open(IOC_FILE) as f:

    iocs=[x.strip() for x in f.readlines()]



print("\n=== MUTEB SOC IOC SCANNER ===\n")



for root,dirs,files in os.walk(SEARCH_DIR):


    for file in files:


        path=os.path.join(root,file)


        try:

            sha256=hashlib.sha256(

            open(path,'rb').read()

            ).hexdigest()



            if sha256 in iocs:

                print(

                "[!] IOC MATCH:",

                path

                )


        except:

            pass



print("\n[+] IOC Scan Completed")


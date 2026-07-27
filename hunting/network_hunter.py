#!/usr/bin/env python3

import psutil


print("\n=== MUTEB SOC NETWORK HUNTER ===\n")


for conn in psutil.net_connections():

    if conn.status=="ESTABLISHED":

        print(

        "[+] Connection:",

        conn.laddr,

        "->",

        conn.raddr

        )


print("\n[+] Network Hunting Completed")


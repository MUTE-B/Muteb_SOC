#!/bin/bash

echo "================================="
echo " MUTEB SOC DASHBOARD STATUS"
echo "================================="

systemctl status muteb-soc-dashboard --no-pager

echo
echo "[+] Port Check"

ss -tulnp | grep 5000


#!/bin/bash

echo "================================="
echo " MUTEB SOC DASHBOARD UPDATE"
echo "================================="


git pull


python3 -m pip install -r web_dashboard/requirements.txt


echo "[+] Dashboard Updated"


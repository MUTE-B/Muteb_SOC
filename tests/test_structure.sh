#!/bin/bash
#
# MUTEB SOC
# Project Structure Test
#


echo "=== MUTEB SOC STRUCTURE TEST ==="


DIRS=(

automation
automation/bash
automation/python
detections
playbooks
docs
reports
logs
utilities
hardening
incident
hunting
threat_intel

)



PASS=0
FAIL=0



for DIR in "${DIRS[@]}"
do

if [[ -d "$DIR" ]]

then

echo "[+] OK : $DIR"

((PASS++))

else

echo "[-] Missing : $DIR"

((FAIL++))

fi


done



echo

echo "Passed : $PASS"

echo "Failed : $FAIL"


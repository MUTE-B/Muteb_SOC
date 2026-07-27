#!/bin/bash

echo "=== STRUCTURE TEST ==="


FILES=(

"muteb_soc.sh"
"dashboard.sh"
"automation/python/log_analyzer.py"
"threat_intel/ioc_scanner.py"
"incident/case_manager.py"
"hunting/persistence_hunter.py"
"hardening/firewall_hardening.sh"

)


for FILE in "${FILES[@]}"
do

if [[ -f "$FILE" ]]

then

echo "[+] OK : $FILE"

else

echo "[-] MISSING : $FILE"

fi

done


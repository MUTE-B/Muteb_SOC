#!/bin/bash

echo "====================================="
echo "   MUTEB SOC FINAL SYSTEM TEST"
echo "====================================="


echo "[+] Checking Core Files"

FILES=(

"muteb_soc.sh"

"web_dashboard/dashboard_api.py"

"web_dashboard/modules/system_manager.py"

"web_dashboard/modules/event_collector.py"

"web_dashboard/modules/report_generator.py"

"engine/rule_engine.py"

"detections/mitre_mapping.yml"

"yara_rules/muteb_suspicious_file.yar"

)


for FILE in "${FILES[@]}"
do

if [ -f "$FILE" ]

then

echo "[OK] $FILE"

else

echo "[FAIL] $FILE"

fi

done



echo

echo "[+] Running Detection Engine"

python3 engine/rule_engine.py



echo

echo "[+] Running System Collector"

python3 web_dashboard/modules/system_manager.py



echo

echo "[+] Generating Security Report"

python3 web_dashboard/modules/report_generator.py



echo

echo "====================================="

echo " MUTEB SOC TEST COMPLETED"

echo "====================================="




#!/bin/bash


echo "MUTEB SOC FINAL SECURITY AUDIT"


echo ""


echo "[+] Checking Python"


python3 --version



echo "[+] Checking Structure"


test -d app && echo "APP OK"


test -d logs && echo "LOGS OK"


test -d reports && echo "REPORTS OK"



echo "[+] Audit Completed"



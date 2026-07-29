

#!/bin/bash


echo "===== MUTEB SOC SECURITY AUDIT ====="


echo


echo "[FILES]"


find backend -type f -perm -002 -print



echo


echo "[SENSITIVE FILES]"



find . -name ".env" -o -name "*.key" -o -name "*.pem"



echo


echo "[RUNNING SERVICES]"



docker compose ps



echo


echo "AUDIT COMPLETE"




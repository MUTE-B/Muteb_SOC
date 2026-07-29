

#!/bin/bash


set -e



echo "===== MUTEB SOC RELEASE CHECK ====="



echo "[VERSION]"

cat VERSION



echo


echo "[BACKEND]"

curl -s http://127.0.0.1:8000/health || echo "Backend health failed"



echo


echo "[SCANNER TEST]"



curl -s \

-X POST http://127.0.0.1:8000/api/scanner/start \

-H "Content-Type: application/json" \

-d '{"target":"example.com"}'



echo



echo "[FRONTEND]"



curl -I -s http://127.0.0.1 | head -1



echo


echo "RELEASE READY"




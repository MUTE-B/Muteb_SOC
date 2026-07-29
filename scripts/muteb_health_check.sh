

#!/bin/bash


echo "===== MUTEB SOC HEALTH CHECK ====="


echo



echo "[Docker]"

docker compose ps



echo



echo "[Backend]"

curl -s http://127.0.0.1:8000/health || echo "Backend Failed"



echo



echo "[Frontend]"

curl -I -s http://127.0.0.1 | head -1



echo



echo "[Containers]"

docker stats --no-stream




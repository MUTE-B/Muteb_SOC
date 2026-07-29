#!/bin/bash

echo "======================================"
echo " MUTEB SOC LOGIN RESPONSE FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Search login handling"

grep -R "Invalid Credentials\|login(" frontend/src \
--exclude-dir=node_modules || true



echo "[2] Patch App.jsx"


python3 - <<'PY'

from pathlib import Path

p=Path("frontend/src/App.jsx")

if p.exists():

    text=p.read_text()


    text=text.replace(
        "response.data.status",
        "response.data.success"
    )


    text=text.replace(
        "data.status",
        "data.success"
    )


    text=text.replace(
        "result.status",
        "result.success"
    )


    p.write_text(text)

    print("App.jsx updated")

else:

    print("App.jsx not found")


PY



echo "[3] Restart Frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 8


echo ""
echo "======================================"
echo " DONE"
echo "======================================"


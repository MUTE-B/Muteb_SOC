#!/bin/bash

echo "======================================"
echo " MUTEB SOC ALERTS EVENTS UI"
echo " CODE 37"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup App"


mkdir -p frontend/UI_BACKUP_CODE37

cp frontend/src/App.jsx frontend/UI_BACKUP_CODE37/App.jsx.backup



echo "[2] Updating Dashboard Navigation"


python3 - <<'PY'

from pathlib import Path

file = Path("frontend/src/App.jsx")

data = file.read_text()


data = data.replace(
'<div>Alerts</div>',
'<div>Alerts</div>\n<div>Security Events</div>'
)


data = data.replace(
'<h2>Recent Security Alerts</h2>',
'<h2>Security Alerts & Events</h2>'
)


file.write_text(data)

PY



echo "[3] Add SOC tables styling"



cat >> frontend/src/App.css <<'EOF'


/* ===================================
   SOC ALERTS TABLE
=================================== */


.panel table{

width:100%;

border-collapse:collapse;

margin-top:20px;

}



.panel th{

text-align:left;

padding:14px;

background:#0f172a;

color:#38bdf8;

}



.panel td{

padding:14px;

border-bottom:1px solid #1e293b;

}



.panel tr:hover{

background:#0f172a;

}



.status{

padding:8px 15px;

border-radius:20px;

background:#064e3b;

color:#34d399;

font-size:14px;

}



EOF



echo "[4] Restart frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " CODE 37 COMPLETE"
echo "======================================"

tail -20 ../frontend.log



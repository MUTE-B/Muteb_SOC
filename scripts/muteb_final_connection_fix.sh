#!/bin/bash

echo "=========================================="
echo " MUTEB SOC FINAL CONNECTION FIX "
echo "=========================================="


PROJECT=$(pwd)


echo "[1] Backup files"

cp web_dashboard/app.py web_dashboard/app.py.connection_backup
cp frontend/src/App.jsx frontend/src/App.jsx.connection_backup
cp frontend/vite.config.js frontend/vite.config.js.connection_backup 2>/dev/null || true



echo "[2] Fix Flask CORS"


python3 - <<'PY'

from pathlib import Path

p=Path("web_dashboard/app.py")

c=p.read_text()


if "flask_cors" not in c:

    c=c.replace(
        "from flask import Flask, jsonify, render_template, request",
        "from flask import Flask, jsonify, render_template, request\nfrom flask_cors import CORS"
    )


if "CORS(app)" not in c:

    c=c.replace(
        "app = Flask(__name__)",
        "app = Flask(__name__)\nCORS(app, resources={r'/*': {'origins':'*'}})"
    )


p.write_text(c)

PY



echo "[3] Create Vite Proxy"


cat > frontend/vite.config.js <<'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'


export default defineConfig({

plugins:[
react()
],

server:{

host:"0.0.0.0",

port:5173,


proxy:{

"/api":{

target:"http://172.20.10.4:5000",

changeOrigin:true

}

}

}

})
EOF




echo "[4] Fix React API"


python3 - <<'PY'

from pathlib import Path


p=Path("frontend/src/App.jsx")

c=p.read_text()


c=c.replace(
'const API="http://172.20.10.4:5000";',
'const API="";'
)


p.write_text(c)


PY



echo "[5] Stop services"


pkill -9 -f "app.py" || true
pkill -9 -f vite || true
pkill -9 -f node || true


sleep 3




echo "[6] Start Backend"


cd web_dashboard


nohup ../venv/bin/python3 app.py > ../backend.log 2>&1 &


cd ..



sleep 5



echo "[7] Start Frontend"


cd frontend


rm -rf node_modules/.vite


nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


cd ..


sleep 8




echo "[8] Testing Backend"


curl -s \
-X POST http://172.20.10.4:5000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"muteb123"}'


echo ""


echo "[9] Testing Frontend"


curl -I http://localhost:5173



echo ""
echo "=========================================="
echo " COMPLETE "
echo "=========================================="

echo ""
echo "OPEN:"
echo "http://localhost:5173"

echo ""
echo "LOGIN:"
echo "admin"
echo "muteb123"


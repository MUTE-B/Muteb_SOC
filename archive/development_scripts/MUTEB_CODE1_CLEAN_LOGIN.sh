#!/bin/bash

echo "======================================"
echo " MUTEB SOC CLEAN LOGIN FINAL"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup App.jsx"

cp frontend/src/App.jsx frontend/src/App.jsx.backup_clean_login



echo "[2] Remove duplicate login messages"


python3 - <<'PY'

from pathlib import Path

p=Path("frontend/src/App.jsx")

text=p.read_text()


# إزالة أي رسائل قديمة
text=text.replace(
'setMessage("Invalid Credentials");',
''
)

text=text.replace(
'setMessage("Backend Connection Failed");',
''
)


# استبدال أي رسالة مشابهة
text=text.replace(
'Invalid Credentials',
''
)

text=text.replace(
'Backend Connection Failed',
''
)


p.write_text(text)

print("Old login messages removed")

PY



echo "[3] Create clean auth handler"


cat > frontend/src/api/auth.js <<'JS'

import client from "./client";


export async function login(username,password){

    const response = await client.post(
        "/api/login",
        {
            username,
            password
        }
    );


    return response.data;

}

JS



echo "[4] Fix API client"


cat > frontend/src/api/client.js <<'JS'

import axios from "axios";


const client = axios.create({

    baseURL:
    "http://172.20.10.4:8000",

    headers:{
        "Content-Type":"application/json"
    }

});


export default client;

JS



echo "[5] Restart Frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " LOGIN CLEAN COMPLETE"
echo "======================================"

echo "Try:"
echo "admin"
echo "Muteb@123"


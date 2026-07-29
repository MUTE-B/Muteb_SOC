#!/bin/bash

echo "======================================"
echo " MUTEB SOC DASHBOARD UI BUILD"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup App.jsx"

cp frontend/src/App.jsx \
frontend/src/App.jsx.before_dashboard.$(date +%s)



echo "[2] Create Dashboard CSS"


cat > frontend/src/App.css <<'CSS'

body{

    margin:0;
    font-family:Arial, sans-serif;
    background:#050b14;
    color:white;

}


.login-container{

    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;

}


.card{

    background:#0d1626;
    width:90%;
    max-width:1100px;
    padding:30px;
    border-radius:15px;
    box-shadow:0 0 25px #000;

}


.title{

    color:#00e5ff;
    text-align:center;

}


.grid{

    display:grid;
    grid-template-columns:
    repeat(auto-fit,minmax(220px,1fr));

    gap:20px;

}


.box{

    background:#111f35;
    padding:20px;
    border-radius:12px;
    border-left:4px solid #00e5ff;

}


.alert{

    border-left-color:red;

}


.status{

    color:#00ff88;
    font-size:22px;

}


button{

    background:#00e5ff;
    border:none;
    padding:12px;
    width:100%;
    cursor:pointer;
    border-radius:8px;

}

input{

    display:block;
    width:90%;
    margin:10px auto;
    padding:12px;
    border-radius:8px;

}

CSS



echo "[3] Restart Frontend"

pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " DASHBOARD UI READY"
echo "======================================"

tail -20 ../frontend.log


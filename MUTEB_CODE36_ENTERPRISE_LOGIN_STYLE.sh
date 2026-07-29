#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE LOGIN DESIGN"
echo " CODE 36"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup CSS"

mkdir -p frontend/UI_BACKUP_CODE36

cp frontend/src/App.css frontend/UI_BACKUP_CODE36/App.css.backup



echo "[2] Applying enterprise login styling"


cat >> frontend/src/App.css <<'EOF'


/* ===================================
   MUTEB SOC ENTERPRISE LOGIN
=================================== */


.login-page{

background:

radial-gradient(
circle at top,
#12304a,
#020617 70%
);

}



.login-card{

position:relative;

overflow:hidden;

}



.login-card::before{

content:"";

position:absolute;

top:0;

left:0;

width:100%;

height:5px;

background:#38bdf8;

}



.login-card h1{

letter-spacing:3px;

}



.login-card h3{

margin-bottom:35px;

}



.login-card p{

color:#f87171;

min-height:20px;

}



.login-card input:focus{

outline:none;

border-color:#38bdf8;

box-shadow:
0 0 10px rgba(56,189,248,.3);

}



.login-card button{

transition:.3s;

}



.login-card button:hover{

background:#0369a1;

transform:translateY(-2px);

}



EOF



echo "[3] Restart frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5



echo ""
echo "======================================"
echo " LOGIN DESIGN COMPLETE"
echo "======================================"

tail -20 ../frontend.log



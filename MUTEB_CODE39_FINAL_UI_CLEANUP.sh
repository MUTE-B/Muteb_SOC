#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL UI CLEANUP"
echo " CODE 39"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup"

mkdir -p frontend/UI_BACKUP_CODE39

cp frontend/src/App.css frontend/UI_BACKUP_CODE39/App.css.backup



echo "[2] Applying final enterprise styling"


cat >> frontend/src/App.css <<'EOF'


/* ===================================
   MUTEB SOC FINAL ENTERPRISE POLISH
=================================== */


body{

font-family:

"Inter",
"Segoe UI",
Arial,
sans-serif;

}


.soc-layout{

display:flex;

background:#020617;

}



.sidebar{

position:sticky;

top:0;

height:100vh;

}



.sidebar div{

cursor:pointer;

transition:.25s;

}



.sidebar div:hover{

transform:translateX(5px);

}



.content{

max-width:1400px;

width:100%;

margin:auto;

}



.topbar{

box-shadow:

0 10px 30px rgba(0,0,0,.25);

}



.overview{

align-items:stretch;

}



.box{

transition:.25s;

}



.box:hover{

transform:translateY(-5px);

border-color:#38bdf8;

}



.panel{

box-shadow:

0 10px 25px rgba(0,0,0,.2);

}



table{

overflow:hidden;

}



@media(max-width:768px){


.login-card{

width:90%;

padding:30px;

}


.overview{

grid-template-columns:1fr;

}


.content{

padding:20px;

}


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
echo " CODE 39 COMPLETE"
echo "======================================"

tail -20 ../frontend.log



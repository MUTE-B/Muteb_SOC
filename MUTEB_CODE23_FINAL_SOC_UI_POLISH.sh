#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL UI POLISH"
echo " CODE 23"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup"

mkdir -p frontend/UI_BACKUP_CODE23

cp frontend/src/App.jsx frontend/UI_BACKUP_CODE23/App.jsx.backup
cp frontend/src/App.css frontend/UI_BACKUP_CODE23/App.css.backup



echo "[2] Updating Enterprise UI"


cat > frontend/src/App.css <<'EOF'

*{
box-sizing:border-box;
}


body{

margin:0;
font-family:
"Segoe UI",
Arial,
sans-serif;

background:
linear-gradient(
135deg,
#050816,
#0b1220
);

color:#f8fafc;

}


.login-page{

min-height:100vh;

display:flex;

justify-content:center;

align-items:center;

}



.login-card{

width:430px;

background:#111827;

padding:45px;

border-radius:20px;

border:1px solid #1e3a5f;

box-shadow:
0 20px 50px rgba(0,0,0,.5);

text-align:center;

}


.login-card h1{

font-size:45px;

margin-bottom:5px;

color:#38bdf8;

}


.login-card h3{

font-weight:normal;

color:#94a3b8;

}



input{

width:100%;

padding:15px;

margin:12px 0;

background:#020617;

border:1px solid #334155;

border-radius:10px;

color:white;

}



button{

width:100%;

padding:15px;

margin-top:15px;

background:#0284c7;

border:none;

border-radius:10px;

color:white;

font-weight:bold;

cursor:pointer;

}



.soc-layout{

display:flex;

min-height:100vh;

}



.sidebar{

width:250px;

background:#020617;

padding:30px;

border-right:1px solid #1e293b;

}



.sidebar h2{

color:#38bdf8;

}



.sidebar div{

padding:15px;

margin:5px 0;

border-radius:8px;

color:#cbd5e1;

}



.sidebar div:hover{

background:#1e293b;

}



.content{

flex:1;

padding:35px;

}



.topbar{

background:#111827;

padding:25px;

border-radius:18px;

display:flex;

justify-content:space-between;

align-items:center;

}



.status{

padding:10px 18px;

background:#052e16;

color:#4ade80;

border-radius:20px;

}



.overview{

display:grid;

grid-template-columns:
repeat(auto-fit,minmax(220px,1fr));

gap:25px;

margin-top:30px;

}



.box{

background:#111827;

padding:30px;

border-radius:18px;

border:1px solid #1e293b;

}



.box h3{

color:#94a3b8;

}



.box strong{

font-size:35px;

color:#38bdf8;

}



.panel{

margin-top:30px;

background:#111827;

padding:30px;

border-radius:18px;

border:1px solid #1e293b;

}



table{

width:100%;

border-collapse:collapse;

}



th{

color:#38bdf8;

}


td,th{

padding:15px;

border-bottom:1px solid #1e293b;

}



li{

padding:12px;

color:#cbd5e1;

}



@media(max-width:900px){

.sidebar{

display:none;

}

.content{

padding:15px;

}


.topbar{

flex-direction:column;

gap:15px;

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
echo " CODE 23 FINISHED"
echo "======================================"

tail -20 ../frontend.log



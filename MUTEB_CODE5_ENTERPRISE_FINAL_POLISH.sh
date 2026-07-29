#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE FINAL POLISH"
echo " CODE 5"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup CSS"

cp frontend/src/styles/enterprise.css \
frontend/src/styles/enterprise.css.backup 2>/dev/null || true



echo "[2] Replace Enterprise CSS"



cat > frontend/src/styles/enterprise.css <<'CSS'


:root{

--bg:#070b14;

--panel:#111827;

--panel-light:#172033;

--border:#273449;

--primary:#2563eb;

--text:#f8fafc;

--muted:#94a3b8;

--danger:#ef4444;

--warning:#f59e0b;

--success:#22c55e;

}



*{

box-sizing:border-box;

}



body{

margin:0;

background:var(--bg);

color:var(--text);

font-family:

"Segoe UI",
Arial,
sans-serif;

}



h1,h2,h3{

font-weight:600;

}



.layout{

display:flex;

min-height:100vh;

}



.sidebar{

width:270px;

background:#050914;

border-right:1px solid var(--border);

padding:30px 20px;

}



.logo{

font-size:28px;

font-weight:800;

color:#60a5fa;

letter-spacing:1px;

}



.subtitle{

color:var(--muted);

margin-top:8px;

}



.menu{

margin-top:40px;

}



.menu div{

padding:15px;

margin-bottom:8px;

border-radius:8px;

color:#cbd5e1;

transition:.2s;

}



.menu div:hover{

background:#1e293b;

color:white;

}



.main{

flex:1;

padding:35px;

}



.header{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:30px;

}



.header span{

color:#60a5fa;

}



.card{

background:
linear-gradient(
145deg,
var(--panel),
var(--panel-light)
);

border:

1px solid var(--border);

border-radius:16px;

padding:25px;

box-shadow:

0 10px 25px rgba(0,0,0,.25);

}



.grid{

display:grid;

grid-template-columns:

repeat(auto-fit,minmax(220px,1fr));

gap:25px;

}



.stat{

font-size:36px;

font-weight:800;

margin-top:15px;

}



.success{

color:var(--success);

}



.critical{

color:var(--danger);

}



.medium{

color:var(--warning);

}



table{

width:100%;

border-collapse:collapse;

}



th{

color:#94a3b8;

font-weight:500;

}



td,th{

padding:16px;

border-bottom:

1px solid var(--border);

}



.login{

height:100vh;

display:flex;

align-items:center;

justify-content:center;

background:

radial-gradient(

circle at top,

#1e3a8a,

var(--bg)

);

}



.login-box{

width:420px;

text-align:center;

}



.login-box h1{

font-size:42px;

color:#60a5fa;

}



input{

width:100%;

padding:15px;

margin:10px 0;

background:#020617;

border:

1px solid var(--border);

border-radius:10px;

color:white;

font-size:16px;

}



.primary-btn{

width:100%;

padding:15px;

margin-top:15px;

background:var(--primary);

color:white;

font-size:16px;

font-weight:600;

border-radius:10px;

}



.primary-btn:hover{

opacity:.85;

}



.logout{

margin-top:50px;

padding:14px;

width:100%;

background:#dc2626;

color:white;

border-radius:10px;

font-weight:bold;

}



@media(max-width:900px){


.sidebar{

width:200px;

}


.main{

padding:20px;

}


}



CSS



echo "======================================"
echo " CODE 5 COMPLETE"
echo "======================================"

echo "Frontend design finalized"
echo "No restart performed"


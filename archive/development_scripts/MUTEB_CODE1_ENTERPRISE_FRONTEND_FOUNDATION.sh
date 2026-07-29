#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE FRONTEND BUILD "
echo " CODE 1 FOUNDATION"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup frontend"

mkdir -p frontend/MUTEB_UI_BACKUP

cp -r frontend/src frontend/MUTEB_UI_BACKUP/ 2>/dev/null || true


echo "[2] Create structure"

mkdir -p frontend/src/components
mkdir -p frontend/src/pages
mkdir -p frontend/src/styles


echo "[3] Create Enterprise CSS"


cat > frontend/src/styles/enterprise.css <<'CSS'

:root{

--bg:#080f1c;
--panel:#111827;
--border:#243244;

--primary:#2563eb;
--danger:#dc2626;
--warning:#f59e0b;
--success:#16a34a;

--text:#f8fafc;
--muted:#94a3b8;

}


*{

box-sizing:border-box;

}


body{

margin:0;
font-family:
"Segoe UI",
Arial,
sans-serif;

background:var(--bg);

color:var(--text);

}


button{

cursor:pointer;

border:none;

}


.card{

background:var(--panel);

border:1px solid var(--border);

border-radius:12px;

padding:20px;

}


.layout{

display:flex;

min-height:100vh;

}


.sidebar{

width:260px;

background:#050b16;

border-right:1px solid var(--border);

padding:25px;

}


.logo{

font-size:24px;

font-weight:bold;

color:#60a5fa;

}


.menu{

margin-top:40px;

}


.menu div{

padding:14px;

color:var(--muted);

}


.menu div:hover{

background:#1e293b;

color:white;

}


.main{

flex:1;

padding:30px;

}


.header{

display:flex;

justify-content:space-between;

padding-bottom:20px;

border-bottom:1px solid var(--border);

}


.grid{

display:grid;

grid-template-columns:
repeat(4,1fr);

gap:20px;

margin-top:25px;

}


.stat{

font-size:32px;

font-weight:bold;

margin-top:10px;

}


.login{

height:100vh;

display:flex;

justify-content:center;

align-items:center;

}


.login-box{

width:400px;

}


input{

width:100%;

padding:14px;

margin:10px 0;

background:#020617;

border:1px solid var(--border);

color:white;

border-radius:8px;

}


.primary-btn{

width:100%;

padding:14px;

background:var(--primary);

color:white;

border-radius:8px;

}


table{

width:100%;

border-collapse:collapse;

}


td,th{

padding:14px;

border-bottom:1px solid var(--border);

text-align:left;

}


.critical{

color:#f87171;

}


.medium{

color:#fbbf24;

}


.success{

color:#4ade80;

}

CSS



echo "[4] Create Sidebar"


cat > frontend/src/components/Sidebar.jsx <<'JS'

export default function Sidebar(){

return (

<div className="sidebar">

<div className="logo">
MUTEB SOC
</div>


<div className="menu">

<div>Dashboard</div>

<div>Alerts</div>

<div>Incidents</div>

<div>Threat Intelligence</div>

<div>Reports</div>


</div>


</div>

)

}

JS



echo "[5] Create Dashboard"


cat > frontend/src/pages/Dashboard.jsx <<'JS'

export default function Dashboard(){


return (

<>

<div className="header">

<h2>
SOC Dashboard
</h2>

<span>
System Status: ONLINE
</span>


</div>



<div className="grid">


<div className="card">

Alerts

<div className="stat">
3
</div>

</div>



<div className="card">

Incidents

<div className="stat">
5
</div>

</div>



<div className="card">

Events

<div className="stat">
12450
</div>

</div>



<div className="card">

Threat Level

<div className="stat success">
LOW
</div>

</div>


</div>


</>

)

}

JS



echo "[6] Create Alerts"


cat > frontend/src/pages/Alerts.jsx <<'JS'

export default function Alerts(){

return (

<div className="card">

<h2>
Security Alerts
</h2>


<table>

<thead>

<tr>

<th>Severity</th>

<th>Source</th>

<th>Status</th>

</tr>

</thead>


<tbody>

<tr>

<td className="critical">
Critical
</td>

<td>
Firewall
</td>

<td>
Investigating
</td>

</tr>


<tr>

<td className="medium">
Medium
</td>

<td>
Login
</td>

<td>
Monitoring
</td>

</tr>


</tbody>


</table>


</div>


)

}

JS



echo "[7] Create App Shell"


cat > frontend/src/App.jsx <<'JS'

import Dashboard from "./pages/Dashboard";
import Alerts from "./pages/Alerts";
import Sidebar from "./components/Sidebar";
import "./styles/enterprise.css";


function App(){


return (

<div className="layout">


<Sidebar/>


<div className="main">


<Dashboard/>


<br/>


<Alerts/>


</div>


</div>

)


}


export default App;

JS



echo "======================================"
echo " CODE 1 COMPLETE"
echo "======================================"

echo "No services restarted"
echo "Run test after all packages finish"


#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE DASHBOARD"
echo " CODE 22"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup current UI"

mkdir -p frontend/UI_BACKUP_CODE22

cp frontend/src/App.jsx frontend/UI_BACKUP_CODE22/App.jsx.backup
cp frontend/src/App.css frontend/UI_BACKUP_CODE22/App.css.backup


echo "[2] Building Enterprise Dashboard"


cat > frontend/src/App.jsx <<'EOF'
import {useState} from "react";
import "./App.css";


const API =
import.meta.env.VITE_API_URL ||
"http://172.20.10.4:8000";


function App(){


const [username,setUsername]=useState("");
const [password,setPassword]=useState("");
const [user,setUser]=useState(null);
const [message,setMessage]=useState("");



async function login(){

try{


const response = await fetch(
`${API}/api/login`,
{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({
username,
password
})
});


const result = await response.json();


if(result.success){

setUser(result.user);
setMessage("");

}

else{

setMessage("Invalid Login");

}


}

catch{

setMessage("Backend Connection Failed");

}

}



if(!user){


return (

<div className="login-page">


<div className="login-card">


<h1>
MUTEB SOC
</h1>


<h3>
Enterprise Security Operations Center
</h3>


<input
placeholder="Username"
value={username}
onChange={
e=>setUsername(e.target.value)
}
/>


<input
type="password"
placeholder="Password"
value={password}
onChange={
e=>setPassword(e.target.value)
}
/>


<button onClick={login}>
Secure Login
</button>


<p>
{message}
</p>


</div>


</div>

);


}



return (


<div className="soc-layout">



<aside className="sidebar">


<h2>
MUTEB SOC
</h2>


<nav>

<div>
Dashboard
</div>

<div>
Alerts
</div>

<div>
Events
</div>

<div>
Reports
</div>

<div>
Settings
</div>


</nav>


</aside>



<main className="content">



<header className="topbar">


<div>

<h1>
SOC Analyst Dashboard
</h1>

<p>
Welcome {user.username}
</p>

</div>


<div className="status">

SYSTEM ONLINE

</div>


</header>





<section className="overview">



<div className="box">

<h3>
Security Status
</h3>

<strong>
ONLINE
</strong>

</div>



<div className="box">

<h3>
Active Alerts
</h3>

<strong>
12
</strong>

</div>



<div className="box">

<h3>
Events Today
</h3>

<strong>
245
</strong>

</div>



<div className="box">

<h3>
Threat Level
</h3>

<strong>
LOW
</strong>

</div>



</section>





<section className="panel">


<h2>
Security Alerts
</h2>


<table>


<thead>

<tr>

<th>
Severity
</th>

<th>
Source
</th>

<th>
Status
</th>

</tr>


</thead>


<tbody>


<tr>

<td>
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

<td>
High
</td>

<td>
Authentication
</td>

<td>
Monitoring
</td>

</tr>


<tr>

<td>
Medium
</td>

<td>
Network
</td>

<td>
Resolved
</td>

</tr>


</tbody>


</table>



</section>




<section className="panel">


<h2>
Recent Activity
</h2>


<ul>

<li>
Linux Authentication Log Analysis
</li>


<li>
Threat Detection Rule Executed
</li>


<li>
Security Report Generated
</li>


</ul>


</section>



</main>



</div>


);


}


export default App;
EOF





cat > frontend/src/App.css <<'EOF'

*{
box-sizing:border-box;
}


body{

margin:0;

font-family:
Arial,Helvetica,sans-serif;

background:#050b16;

color:white;

}



.login-page{

height:100vh;

display:flex;

justify-content:center;

align-items:center;

}



.login-card{

width:420px;

background:#101827;

padding:40px;

border-radius:16px;

text-align:center;

box-shadow:
0 0 35px rgba(0,150,255,.25);

}



.login-card h1{

color:#00aaff;

font-size:42px;

}



input{

width:100%;

padding:15px;

margin:10px 0;

background:#050b16;

border:1px solid #334155;

border-radius:8px;

color:white;

}



button{

width:100%;

padding:15px;

background:#007bff;

border:0;

border-radius:8px;

color:white;

font-size:16px;

}



.soc-layout{

display:flex;

min-height:100vh;

}



.sidebar{

width:240px;

background:#0b1220;

padding:30px;

}



.sidebar h2{

color:#00aaff;

}



.sidebar div{

padding:15px 0;

color:#cbd5e1;

}



.content{

flex:1;

padding:30px;

}



.topbar{

display:flex;

justify-content:space-between;

background:#101827;

padding:25px;

border-radius:15px;

}



.status{

color:#00ff99;

font-weight:bold;

}



.overview{

display:grid;

grid-template-columns:
repeat(auto-fit,minmax(200px,1fr));

gap:20px;

margin-top:25px;

}



.box{

background:#101827;

padding:25px;

border-radius:15px;

border-left:4px solid #0099ff;

}



.box strong{

font-size:32px;

color:#00ff99;

}



.panel{

background:#101827;

padding:25px;

margin-top:25px;

border-radius:15px;

}



table{

width:100%;

border-collapse:collapse;

}



th,td{

padding:15px;

border-bottom:1px solid #334155;

text-align:left;

}



li{

padding:10px;

color:#cbd5e1;

}



@media(max-width:800px){

.sidebar{

display:none;

}

.content{

padding:15px;

}

}


EOF




echo "[3] Restart Frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5



echo ""
echo "======================================"
echo " CODE 22 COMPLETE"
echo "======================================"

tail -20 ../frontend.log


#!/bin/bash

echo "======================================"
echo " MUTEB SOC CODE 2 ENTERPRISE LAYOUT"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup"

cp frontend/src/App.jsx frontend/src/App.jsx.code1_backup
cp frontend/src/App.css frontend/src/App.css.code1_backup



echo "[2] Creating Enterprise Dashboard"



cat > frontend/src/App.jsx <<'JS'

import {useState} from "react";
import "./App.css";
import {login} from "./api/auth";



function App(){


const [username,setUsername]=useState("");

const [password,setPassword]=useState("");

const [user,setUser]=useState(null);

const [message,setMessage]=useState("");




async function handleLogin(){


try{


const result =
await login(username,password);



if(result.success){


setUser(result.user);


}
else{


setMessage("Invalid Credentials");


}


}

catch(e){

setMessage(
"Backend Connection Failed"
);


}


}




if(!user){


return(


<div className="login">


<div className="login-box">


<h1>
🛡 MUTEB SOC
</h1>


<h3>
Security Operations Center
</h3>


<input

placeholder="Username"

onChange={
e=>setUsername(e.target.value)
}

/>


<input

type="password"

placeholder="Password"

onChange={
e=>setPassword(e.target.value)
}

/>


<button onClick={handleLogin}>

LOGIN

</button>


<p>{message}</p>


</div>


</div>


);


}





return(


<div className="soc-layout">



<aside className="sidebar">


<h2>
🛡 MUTEB SOC
</h2>



<div className="menu active">
Dashboard
</div>


<div className="menu">
Alerts
</div>


<div className="menu">
Incidents
</div>


<div className="menu">
Assets
</div>


<div className="menu">
Threat Hunting
</div>


<div className="menu">
Reports
</div>



</aside>





<main className="content">



<header className="topbar">


<h1>
SOC Dashboard
</h1>


<div>

User:
<b>
{user.username}
</b>

</div>


</header>






<section className="stats">


<div className="stat">


<h3>
Critical Alerts
</h3>

<p className="danger">
12
</p>


</div>





<div className="stat">


<h3>
Open Incidents
</h3>


<p>
5
</p>


</div>





<div className="stat">


<h3>
Monitored Assets
</h3>


<p>
248
</p>


</div>




<div className="stat">


<h3>
System
</h3>


<p className="online">
ONLINE
</p>


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

<td className="danger">
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

<td className="warning">
High
</td>

<td>
Endpoint
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
Email Gateway
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
Threat Intelligence
</h2>


<div className="threat-box">


<div>
Malware Detection
<span>
ACTIVE
</span>
</div>


<div>
IOC Monitoring
<span>
ACTIVE
</span>
</div>


<div>
Log Analysis
<span>
RUNNING
</span>
</div>


</div>


</section>





</main>


</div>


);


}



export default App;

JS





echo "[3] Updating CSS"



cat >> frontend/src/App.css <<'CSS'



.soc-layout{


display:flex;

min-height:100vh;


}



.sidebar{


width:260px;


background:#020617;


padding:25px;


box-shadow:
5px 0 20px #000;


}



.sidebar h2{


color:#38bdf8;


margin-bottom:40px;


}



.menu{


padding:15px;

margin:10px 0;

background:#0f172a;


border-radius:10px;


cursor:pointer;


}



.menu:hover,
.menu.active{


background:#2563eb;


}





.content{


flex:1;

padding:30px;


}



.topbar{


display:flex;

justify-content:space-between;


background:#0f172a;


padding:20px;


border-radius:15px;


}





.stats{


display:grid;


grid-template-columns:
repeat(4,1fr);


gap:20px;


margin-top:25px;


}



.stat{


background:#0f172a;

padding:25px;

border-radius:15px;


text-align:center;


}



.stat p{


font-size:35px;

font-weight:bold;


}




.danger{

color:#ef4444;


}


.warning{

color:#f59e0b;


}



.panel{


background:#0f172a;

margin-top:25px;

padding:25px;

border-radius:15px;


}



table{


width:100%;

border-collapse:collapse;


}



td,th{


padding:15px;

border-bottom:1px solid #334155;


}



.threat-box div{


display:flex;

justify-content:space-between;


padding:15px;

background:#020617;

margin:10px;

border-radius:10px;


}



.threat-box span{


color:#22c55e;


}



@media(max-width:900px){


.sidebar{

display:none;

}



.stats{

grid-template-columns:1fr;

}


}



CSS




echo "[4] Restart Frontend"



pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &



sleep 5



echo "======================================"
echo " CODE 2 COMPLETED"
echo "======================================"

tail -20 ../frontend.log



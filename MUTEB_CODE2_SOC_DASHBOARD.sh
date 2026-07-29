#!/bin/bash

echo "======================================"
echo " MUTEB SOC CODE 2 DASHBOARD BUILD"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup App.jsx"

cp frontend/src/App.jsx frontend/src/App.jsx.before_dashboard.$(date +%s)


echo "[2] Build SOC Dashboard"


cat > frontend/src/App.jsx <<'JSX'

import { useState } from "react";
import "./App.css";


const API =
import.meta.env.VITE_API_URL ||
"http://172.20.10.4:8000";


function App(){


const [username,setUsername]=useState("");
const [password,setPassword]=useState("");
const [message,setMessage]=useState("");
const [user,setUser]=useState(null);



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
}
);


const data = await response.json();


if(data.success){

setUser(data.user);
setMessage("Login Successful");

}

else{

setMessage("Invalid Credentials");

}


}

catch(error){

console.log(error);

setMessage("Backend Connection Failed");

}

}




if(user){


return (

<div className="soc-dashboard">


<header>

<h1>
🛡️ MUTEB SOC
</h1>

<p>
Security Operations Center Dashboard
</p>

</header>



<div className="cards">


<div className="card online">

<h3>
System Status
</h3>

<p>
ONLINE
</p>

</div>



<div className="card">

<h3>
Threat Level
</h3>

<p>
LOW
</p>

</div>



<div className="card">

<h3>
Active Alerts
</h3>

<p>
3
</p>

</div>



<div className="card">

<h3>
Incidents
</h3>

<p>
1
</p>

</div>


</div>



<section className="panel">

<h2>
Security Events
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
<td>Critical</td>
<td>Firewall</td>
<td>Investigating</td>
</tr>


<tr>
<td>Medium</td>
<td>Endpoint</td>
<td>Monitoring</td>
</tr>


<tr>
<td>Low</td>
<td>User Activity</td>
<td>Closed</td>
</tr>


</tbody>

</table>


</section>



<footer>

Logged User:
{user.username}
|
Role:
{user.role}

</footer>



</div>


);


}



return (

<div className="login-container">


<h1>
MUTEB SOC
</h1>


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
Login
</button>


<p>
{message}
</p>


</div>

);


}


export default App;

JSX



echo "[3] Add Cyber Style"


cat >> frontend/src/App.css <<'CSS'


body{

margin:0;
font-family:Arial;
background:#050816;
color:white;

}



.login-container{

width:350px;
margin:120px auto;
padding:40px;
background:#111827;
border-radius:15px;
text-align:center;

}



input{

display:block;
width:90%;
margin:15px auto;
padding:12px;

}



button{

padding:12px 30px;
cursor:pointer;

}



.soc-dashboard{

padding:30px;

}



header{

border-bottom:1px solid #334155;
margin-bottom:30px;

}



.cards{

display:grid;
grid-template-columns:repeat(4,1fr);
gap:20px;

}



.card{

background:#111827;
padding:25px;
border-radius:15px;
text-align:center;

}



.online{

border:1px solid #22c55e;

}



.panel{

margin-top:40px;
background:#111827;
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


footer{

margin-top:40px;
opacity:.7;

}


CSS



echo "[4] Restart Frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " DASHBOARD READY"
echo "======================================"

tail -20 ../frontend.log



#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE UI APPLY"
echo " CODE 21 PART 2"
echo "======================================"

cd ~/Muteb-SOC || exit 1


cat > frontend/src/App.jsx <<'EOF'
import { useState } from "react";
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

const response = await fetch(`${API}/api/login`,
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



return (

<div className="app">


{
!user ?


<div className="login-box">

<h1>
MUTEB SOC
</h1>

<p>
Enterprise Security Operations Center
</p>


<input
placeholder="Username"
value={username}
onChange={e=>setUsername(e.target.value)}
/>


<input
type="password"
placeholder="Password"
value={password}
onChange={e=>setPassword(e.target.value)}
/>


<button onClick={login}>
Secure Login
</button>


<span>
{message}
</span>


</div>


:


<div className="dashboard">


<header>

<h1>
MUTEB SOC Dashboard
</h1>

<p>
Analyst: {user.username}
</p>

</header>



<div className="cards">


<div className="card">
<h3>
System Status
</h3>
<strong>
ONLINE
</strong>
</div>



<div className="card">
<h3>
Threat Level
</h3>
<strong>
LOW
</strong>
</div>



<div className="card">
<h3>
Alerts
</h3>
<strong>
12
</strong>
</div>



<div className="card">
<h3>
Events
</h3>
<strong>
245
</strong>
</div>


</div>



<section>

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
Medium
</td>

<td>
Authentication
</td>

<td>
Monitoring
</td>


</tr>


</tbody>


</table>


</section>



</div>


}


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
Arial, Helvetica, sans-serif;

background:
#050b18;

color:white;

}



.app{

min-height:100vh;

display:flex;

justify-content:center;

align-items:center;

}



.login-box{

width:400px;

background:#101827;

padding:40px;

border-radius:15px;

box-shadow:
0 0 30px rgba(0,150,255,.25);

text-align:center;

}



.login-box h1{

font-size:40px;

color:#00aaff;

}



.login-box p{

color:#aaa;

}



input{

width:100%;

padding:14px;

margin:10px 0;

background:#050b18;

border:1px solid #334155;

color:white;

border-radius:8px;

}



button{

width:100%;

padding:14px;

margin-top:15px;

background:#0077ff;

border:none;

border-radius:8px;

color:white;

font-size:16px;

cursor:pointer;

}



.dashboard{

width:95%;

padding:30px;

}



header{

background:#101827;

padding:20px;

border-radius:15px;

margin-bottom:25px;

}



.cards{

display:grid;

grid-template-columns:
repeat(auto-fit,minmax(200px,1fr));

gap:20px;

}



.card{

background:#101827;

padding:25px;

border-radius:15px;

border-left:4px solid #00aaff;

}



.card strong{

font-size:30px;

color:#00ff99;

}



section{

margin-top:30px;

background:#101827;

padding:25px;

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



@media(max-width:600px){

.dashboard{

width:100%;

padding:15px;

}


.login-box{

width:90%;

}

}


EOF



echo "[1] Restart frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " ENTERPRISE UI READY"
echo "======================================"

tail -20 ../frontend.log


#!/bin/bash

echo "======================================"
echo " MUTEB SOC PROFESSIONAL DASHBOARD UI"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup App.jsx"

cp frontend/src/App.jsx frontend/src/App.jsx.before_dashboard


echo "[2] Creating Professional App.jsx"


cat > frontend/src/App.jsx <<'JS'

import { useState } from "react";
import "./App.css";
import { login } from "./api/auth";


const API =
import.meta.env.VITE_API_URL ||
"http://172.20.10.4:8000";


function App(){


const [username,setUsername]=useState("");
const [password,setPassword]=useState("");

const [message,setMessage]=useState("");

const [user,setUser]=useState(null);



async function handleLogin(){


try{


const result = await login(
username,
password
);



if(result.success){


setUser(result.user);

setMessage("");


}

else{


setMessage("Invalid Credentials");


}



}

catch(error){


console.log(error);

setMessage(
"Backend Connection Failed"
);


}


}




if(user){


return (

<div className="dashboard">


<header>

<h1>
🛡 MUTEB SOC
</h1>

<p>
Security Operations Center
</p>

</header>



<div className="cards">


<div className="card">

<h3>
Active User
</h3>

<p>
{user.username}
</p>

</div>



<div className="card">

<h3>
Role
</h3>

<p>
{user.role}
</p>

</div>



<div className="card">

<h3>
System Status
</h3>

<p className="online">
ONLINE
</p>

</div>


</div>



<div className="panel">


<h2>
SOC Overview
</h2>


<div className="events">


<div>
Threat Monitoring
<span>
ACTIVE
</span>
</div>


<div>
Firewall Status
<span>
SECURE
</span>
</div>



<div>
SIEM Engine
<span>
RUNNING
</span>
</div>



<div>
Incident Response
<span>
READY
</span>
</div>


</div>


</div>



</div>


);


}





return (


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




<button

onClick={handleLogin}

>

LOGIN

</button>



<p>

{message}

</p>


</div>


</div>


);



}



export default App;

JS




echo "[3] Creating Professional CSS"



cat > frontend/src/App.css <<'CSS'


*{

box-sizing:border-box;

font-family:
Arial,
sans-serif;

}



body{

margin:0;

background:
#050b18;

color:white;

}



.login{


height:100vh;

display:flex;

align-items:center;

justify-content:center;

background:
linear-gradient(
135deg,
#020617,
#0f172a
);


}



.login-box{


width:380px;

padding:40px;

background:
rgba(15,23,42,.95);


border-radius:15px;

box-shadow:
0 0 30px #2563eb;


text-align:center;


}



.login-box h1{

color:#38bdf8;

font-size:38px;

}



input{


width:100%;

padding:14px;

margin:10px 0;


background:#020617;

border:

1px solid #334155;


color:white;


border-radius:8px;


}



button{


width:100%;

padding:14px;

margin-top:15px;


background:#2563eb;

color:white;


border:none;


border-radius:8px;


font-weight:bold;


cursor:pointer;


}



button:hover{


background:#1d4ed8;


}




.dashboard{


min-height:100vh;

padding:30px;


}



header{


background:#0f172a;

padding:25px;

border-radius:15px;


box-shadow:
0 0 20px #1e40af;


}



header h1{


color:#38bdf8;


}



.cards{


display:grid;


grid-template-columns:
repeat(
3,
1fr
);


gap:20px;


margin-top:30px;


}



.card{


background:#0f172a;

padding:25px;

border-radius:15px;


box-shadow:
0 0 15px #1e293b;


}



.online{


color:#22c55e;

font-weight:bold;


}




.panel{


margin-top:30px;


background:#0f172a;

padding:30px;

border-radius:15px;


}



.events div{


display:flex;

justify-content:space-between;


padding:15px;

margin:10px 0;


background:#020617;


border-radius:10px;


}



.events span{


color:#22c55e;


font-weight:bold;


}



@media(max-width:800px){


.cards{


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


echo ""
echo "======================================"
echo " MUTEB SOC DASHBOARD READY"
echo "======================================"

tail -20 ../frontend.log



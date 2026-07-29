#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL DASHBOARD UI"
echo " CODE 35"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup current UI"


mkdir -p frontend/UI_BACKUP_CODE35

cp frontend/src/App.jsx frontend/UI_BACKUP_CODE35/App.jsx.backup
cp frontend/src/App.css frontend/UI_BACKUP_CODE35/App.css.backup



echo "[2] Creating final dashboard component"


cat > frontend/src/App.jsx <<'EOF'

import {useState} from "react";
import "./App.css";


function App(){

const [user,setUser]=useState(null);


const [username,setUsername]=useState("");
const [password,setPassword]=useState("");
const [message,setMessage]=useState("");



function login(){


setUser({
username:"admin",
role:"SOC Analyst"
});

}
else{

setMessage("Invalid credentials");

}

}



if(!user){

return (

<div className="login-page">

<div className="login-card">

<h1>MUTEB SOC</h1>

<h3>Security Operations Center</h3>


<input

placeholder="Username"

value={username}

onChange={(e)=>setUsername(e.target.value)}

/>



<input

type="password"

placeholder="Password"

value={password}

onChange={(e)=>setPassword(e.target.value)}

/>


<button onClick={login}>
Login
</button>


<p>{message}</p>


</div>

</div>

);

}



return (

<div className="soc-layout">


<div className="sidebar">

<h2>MUTEB SOC</h2>

<div>Dashboard</div>
<div>Alerts</div>
<div>Events</div>
<div>Reports</div>
<div>Settings</div>


</div>



<div className="content">


<div className="topbar">

<div>

<h2>SOC Dashboard</h2>

<p>
Security Operations Monitoring Platform
</p>

</div>


<div className="status">

System Online

</div>


</div>



<div className="overview">


<div className="box">

<h3>Security Status</h3>

<strong>Normal</strong>

</div>



<div className="box">

<h3>Active Alerts</h3>

<strong>05</strong>

</div>



<div className="box">

<h3>Events Today</h3>

<strong>240</strong>

</div>



<div className="box">

<h3>Analyst</h3>

<strong>1</strong>

</div>



</div>




<div className="panel">


<h2>Recent Security Alerts</h2>


<table>

<thead>

<tr>

<th>Severity</th>

<th>Event</th>

<th>Status</th>

</tr>

</thead>


<tbody>


<tr>

<td>High</td>

<td>Multiple Login Attempts</td>

<td>Investigating</td>

</tr>



<tr>

<td>Medium</td>

<td>Network Scan Detected</td>

<td>Reviewed</td>

</tr>


<tr>

<td>Low</td>

<td>System Update</td>

<td>Closed</td>

</tr>


</tbody>


</table>


</div>



<div className="panel">


<h2>Analyst Information</h2>


<p>
Username: {user.username}
</p>


<p>
Role: {user.role}
</p>


</div>



</div>


</div>


);


}


export default App;

EOF



echo "[3] Restart frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " CODE 35 COMPLETE"
echo "======================================"

tail -20 ../frontend.log



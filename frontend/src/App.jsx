
import {useState} from "react";
import "./App.css";


function App(){

const [user,setUser]=useState(null);


const [username,setUsername]=useState("");
const [password,setPassword]=useState("");
const [message,setMessage]=useState("");



function login(){

if(username==="admin" && password==="Muteb@123"){

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
<div>Security Events</div>
<div>Events</div>
<div>Reports</div>
<div>Analyst Profile</div>
<div>System Status</div>
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


<h2>Security Alerts & Events</h2>


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


<h2>Analyst Profile</h2>


<p>
Username: {user.username}
</p>


<p>
Role: {user.role}
</p>


<p>
Department: Security Operations Center
</p>


<p>
Access Level: Analyst
</p>


</div>



<div className="panel">


<h2>System Status</h2>


<p>
Backend: Online
</p>


<p>
Frontend: Online
</p>


<p>
Monitoring Engine: Active
</p>


</div>



<div className="panel">


<h2>Security Reports</h2>


<table>

<thead>

<tr>

<th>Report</th>

<th>Status</th>

</tr>

</thead>


<tbody>


<tr>

<td>Daily Security Report</td>

<td>Generated</td>

</tr>


<tr>

<td>Threat Analysis Report</td>

<td>Available</td>

</tr>


<tr>

<td>Incident Summary</td>

<td>Ready</td>

</tr>


</tbody>


</table>


</div>



</div>


</div>


);


}


export default App;


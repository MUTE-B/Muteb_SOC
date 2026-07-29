
import {useEffect,useState} from "react";
import "./App.css";


function App(){

const [data,setData]=useState({});
const [page,setPage]=useState("dashboard");


useEffect(()=>{

fetch("/api/stats")
.then(r=>r.json())
.then(setData);

},[]);



return (

<div>

<h1>MUTEB SOC</h1>

<nav>

<button onClick={()=>setPage("dashboard")}>Dashboard</button>
<button onClick={()=>setPage("alerts")}>Alerts</button>
<button onClick={()=>setPage("incidents")}>Incidents</button>
<button onClick={()=>setPage("users")}>Users</button>
<button onClick={()=>setPage("logs")}>Logs</button>

</nav>


<h2>SOC Overview</h2>


{
page==="dashboard" &&

<div>

<h3>Critical Alerts : {data.alerts}</h3>

<h3>Open Incidents : {data.incidents}</h3>

<h3>Active Users : {data.users}</h3>

<h3>Threat Score : {data.threat_score}</h3>

</div>

}


{
page==="alerts" &&

<div>

<h2>Alerts Center</h2>

<table>

<tbody>

<tr>
<td>1</td>
<td>Brute Force Attack</td>
<td>Critical</td>
<td>Open</td>
</tr>

</tbody>

</table>

</div>

}



{
page==="incidents" &&

<div>

<h2>Incident Management</h2>

<p>Suspicious Login</p>
<p>Priority : High</p>
<p>Status : Investigating</p>

</div>

}



{
page==="users" &&

<div>

<h2>Users Management</h2>


<table>
<tbody>

<tr>
<td>admin</td>
<td>Admin</td>
<td><button>Change Role</button></td>
<td><button>Delete</button></td>
</tr>


<tr>
<td>analyst</td>
<td>Analyst</td>
<td><button>Change Role</button></td>
<td><button>Delete</button></td>
</tr>

</tbody>
</table>


</div>

}



{
page==="logs" &&

<div>

<h2>Logs Viewer</h2>

<p>Security Events</p>

</div>

}



</div>

);

}


export default App;


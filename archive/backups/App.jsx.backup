
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


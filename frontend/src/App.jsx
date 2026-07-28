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

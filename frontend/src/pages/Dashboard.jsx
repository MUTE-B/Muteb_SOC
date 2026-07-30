
import {useEffect,useState} from "react";
import {getDashboard} from "../services/api";


export default function Dashboard({user,logout}){


const [stats,setStats]=useState({});



useEffect(()=>{

getDashboard()
.then(setStats);

},[]);



return (

<div className="dashboard">


<header>

<h1>
MUTEB SOC Enterprise
</h1>


<p>
Security Operations Center
</p>


</header>



<section>


<div>
<h3>User</h3>
<p>{user.username}</p>
</div>


<div>
<h3>Role</h3>
<p>{user.role}</p>
</div>



<div>
<h3>Threat Score</h3>
<p>{stats.threat_score}</p>
</div>


<div>
<h3>Critical Alerts</h3>
<p>{stats.critical_alerts}</p>
</div>


<div>
<h3>Incidents</h3>
<p>{stats.open_incidents}</p>
</div>


</section>



<button onClick={logout}>
Logout
</button>



</div>

)

}


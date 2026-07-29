
import React,{useEffect,useState} from "react";
import axios from "axios";
import "../enterprise.css";


export default function EnterpriseDashboard(){


const [status,setStatus]=useState({});
const [events,setEvents]=useState([]);



useEffect(()=>{


axios.get("/api/enterprise/status")
.then(r=>setStatus(r.data))
.catch(()=>{});


setEvents([

{
id:1,
event:"Suspicious Login",
severity:"HIGH"
},

{
id:2,
event:"Malware Detection",
severity:"CRITICAL"
}

]);


},[]);



return (

<div style={{padding:"30px"}}>


<h1>
MUTEB SOC Command Center
</h1>


<div style={{
display:"grid",
gridTemplateColumns:"repeat(4,1fr)",
gap:"20px"
}}>


<div className="enterprise-card">
Critical Alerts
<h2 style={{color:"#FF3B30"}}>
12
</h2>
</div>


<div className="enterprise-card">
Threat Score
<h2 style={{color:"#00A8FF"}}>
85%
</h2>
</div>



<div className="enterprise-card">
System
<h2 style={{color:"#00D084"}}>
ONLINE
</h2>
</div>



<div className="enterprise-card">
Engine
<h2>
ACTIVE
</h2>
</div>


</div>



<h2>
Live Security Events
</h2>



<div className="enterprise-card">


{
events.map(e=>(

<p key={e.id}>

{e.event}

 -

<span style={{
color:e.severity==="CRITICAL"
?"#FF3B30"
:"#FFB020"
}}>

{e.severity}

</span>


</p>

))
}



</div>



</div>


)

}


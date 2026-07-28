import React,{useEffect,useState} from "react";
import {login} from "./api/auth";
import {get} from "./api/soc";


const C={
bg:"#020617",
panel:"#0f172a",
blue:"#38bdf8",
green:"#22c55e",
red:"#ef4444",
orange:"#f59e0b",
text:"#e2e8f0"
};


function Login({setUser}){

const [username,setUsername]=useState("");
const [password,setPassword]=useState("");

async function submit(){

const r=await login(username,password);

if(r.status==="success"){

localStorage.setItem("token",r.token);

setUser({
username:r.username,
role:r.role,
token:r.token
});

}

}


return (

<div style={pageCenter}>

<div style={box}>

<h1 style={{color:C.blue}}>
MUTEB SOC
</h1>

<p>
Enterprise Security Operations Center
</p>


<input
style={input}
placeholder="Username"
onChange={e=>setUsername(e.target.value)}
/>


<input
style={input}
type="password"
placeholder="Password"
onChange={e=>setPassword(e.target.value)}
/>


<button
style={button}
onClick={submit}
>
LOGIN
</button>


</div>

</div>

)

}




function Dashboard({user,logout}){

const [data,setData]=useState(null);


useEffect(()=>{

get(user.token)
.then(setData);

},[user.token]);



if(!data)
return <div style={page}>Loading SOC...</div>



return (

<div style={page}>


<aside style={side}>

<h2 style={{color:C.blue}}>
MUTEB SOC
</h2>

<p>Threat Monitoring</p>
<p>Alerts</p>
<p>Incidents</p>
<p>Reports</p>


<button onClick={logout}>
Logout
</button>


</aside>



<main style={main}>


<h1 style={{color:C.blue}}>
Security Operations Center
</h1>


<p>
Analyst: {user.username}
|
Role: {user.role}
|
ACTIVE
</p>



<section style={grid}>


<Card title="Security Score" value={data.security_score+"%"}/>

<Card title="Critical Alerts" value={data.critical_alerts}/>

<Card title="Blocked Threats" value={data.blocked_threats}/>

<Card title="Events Today" value={data.events_today}/>


</section>



<section style={columns}>


<div style={box}>

<h2>
Live Alerts
</h2>


{data.alerts.map(a=>(

<div key={a.id}
style={{
padding:"15px",
margin:"10px",
background:C.bg,
borderRadius:"10px"
}}
>

<b>{a.id}</b>

<br/>

{a.name}

<br/>

<span style={{
color:
a.level==="CRITICAL"
?C.red
:
a.level==="MEDIUM"
?C.orange
:C.green
}}>

{a.level}

</span>


</div>

))}


</div>



<div style={box}>

<h2>
System Health
</h2>

<p>
Backend : {data.system.backend}
</p>

<p>
Frontend : {data.system.frontend}
</p>

<p>
Database : {data.system.database}
</p>

<p>
Engine : {data.system.engine}
</p>


</div>


</section>


<footer>
MUTEB SOC Enterprise © 2026
</footer>


</main>


</div>

)

}




function Card({title,value}){

return (

<div style={box}>

<h3>{title}</h3>

<h1 style={{color:C.blue}}>
{value}
</h1>

</div>

)

}





export default function App(){

const [user,setUser]=useState(null);


return user ?

<Dashboard

user={user}

logout={()=>{

localStorage.clear();

setUser(null);

}}

/>

:

<Login setUser={setUser}/>


}



const page={

minHeight:"100vh",
background:C.bg,
color:C.text,
display:"flex",
fontFamily:"Arial"

};


const pageCenter={

height:"100vh",
background:C.bg,
display:"flex",
alignItems:"center",
justifyContent:"center",
color:C.text

};


const side={

width:"240px",
background:"#050b18",
padding:"25px"

};


const main={

flex:1,
padding:"30px"

};


const grid={

display:"grid",
gridTemplateColumns:"repeat(4,1fr)",
gap:"20px"

};


const columns={

display:"grid",
gridTemplateColumns:"2fr 1fr",
gap:"20px"

};


const box={

background:C.panel,
padding:"25px",
borderRadius:"18px"

};


const input={

display:"block",
padding:"12px",
margin:"15px",
width:"250px"

};


const button={

background:"#0284c7",
color:"white",
padding:"12px 35px",
border:"0",
borderRadius:"10px"

};


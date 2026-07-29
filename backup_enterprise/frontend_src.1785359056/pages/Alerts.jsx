import React,{useEffect,useState} from "react";
import api from "../services/api";


export default function Alerts(){

const [alerts,setAlerts]=useState([]);


function load(){

api.get("/api/alerts")
.then(r=>setAlerts(r.data));

}


useEffect(load,[]);



async function close(id){

await api.put(
"/api/alerts/"+id,
{
status:"Closed"
}
);

load();

}



return <div>

<h2>Security Alerts</h2>


{
alerts.map(a=>

<div key={a[0]}>

<h3>{a[1]}</h3>

Severity:
{a[2]}

<br/>

Status:
{a[3]}


<button onClick={()=>close(a[0])}>
Close Alert
</button>


</div>

)
}


</div>

}

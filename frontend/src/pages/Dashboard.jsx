import React,{useEffect,useState} from "react";
import api from "../services/api";


export default function Dashboard(){

const [d,setD]=useState({});

useEffect(()=>{

api.get("/api/dashboard")
.then(r=>setD(r.data))

},[])


return <div>

<h2>SOC Overview</h2>

<h3>Critical Alerts</h3>
{d.critical_alerts}

<h3>Open Incidents</h3>
{d.open_incidents}

<h3>Threat Score</h3>
{d.threat_score}

</div>

}


import React,{useEffect,useState} from "react";
import api from "../services/api";


export default function Incidents(){


const [data,setData]=useState([]);


useEffect(()=>{

api.get("/api/incidents")
.then(r=>setData(r.data))

},[]);



return (

<div>

<h1>Incident Management</h1>


{

data.map(i=>

<div key={i.id}>

{i.title}

<br/>

Priority:
{i.priority}

<br/>

Status:
{i.status}


</div>


)

}


</div>

)

}


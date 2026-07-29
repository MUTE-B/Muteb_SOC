
import React,{useEffect,useState} from "react";
import api from "../services/api";


export default function Alerts(){


const [data,setData]=useState([]);


useEffect(()=>{

api.get("/api/alerts")
.then(r=>setData(r.data))

},[]);



return (

<div>

<h1>Alerts</h1>

{

data.map(a=>

<div key={a.id}>

{a.severity} - {a.title}

</div>

)

}

</div>

)

}


import React,{useEffect,useState} from "react";
import api from "../services/api";


export default function Incidents(){

const [items,setItems]=useState([]);


function load(){

api.get("/api/incidents")
.then(r=>setItems(r.data));

}


useEffect(load,[]);



async function close(id){

await api.put(
"/api/incidents/"+id,
{
status:"Closed"
}
);

load();

}



return <div>

<h2>Incident Management</h2>


{
items.map(i=>

<div key={i[0]}>

<h3>
{i[1]}
</h3>

Priority:
{i[2]}

<br/>

Status:
{i[3]}


<button
onClick={()=>close(i[0])}>

Close Incident

</button>


</div>

)
}


</div>

}

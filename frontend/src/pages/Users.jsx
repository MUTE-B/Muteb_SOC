import React,{useEffect,useState} from "react";
import api from "../services/api";


export default function Users(){

const [users,setUsers]=useState([]);
const [form,setForm]=useState({
username:"",
password:"",
role:"Analyst"
});


function load(){

api.get("/api/users")
.then(r=>setUsers(r.data));

}


useEffect(load,[]);



async function add(){

await api.post("/api/users",form);

load();

}



async function remove(id){

await api.delete("/api/users/"+id);

load();

}



return <div>

<h2>User Management</h2>


<input placeholder="Username"
onChange={e=>setForm({...form,username:e.target.value})}/>


<input placeholder="Password"
onChange={e=>setForm({...form,password:e.target.value})}/>


<select
onChange={e=>setForm({...form,role:e.target.value})}>

<option>Admin</option>
<option>Analyst</option>
<option>Viewer</option>

</select>


<button onClick={add}>
Add User
</button>



<hr/>


{
users.map(u=>

<div key={u[0]}>

<b>{u[1]}</b>
-
{u[2]}

<button onClick={()=>remove(u[0])}>
Delete
</button>


</div>

)
}


</div>

}

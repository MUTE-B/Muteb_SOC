
import React,{useState} from "react";
import api from "../services/api";


export default function Login({onLogin}){


const [username,setUsername]=useState("");
const [password,setPassword]=useState("");


function submit(){

api.post("/api/login",{

username,
password

})
.then(res=>{

if(res.data.success){

localStorage.setItem(
"user",
JSON.stringify(res.data.user)
);

onLogin(res.data.user);

}

else alert("Login Failed");

})

}


return (

<div className="login">

<h1>MUTEB SOC</h1>

<h2>Enterprise Login</h2>


<input
placeholder="Username"
onChange={e=>setUsername(e.target.value)}
/>


<input

type="password"

placeholder="Password"

onChange={e=>setPassword(e.target.value)}
/>



<button onClick={submit}>

LOGIN

</button>


</div>

)

}


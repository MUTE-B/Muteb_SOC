
import React,{useState} from "react";

import "./Login.css";


export default function Login({onLogin}){


const [username,setUsername]=useState("");

const [password,setPassword]=useState("");

const [error,setError]=useState("");



async function submit(e){

e.preventDefault();


try{


const r=await fetch(

"/api/login",

{

method:"POST",

headers:{

"Content-Type":"application/json"

},

body:JSON.stringify({

username,

password

})

}

);


const data=await r.json();



if(data.success){

onLogin(data);

}

else{

setError("Invalid Credentials");

}


}

catch{

setError("Connection Error");

}


}



return (

<div className="login-background">


<div className="cyber-grid"></div>



<div className="login-card">


<h1>

MUTEB SOC

</h1>


<h2>

ENTERPRISE

</h2>


<p className="subtitle">

Secure Access Portal

</p>



<form onSubmit={submit}>


<input

placeholder="Username"

value={username}

onChange={
e=>setUsername(e.target.value)
}

/>



<input

type="password"

placeholder="Password"

value={password}

onChange={
e=>setPassword(e.target.value)
}

/>



<button>

LOGIN

</button>



</form>



{
error &&
<p className="error">

{error}

</p>
}



<div className="features">


SOC Monitoring

<br/>

Threat Intelligence

<br/>

Incident Response

<br/>

Cyber Assessment


</div>



</div>



</div>

)


}


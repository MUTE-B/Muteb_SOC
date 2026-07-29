#!/bin/bash

set -e


cd frontend


cp src/pages/Login.jsx src/pages/Login.jsx.backup


cat > src/pages/Login.jsx <<'JS'

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

JS




cat > src/pages/Login.css <<'CSS'


.login-background{


height:100vh;

display:flex;

justify-content:center;

align-items:center;

background:

radial-gradient(
circle at top,
#123c66,
#020611 70%
);

overflow:hidden;

position:relative;


}



.cyber-grid{


position:absolute;

inset:0;

background-image:

linear-gradient(
rgba(0,170,255,.08) 1px,
transparent 1px
),

linear-gradient(
90deg,
rgba(0,170,255,.08) 1px,
transparent 1px
);


background-size:40px 40px;

animation:gridmove 20s linear infinite;


}



@keyframes gridmove{


from{

transform:translateY(0);

}


to{

transform:translateY(40px);

}


}




.login-card{


position:relative;

width:420px;

padding:45px;

background:

rgba(5,15,35,.92);


border:

1px solid #00a8ff;


border-radius:18px;


box-shadow:

0 0 40px rgba(0,168,255,.35);



text-align:center;


}



.login-card h1{


color:#00a8ff;

font-size:42px;

margin:0;


}



.login-card h2{


color:white;

letter-spacing:6px;


}



.subtitle{


color:#9db8d8;

margin-bottom:30px;


}




.login-card input{


width:100%;

padding:15px;

margin:10px 0;

background:#020817;

border:1px solid #164b75;

color:white;

border-radius:8px;


}




.login-card button{


width:100%;

padding:15px;

margin-top:20px;


background:#00a8ff;

border:0;

color:white;

font-size:18px;

font-weight:bold;

border-radius:8px;


}



.login-card button:hover{


background:#0080c8;


}




.features{


margin-top:30px;

color:#7fa8d0;

line-height:2;


}



.error{


color:#ff5555;


}



CSS




npm run build


sudo systemctl restart nginx



echo "MUTEB SOC ENTERPRISE LOGIN DESIGN READY"



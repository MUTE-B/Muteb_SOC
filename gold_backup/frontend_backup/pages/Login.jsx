import { useState } from "react";


export default function Login({onLogin}) {

const [username,setUsername] = useState("");
const [password,setPassword] = useState("");
const [error,setError] = useState("");
const [loading,setLoading] = useState(false);



async function submit(){

setLoading(true);
setError("");

try{


const response = await fetch("/api/login",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

username,
password

})

});



const data = await response.json();



if(data.success){

onLogin(data);

}

else{

setError("Invalid Username or Password");

}


}

catch(error){

setError("Backend Connection Error");

}


setLoading(false);


}



return (

<div className="login">


<h1>MUTEB SOC</h1>

<h2>Enterprise Login</h2>



<input

placeholder="Username"

value={username}

onChange={(e)=>setUsername(e.target.value)}

/>



<input

type="password"

placeholder="Password"

value={password}

onChange={(e)=>setPassword(e.target.value)}

/>



<button onClick={submit}>

{

loading ?

"LOGIN..."

:

"LOGIN"

}

</button>



<p>

{error}

</p>



</div>

);


}

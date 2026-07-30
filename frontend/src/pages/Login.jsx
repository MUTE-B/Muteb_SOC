import {useState} from "react";
import {login} from "../services/api";

export default function Login({onLogin}){

const [username,setUsername]=useState("");
const [password,setPassword]=useState("");
const [error,setError]=useState("");

async function submit(e){

e.preventDefault();

try{

const result = await login(username,password);

console.log(
"MUTEB AUTH RESULT:",
result
);


if(result.success){

localStorage.removeItem("muteb_user"); localStorage.removeItem("token");


localStorage.setItem(
"muteb_user",
JSON.stringify({
username:result.username,
role:result.role,
token:result.token
})
);


localStorage.setItem(
"token",
result.token
);


onLogin({
username:result.username,
role:result.role,
token:result.token
});


}else{

setError("Login Failed");

}


}catch(err){

console.error(err);
setError("Backend connection failed");

}

}


return (

<div className="login">

<h1>
MUTEB SOC
</h1>

<h2>
Enterprise Login
</h2>


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
<p>{error}</p>
}


</div>

)

}

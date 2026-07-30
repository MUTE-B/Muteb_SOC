import {useState} from "react";
import Login from "./pages/Login";
import {dashboard} from "./services/api";


export default function App(){

const [user,setUser]=useState(
()=>{
const saved=localStorage.getItem("muteb_user");
return saved ? JSON.parse(saved):null;
}
);


const [data,setData]=useState(null);


async function handleLogin(u){

localStorage.setItem(
"muteb_user",
JSON.stringify(u)
);

setUser(u);

try{

const result =
await dashboard(u.token);

setData(result);

}catch(e){

console.log(e);

}

}



function logout(){

localStorage.removeItem(
"muteb_user"
);

setUser(null);
setData(null);

}



if(!user){

return (
<Login
onLogin={handleLogin}
/>
);

}



return (

<div style={{
background:"#020617",
color:"white",
minHeight:"100vh",
padding:"40px",
fontFamily:"Arial"
}}>

<h1>
MUTEB SOC Enterprise
</h1>


<h2>
Security Operations Center Dashboard
</h2>


<p>
User:
<b>{user.username}</b>
</p>


<p>
Role:
<b>{user.role}</b>
</p>


{

data &&

<div>

<hr/>

<h3>
System Status
</h3>

<p>
Active Users:
{data.active_users}
</p>

<p>
Threat Score:
{data.threat_score}
</p>

</div>

}



<button
onClick={logout}
style={{
marginTop:30,
padding:10
}}
>
Logout
</button>


</div>

)

}

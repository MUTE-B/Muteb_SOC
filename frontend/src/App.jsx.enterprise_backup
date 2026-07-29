
import React,{useState} from "react";
import axios from "axios";
import "./App.css";


export default function App(){


const [token,setToken]=useState(
localStorage.getItem("token")
);


const [user,setUser]=useState("");
const [pass,setPass]=useState("");



async function login(){


try{


let r=
await axios.post(
"/api/login",
{

username:user,

password:pass

}

);


localStorage.setItem(
"token",
r.data.token
);


setToken(
r.data.token
);



}

catch(e){

alert("Login Failed");

}


}



if(!token)

return (

<div className="main">


<div className="card">


<h1>
MUTEB SOC
</h1>


<h2>
Enterprise Login
</h2>



<input
placeholder="Username"
onChange={
e=>setUser(e.target.value)
}
/>


<br/>


<input
type="password"
placeholder="Password"
onChange={
e=>setPass(e.target.value)
}
/>



<button
className="login"
onClick={login}
>

LOGIN

</button>


</div>


</div>

)



return (

<div className="enterprise">


<div className="sidebar">


<div className="logo">
MUTEB SOC
</div>


<button>
Dashboard
</button>

<button>
Alerts
</button>

<button>
Incidents
</button>

<button>
Threat Hunting
</button>

<button>
Reports
</button>


</div>



<div className="main">


<div className="card">

<h1>
SOC Command Center
</h1>

</div>


<div className="card">

<h3>
Critical Alerts
</h3>


<div className="metric">
1
</div>


</div>



<div className="card">

<h3>
Threat Score
</h3>


<div className="metric">
85
</div>


</div>



<div className="card success">

System Status:
ONLINE

</div>



<div className="card">

<h3>
Live Security Events
</h3>


<table width="100%">

<tbody>

<tr>

<td>
1
</td>

<td>
Suspicious Login
</td>

<td>
HIGH
</td>

</tr>


</tbody>

</table>


</div>



</div>


</div>

)


}


import React,{useState} from "react";
import {BrowserRouter,Routes,Route,Navigate,Link} from "react-router-dom";
import api from "./services/api";

import Dashboard from "./pages/Dashboard";
import Alerts from "./pages/Alerts";
import Incidents from "./pages/Incidents";
import Users from "./pages/Users";


function Login({setAuth}){

const [u,setU]=useState("");
const [p,setP]=useState("");
const [err,setErr]=useState("");

async function login(){

let r=await api.post("/api/login",{
username:u,
password:p
});

if(r.data.success){

localStorage.setItem("user",JSON.stringify(r.data));
setAuth(true);

}else{

setErr("Login Failed");

}

}


return <div>

<h1>MUTEB SOC</h1>

<input placeholder="Username"
onChange={e=>setU(e.target.value)}/>

<br/>

<input type="password"
placeholder="Password"
onChange={e=>setP(e.target.value)}/>

<br/>

<button onClick={login}>
LOGIN
</button>

<p>{err}</p>

</div>

}



function App(){

const [auth,setAuth]=useState(
!!localStorage.getItem("user")
);


if(!auth)

return <Login setAuth={setAuth}/>



return <BrowserRouter>

<nav>

<Link to="/">Dashboard</Link> |

<Link to="/alerts">Alerts</Link> |

<Link to="/incidents">Incidents</Link> |

<Link to="/users">Users</Link> |

<button onClick={()=>{
localStorage.clear();
setAuth(false)
}}>
Logout
</button>

</nav>


<Routes>

<Route path="/" element={<Dashboard/>}/>

<Route path="/alerts" element={<Alerts/>}/>

<Route path="/incidents" element={<Incidents/>}/>

<Route path="/users" element={<Users/>}/>

<Route path="*" element={<Navigate to="/"/>}/>

</Routes>


</BrowserRouter>

}


export default App;

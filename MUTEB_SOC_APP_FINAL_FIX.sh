#!/bin/bash

set -e


cd frontend


cp src/App.jsx src/App.jsx.failed_backup


cat > src/App.jsx <<'JS'

import React,{useState} from "react";

import {
BrowserRouter,
Routes,
Route,
Link
}
from "react-router-dom";


import Login from "./pages/Login";

import Dashboard from "./pages/Dashboard";

import EnterpriseDashboard from "./pages/EnterpriseDashboard";

import WebScanner from "./scanner/WebScanner";


import "./App.css";



export default function App(){


const [user,setUser]=useState(
localStorage.getItem("muteb_user")
);



function login(data){

localStorage.setItem(
"muteb_user",
JSON.stringify(data)
);


setUser(data);

}



function logout(){

localStorage.removeItem(
"muteb_user"
);


setUser(null);

}



if(!user){

return (

<Login
onLogin={login}
/>

)

}



return (

<BrowserRouter>


<div className="soc-layout">


<nav className="soc-menu">


<h2>
MUTEB SOC ENTERPRISE
</h2>


<h4>OPERATIONS</h4>

<Link to="/">Dashboard</Link>

<Link to="/enterprise">
Security Monitoring
</Link>

<Link to="/alerts">
Alerts
</Link>

<Link to="/incidents">
Incidents
</Link>

<Link to="/cases">
Cases
</Link>



<h4>THREAT INTELLIGENCE</h4>

<Link to="/hunting">
Threat Hunting
</Link>

<Link to="/ioc">
IOC Management
</Link>

<Link to="/mitre">
MITRE ATT&CK
</Link>



<h4>SECURITY ENGINEERING</h4>

<Link to="/detection">
Detection Engine
</Link>

<Link to="/scanner">
Web Security Scanner
</Link>



<h4>REPORTING</h4>

<Link to="/reports">
Reports
</Link>



<button
onClick={logout}
>
Logout
</button>


</nav>



<main className="soc-content">


<Routes>


<Route
path="/"
element={
<Dashboard logout={logout}/>
}
/>



<Route
path="/enterprise"
element={
<EnterpriseDashboard/>
}
/>



<Route
path="/scanner"
element={
<WebScanner/>
}
/>



</Routes>


</main>


</div>


</BrowserRouter>


)


}

JS



cat >> src/App.css <<'CSS'


.soc-layout{

display:flex;

min-height:100vh;

background:#050b14;

color:white;

}



.soc-menu{

width:260px;

background:#081a33;

padding:25px;

}



.soc-menu a{

display:block;

padding:12px;

color:white;

text-decoration:none;

}



.soc-menu a:hover{

background:#00a8ff;

}



.soc-content{

flex:1;

padding:30px;

}



.soc-menu button{

margin-top:20px;

padding:10px;

width:100%;

}



CSS



npm run build


sudo systemctl restart nginx



echo "MUTEB SOC LOGIN + ENTERPRISE UI FIX COMPLETE"


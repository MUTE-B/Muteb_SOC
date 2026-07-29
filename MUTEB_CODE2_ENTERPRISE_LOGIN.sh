#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE LOGIN"
echo " CODE 2"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup current App"

cp frontend/src/App.jsx frontend/src/App.jsx.before_login_enterprise 2>/dev/null || true


echo "[2] Create Login Component"


cat > frontend/src/pages/Login.jsx <<'JS'

import {useState} from "react";
import {login} from "../api/auth";


export default function Login({onLogin}){


const [username,setUsername]=useState("");

const [password,setPassword]=useState("");

const [message,setMessage]=useState("");



async function handleLogin(){


try{


const result =
await login(username,password);



if(result.success){


setMessage("Login Successful");


onLogin(result.user);


}

else{


setMessage("Invalid Credentials");


}



}

catch(error){

console.log(error);

setMessage("Backend Connection Failed");

}


}



return (

<div className="login">


<div className="card login-box">


<h1>

MUTEB SOC

</h1>


<p>

Security Operations Center

</p>



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



<button

className="primary-btn"

onClick={handleLogin}

>

SIGN IN

</button>



<p>

{message}

</p>



</div>


</div>


)


}

JS



echo "[3] Rebuild App Router"


cat > frontend/src/App.jsx <<'JS'

import {useState} from "react";

import Login from "./pages/Login";

import Dashboard from "./pages/Dashboard";

import Alerts from "./pages/Alerts";

import Sidebar from "./components/Sidebar";

import "./styles/enterprise.css";



function App(){


const [user,setUser]=useState(null);



if(!user){


return (

<Login

onLogin={setUser}

/>

)


}



return (

<div className="layout">


<Sidebar/>


<div className="main">


<div className="header">


<h2>

MUTEB SOC Enterprise

</h2>


<span>

User: {user.username}

</span>


</div>



<Dashboard/>


<br/>


<Alerts/>


</div>


</div>


)


}


export default App;

JS



echo "[4] Verify Auth API"

grep -n "/api/login" frontend/src/api/auth.js || true



echo "======================================"
echo " CODE 2 COMPLETE"
echo "======================================"

echo "No restart performed"


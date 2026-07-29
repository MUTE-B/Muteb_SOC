#!/bin/bash

set -e

PROJECT="/home/mte-b/Muteb-SOC"

echo "======================================"
echo " MUTEB SOC AUTO REPAIR GOLD SYSTEM "
echo "======================================"


cd $PROJECT


echo "[1] BACKUP"

mkdir -p backup_gold

cp backend/app.py backup_gold/app.py.backup.$(date +%s) || true
cp frontend/src/App.jsx backup_gold/App.jsx.backup.$(date +%s) || true
cp frontend/src/pages/Login.jsx backup_gold/Login.jsx.backup.$(date +%s) || true



echo "[2] FIX PYTHON ENV"


python3 -m venv backend/venv || true


backend/venv/bin/pip install --upgrade pip

backend/venv/bin/pip install \
flask \
flask-cors \
flask-jwt-extended \
psycopg2-binary \
werkzeug \
requests



echo "[3] VERIFY BACKEND"

backend/venv/bin/python -m py_compile backend/app.py



echo "[4] FIX BACKEND SERVICE"


sudo tee /etc/systemd/system/muteb-backend.service >/dev/null <<SERVICE

[Unit]
Description=MUTEB SOC Backend
After=network.target

[Service]
User=mte-b
WorkingDirectory=$PROJECT/backend
ExecStart=$PROJECT/backend/venv/bin/python app.py
Restart=always

[Install]
WantedBy=multi-user.target

SERVICE



echo "[5] FIX FRONTEND LOGIN CONNECTION"


cat > frontend/src/App.jsx <<'APP'

import {useState} from "react";
import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";
import "./App.css";


export default function App(){

const [user,setUser]=useState(
localStorage.getItem("user")
);


function login(data){

localStorage.setItem(
"user",
JSON.stringify(data)
);

setUser(data);

}


function logout(){

localStorage.removeItem("user");

setUser(null);

}


if(!user){

return <Login onLogin={login}/>

}


return (

<Dashboard logout={logout}/>

);


}

APP



echo "[6] FIX LOGIN PAGE"


cat > frontend/src/pages/Login.jsx <<'LOGIN'

import {useState} from "react";


export default function Login({onLogin}){


const [username,setUsername]=useState("");

const [password,setPassword]=useState("");

const [error,setError]=useState("");



async function submit(){


try{


let r=await fetch("/api/login",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

username,

password

})

});



let data=await r.json();



if(data.success){

onLogin(data);

}

else{

setError("Invalid Username or Password");

}


}

catch(e){

setError("Backend Connection Error");

}



}



return (

<div className="login">


<h1>MUTEB SOC</h1>

<h2>Enterprise Login</h2>


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


<button onClick={submit}>
LOGIN
</button>


<p>{error}</p>


</div>


);


}

LOGIN



echo "[7] FRONTEND CLEAN"


cd frontend


npm install


rm -rf dist


npm run build



echo "[8] NGINX VERIFY"


sudo nginx -t



echo "[9] RESTART SERVICES"


sudo systemctl daemon-reload


sudo systemctl enable muteb-backend.service


sudo systemctl restart muteb-backend.service


sudo systemctl restart nginx



echo "[10] TEST BACKEND"


curl -s http://localhost:8000/health || true


echo


echo "[11] LOGIN TEST"


curl -s -X POST http://localhost:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@Admin2026"}'



echo


echo "======================================"
echo " MUTEB SOC REPAIR COMPLETE "
echo " LOGIN:"
echo " admin"
echo " Muteb@Admin2026"
echo "======================================"


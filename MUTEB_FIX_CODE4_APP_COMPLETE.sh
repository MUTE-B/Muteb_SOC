#!/bin/bash

echo "======================================"
echo " MUTEB SOC FIX CODE 4 APP COMPLETE"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup broken App.jsx"

cp frontend/src/App.jsx frontend/src/App.jsx.broken_code4 2>/dev/null || true



echo "[2] Restore complete App.jsx"


cat > frontend/src/App.jsx <<'JS'

import {useState} from "react";
import "./App.css";
import {login} from "./api/auth";


const API =
import.meta.env.VITE_API_URL ||
"http://172.20.10.4:8000";



function App(){


const [username,setUsername]=useState("");

const [password,setPassword]=useState("");

const [user,setUser]=useState(null);

const [message,setMessage]=useState("");

const [dashboard,setDashboard]=useState(null);



async function handleLogin(){


try{


const result =
await login(username,password);



if(result.success){


setUser(result.user);

loadDashboard();


}

else{


setMessage("Invalid Credentials");


}


}

catch(error){


console.log(error);

setMessage(
"Backend Connection Failed"
);


}


}





async function loadDashboard(){


try{


const response =
await fetch(
`${API}/api/soc/dashboard`
);


const data =
await response.json();


setDashboard(data);


}

catch(error){


console.log(error);


}


}





if(!user){


return(

<div className="login">


<div className="login-box">


<h1>
🛡 MUTEB SOC
</h1>


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


<button onClick={handleLogin}>
LOGIN
</button>


<p>
{message}
</p>


</div>

</div>

);


}





return(


<div className="dashboard">


<h1>
🛡 MUTEB SOC Dashboard
</h1>



<h3>
Welcome {user.username}
</h3>


<p>
Role: {user.role}
</p>



{

dashboard &&

<div>


<div className="card">

<h3>
Critical Alerts
</h3>

<p>
{
dashboard.stats.critical_alerts
}
</p>

</div>



<div className="card">

<h3>
Open Incidents
</h3>

<p>
{
dashboard.stats.open_incidents
}
</p>

</div>



<h2>
Alerts
</h2>


{

dashboard.alerts.map(
(a,i)=>(

<div className="alert" key={i}>

<b>
{a.severity}
</b>

-
{a.source}

-
{a.status}

</div>


)

)

}



<h2>
Incidents
</h2>



{

dashboard.incidents.map(
(i)=>(

<div className="alert">

{i.id}
-
{i.title}
-
{i.priority}

</div>


)

)

}



</div>

}



</div>


);



}


export default App;

JS



echo "[3] Restart Frontend"


pkill -f vite 2>/dev/null || true


sleep 3


cd frontend


nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo "======================================"
echo " FIX COMPLETE"
echo "======================================"

tail -20 ../frontend.log


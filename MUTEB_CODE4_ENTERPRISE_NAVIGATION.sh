#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE NAVIGATION"
echo " CODE 4"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup"

cp frontend/src/App.jsx frontend/src/App.jsx.before_navigation 2>/dev/null || true


echo "[2] Create Sidebar"



cat > frontend/src/components/Sidebar.jsx <<'JS'


export default function Sidebar({page,setPage,logout}){


return (


<div className="sidebar">


<div className="logo">

MUTEB SOC

</div>



<p className="subtitle">

Enterprise Security Center

</p>




<div className="menu">


<div onClick={()=>setPage("dashboard")}>

Dashboard

</div>



<div onClick={()=>setPage("alerts")}>

Alerts

</div>



<div onClick={()=>setPage("incidents")}>

Incidents

</div>



<div onClick={()=>setPage("reports")}>

Reports

</div>



</div>




<button

className="logout"

onClick={logout}

>

Logout

</button>



</div>


)


}

JS




echo "[3] Create Incidents Page"



cat > frontend/src/pages/Incidents.jsx <<'JS'


export default function Incidents(){


return (


<div className="card">


<h1>
Incident Response
</h1>



<table>


<thead>

<tr>

<th>ID</th>

<th>Type</th>

<th>Status</th>

</tr>

</thead>



<tbody>


<tr>

<td>
INC-001
</td>


<td>
Unauthorized Login
</td>


<td>
Investigating
</td>


</tr>



<tr>

<td>
INC-002
</td>


<td>
Malware Detection
</td>


<td>
Open
</td>


</tr>



</tbody>



</table>



</div>


)


}

JS




echo "[4] Create Reports Page"



cat > frontend/src/pages/Reports.jsx <<'JS'


export default function Reports(){


return (


<div className="card">


<h1>
Security Reports
</h1>



<p>
Daily SOC Monitoring Reports
</p>



<p>
Detection Analysis
</p>



<p>
Incident Summary
</p>



</div>


)


}

JS





echo "[5] Create Final App Navigation"



cat > frontend/src/App.jsx <<'JS'


import {useState} from "react";

import Login from "./pages/Login";

import Dashboard from "./pages/Dashboard";

import Alerts from "./pages/Alerts";

import Incidents from "./pages/Incidents";

import Reports from "./pages/Reports";

import Sidebar from "./components/Sidebar";

import "./styles/enterprise.css";



function App(){



const [user,setUser]=useState(null);

const [page,setPage]=useState("dashboard");




function logout(){

setUser(null);

}




if(!user){


return (

<Login

onLogin={setUser}

/>

)


}





function renderPage(){


if(page==="alerts")

return <Alerts/>;



if(page==="incidents")

return <Incidents/>;



if(page==="reports")

return <Reports/>;



return <Dashboard/>;



}




return (


<div className="layout">



<Sidebar

page={page}

setPage={setPage}

logout={logout}

/>




<div className="main">


<div className="header">


<h2>
MUTEB SOC Enterprise
</h2>



<span>

{user.username}

</span>


</div>




{renderPage()}



</div>


</div>


)



}



export default App;

JS




echo "[6] Add Styles"



cat >> frontend/src/styles/enterprise.css <<'CSS'


.subtitle{

color:var(--muted);

font-size:14px;

}


.logout{

margin-top:50px;

width:100%;

padding:12px;

background:#dc2626;

color:white;

border-radius:8px;

}


.sidebar div{

cursor:pointer;

}


CSS



echo "======================================"
echo " CODE 4 COMPLETE"
echo "======================================"

echo "No restart performed"


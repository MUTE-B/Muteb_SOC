
#!/bin/bash

set -e


PROJECT="/home/mte-b/Muteb-SOC"


echo "====================================="
echo " MUTEB SOC ENTERPRISE UI UPGRADE "
echo "====================================="


cd $PROJECT



echo "[1] CREATE ENTERPRISE CSS"


cat > frontend/src/App.css <<'CSS'


:root{

--bg:#050B14;
--panel:#081A33;
--blue:#00A8FF;
--green:#00D084;
--yellow:#FFB020;
--red:#FF3B30;
--text:#E8F1FF;

}



*{

box-sizing:border-box;

font-family:
"Inter",
"Segoe UI",
sans-serif;

}



body{

margin:0;

background:
linear-gradient(
135deg,
#050B14,
#081A33
);

color:var(--text);

min-height:100vh;

}



button{

background:
linear-gradient(
135deg,
#00A8FF,
#0066ff
);

border:0;

padding:12px 30px;

border-radius:10px;

color:white;

font-weight:bold;

cursor:pointer;

transition:.3s;

}


button:hover{

transform:translateY(-2px);

box-shadow:
0 0 20px #00A8FF;

}



input{

width:100%;

padding:14px;

margin:10px 0;

border-radius:10px;

border:1px solid #234;

background:#020812;

color:white;

}



.login{


width:420px;

margin:120px auto;

padding:40px;

background:
rgba(8,26,51,.75);


border-radius:20px;

backdrop-filter:
blur(20px);


box-shadow:
0 0 40px #000;


text-align:center;


}



.login h1{

color:#00A8FF;

font-size:38px;

}



.dashboard{

display:flex;

min-height:100vh;

}



.sidebar{


width:260px;

background:
rgba(8,26,51,.9);

padding:25px;


}



.sidebar h2{

color:#00A8FF;

}



.sidebar button{

width:100%;

margin:8px 0;

background:#102947;

}



.content{


flex:1;

padding:30px;


}



.card{


display:inline-block;

width:240px;

padding:25px;

margin:15px;

background:

rgba(255,255,255,.05);


border-radius:18px;


border:
1px solid rgba(255,255,255,.1);


backdrop-filter:
blur(15px);


}



.card h1{

font-size:40px;

}



.critical{

color:#FF3B30;

}


.success{

color:#00D084;

}


.warning{

color:#FFB020;

}



table{


width:100%;

background:#081A33;

border-radius:15px;

overflow:hidden;


}



td,th{


padding:15px;

border-bottom:
1px solid #123;


}



@media(max-width:900px){


.sidebar{

width:100%;

}


.dashboard{

display:block;

}


.login{

width:90%;

}


}



CSS




echo "[2] CREATE ENTERPRISE DASHBOARD"


cat > frontend/src/pages/Dashboard.jsx <<'DASH'


export default function Dashboard({logout}){


return (


<div className="dashboard">


<div className="sidebar">


<h2>
MUTEB SOC
</h2>


<button>Dashboard</button>

<button>Alerts</button>

<button>Incidents</button>

<button>Users</button>

<button>Logs</button>


<button onClick={logout}>
Logout
</button>


</div>



<div className="content">


<h1>
SOC Command Center
</h1>


<div className="card">

<h3>
Critical Alerts
</h3>

<h1 className="critical">
1
</h1>

</div>



<div className="card">

<h3>
Open Incidents
</h3>

<h1 className="warning">
1
</h1>


</div>



<div className="card">

<h3>
Threat Score
</h3>

<h1 className="critical">
85
</h1>


</div>



<div className="card">

<h3>
System Status
</h3>

<h1 className="success">
ONLINE
</h1>


</div>



<h2>
Recent Security Events
</h2>



<table>


<thead>

<tr>

<th>ID</th>

<th>Event</th>

<th>Severity</th>

<th>Status</th>


</tr>

</thead>



<tbody>


<tr>

<td>1</td>

<td>
Suspicious Login
</td>

<td className="critical">
HIGH
</td>

<td>
Investigating
</td>


</tr>


</tbody>


</table>



</div>


</div>


)


}


DASH




echo "[3] BUILD FRONTEND"


cd frontend


npm install


npm run build




echo "[4] RESTART"


sudo systemctl restart muteb-frontend.service

sudo systemctl restart nginx




echo "====================================="
echo " MUTEB SOC ENTERPRISE UI READY "
echo "====================================="



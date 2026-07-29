#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE DASHBOARD"
echo " CODE 3"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup Dashboard"

cp frontend/src/pages/Dashboard.jsx \
frontend/src/pages/Dashboard.jsx.backup 2>/dev/null || true



echo "[2] Create Enterprise Dashboard"



cat > frontend/src/pages/Dashboard.jsx <<'JS'


export default function Dashboard(){


return (


<>


<div className="header">


<div>

<h1>
SOC Operations Dashboard
</h1>


<p>
Real Time Security Monitoring Platform
</p>


</div>


<div>

<strong>
SYSTEM
</strong>

<br/>

<span className="success">
ONLINE
</span>


</div>


</div>




<div className="grid">


<div className="card">


<h3>
Critical Alerts
</h3>


<div className="stat critical">
03
</div>


</div>




<div className="card">


<h3>
Active Incidents
</h3>


<div className="stat">
05
</div>


</div>





<div className="card">


<h3>
Events Today
</h3>


<div className="stat">
12450
</div>


</div>





<div className="card">


<h3>
Threat Level
</h3>


<div className="stat success">
LOW
</div>


</div>


</div>





<br/>





<div className="card">


<h2>
Recent Security Alerts
</h2>



<table>


<thead>

<tr>

<th>
Severity
</th>


<th>
Source
</th>


<th>
Status
</th>


</tr>


</thead>



<tbody>


<tr>

<td className="critical">
Critical
</td>


<td>
Firewall
</td>


<td>
Investigating
</td>


</tr>




<tr>

<td className="medium">
Medium
</td>


<td>
Authentication
</td>


<td>
Monitoring
</td>


</tr>




<tr>

<td className="success">
Low
</td>


<td>
System Logs
</td>


<td>
Resolved
</td>


</tr>



</tbody>


</table>


</div>





<br/>




<div className="card">


<h2>
Analyst Information
</h2>



<p>

Role:
SOC Analyst

</p>


<p>

Environment:
MUTEB SOC Enterprise Lab

</p>


<p>

Monitoring:
Active

</p>



</div>



</>


)


}

JS



echo "[3] Update CSS dashboard"



cat >> frontend/src/styles/enterprise.css <<'CSS'


.header p{

color:var(--muted);

margin-top:5px;

}


.header span{

font-size:18px;

}


h1,h2,h3{

margin-top:0;

}



CSS



echo "======================================"
echo " CODE 3 COMPLETE"
echo "======================================"

echo "No restart performed"


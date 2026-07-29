#!/bin/bash

echo "======================================"
echo " MUTEB SOC DASHBOARD PROFESSIONAL"
echo " CODE 8"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup Dashboard"

cp frontend/src/pages/Dashboard.jsx \
frontend/src/pages/Dashboard.jsx.before_pro 2>/dev/null || true



echo "[2] Create Professional Dashboard"



cat > frontend/src/pages/Dashboard.jsx <<'JS'


export default function Dashboard(){


return (

<>


<div className="header">


<div>

<h1>
MUTEB SOC Dashboard
</h1>


<p>
Security Operations Center Monitoring
</p>


</div>



<div>

<strong>
SYSTEM STATUS
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
Security Events
</h3>


<div className="stat">
12,450
</div>


<p>
Collected Today
</p>


</div>





<div className="card">

<h3>
Active Alerts
</h3>


<div className="stat critical">
03
</div>


<p>
Require Review
</p>


</div>





<div className="card">

<h3>
Incidents
</h3>


<div className="stat">
05
</div>


<p>
Under Investigation
</p>


</div>





<div className="card">

<h3>
Threat Level
</h3>


<div className="stat success">
LOW
</div>


<p>
Current Risk
</p>


</div>



</div>






<br/>





<div className="card">


<h2>
Security Event Timeline
</h2>


<table>


<thead>

<tr>

<th>
Time
</th>

<th>
Event
</th>

<th>
Status
</th>


</tr>

</thead>


<tbody>


<tr>

<td>
10:30
</td>


<td>
Firewall Detection
</td>


<td className="critical">
Investigating
</td>


</tr>




<tr>

<td>
11:15
</td>


<td>
Login Analysis
</td>


<td className="medium">
Monitoring
</td>


</tr>




<tr>

<td>
12:00
</td>


<td>
System Audit
</td>


<td className="success">
Completed
</td>


</tr>



</tbody>


</table>


</div>






<br/>





<div className="grid">



<div className="card">


<h2>
Detection Engine
</h2>


<p>
Sigma Rules: Active
</p>


<p>
MITRE ATT&CK Mapping: Enabled
</p>


<p>
IOC Analysis: Ready
</p>


</div>




<div className="card">


<h2>
SOC Environment
</h2>


<p>
Platform:
MUTEB SOC Enterprise
</p>


<p>
Mode:
Defensive Security
</p>


<p>
Role:
SOC Analyst
</p>


</div>



</div>




</>


)


}

JS




echo "======================================"
echo " CODE 8 COMPLETE"
echo "======================================"

echo "No restart performed"


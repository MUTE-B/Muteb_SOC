

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



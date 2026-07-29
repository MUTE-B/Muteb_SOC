#!/bin/bash

set -e


cd frontend


cp src/App.jsx src/App.jsx.enterprise_backup



python3 - <<'PY'

from pathlib import Path


p=Path("src/App.jsx")


if not p.exists():

    exit()



x=p.read_text()



start=x.find("<nav")

end=x.find("</nav>")



if start!=-1 and end!=-1:


    new_nav=r'''

<nav className="soc-menu">

<h2>MUTEB SOC ENTERPRISE</h2>


<h4>OPERATIONS</h4>

<Link to="/">Dashboard</Link>

<Link to="/monitoring">Security Monitoring</Link>

<Link to="/alerts">Alerts</Link>

<Link to="/incidents">Incidents</Link>

<Link to="/cases">Cases</Link>



<h4>THREAT INTELLIGENCE</h4>

<Link to="/hunting">Threat Hunting</Link>

<Link to="/ioc">IOC Management</Link>

<Link to="/intelligence">Threat Intelligence</Link>

<Link to="/mitre">MITRE ATT&CK</Link>



<h4>SECURITY ENGINEERING</h4>

<Link to="/detection">Detection Engine</Link>

<Link to="/sigma">Sigma Rules</Link>

<Link to="/yara">YARA Scanner</Link>

<Link to="/logs">Log Collector</Link>

<Link to="/correlation">Correlation Engine</Link>



<h4>ASSESSMENT</h4>

<Link to="/scanner">Web Security Scanner</Link>

<Link to="/vulnerability">Vulnerability Assessment</Link>

<Link to="/risk">Risk Assessment</Link>



<h4>REPORTING</h4>

<Link to="/reports">Reports</Link>

<Link to="/compliance">Compliance Reports</Link>

<Link to="/audit">Audit Logs</Link>



<h4>ADMINISTRATION</h4>

<Link to="/users">Users Management</Link>

<Link to="/settings">System Settings</Link>

<Link to="/configuration">Configuration</Link>


</nav>

'''



    x=x[:start]+new_nav+x[end+6:]


    p.write_text(x)



PY



cat >> src/enterprise.css <<'CSS'


.soc-menu h4{

color:#00a8ff;

font-size:12px;

margin-top:25px;

letter-spacing:1px;

}



.soc-menu a{

display:block;

padding:10px;

color:#e8f1ff;

text-decoration:none;

border-radius:6px;

}



.soc-menu a:hover{

background:#102c4d;

color:#00d084;

}



CSS



npm run build


sudo systemctl restart nginx



echo "MUTEB SOC ENTERPRISE NAVIGATION READY"



#!/bin/bash

echo "======================================"
echo " MUTEB SOC REPORTS PROFILE STATUS"
echo " CODE 38"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup UI"

mkdir -p frontend/UI_BACKUP_CODE38

cp frontend/src/App.jsx frontend/UI_BACKUP_CODE38/App.jsx.backup



echo "[2] Update dashboard sections"


python3 - <<'PY'

from pathlib import Path

file = Path("frontend/src/App.jsx")

data = file.read_text()


old = """
<div>Reports</div>
<div>Settings</div>
"""


new = """
<div>Reports</div>
<div>Analyst Profile</div>
<div>System Status</div>
<div>Settings</div>
"""


data = data.replace(old,new)



old_panel = """
<div className="panel">


<h2>Analyst Information</h2>


<p>
Username: {user.username}
</p>


<p>
Role: {user.role}
</p>


</div>
"""


new_panel = """
<div className="panel">


<h2>Analyst Profile</h2>


<p>
Username: {user.username}
</p>


<p>
Role: {user.role}
</p>


<p>
Department: Security Operations Center
</p>


<p>
Access Level: Analyst
</p>


</div>



<div className="panel">


<h2>System Status</h2>


<p>
Backend: Online
</p>


<p>
Frontend: Online
</p>


<p>
Monitoring Engine: Active
</p>


</div>



<div className="panel">


<h2>Security Reports</h2>


<table>

<thead>

<tr>

<th>Report</th>

<th>Status</th>

</tr>

</thead>


<tbody>


<tr>

<td>Daily Security Report</td>

<td>Generated</td>

</tr>


<tr>

<td>Threat Analysis Report</td>

<td>Available</td>

</tr>


<tr>

<td>Incident Summary</td>

<td>Ready</td>

</tr>


</tbody>


</table>


</div>
"""


data=data.replace(old_panel,new_panel)


file.write_text(data)

PY




echo "[3] Add status cards styling"


cat >> frontend/src/App.css <<'EOF'


/* ===================================
   ENTERPRISE STATUS PANELS
=================================== */


.panel{

background:#111827;

border:1px solid #1e293b;

border-radius:12px;

padding:25px;

margin-top:25px;

}



.panel h2{

color:#38bdf8;

margin-bottom:15px;

}



.panel p{

color:#cbd5e1;

line-height:1.8;

}



EOF




echo "[4] Restart frontend"


pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5



echo ""
echo "======================================"
echo " CODE 38 COMPLETE"
echo "======================================"

tail -20 ../frontend.log



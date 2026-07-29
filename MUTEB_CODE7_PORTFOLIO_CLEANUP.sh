#!/bin/bash

echo "======================================"
echo " MUTEB SOC PORTFOLIO CLEANUP"
echo " CODE 7"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create frontend archive folder"

mkdir -p frontend/archive


echo "[2] Move old frontend backups"


find frontend/src \
-maxdepth 2 \
-type f \
-name "*.backup*" \
-exec mv {} frontend/archive/ \; 2>/dev/null || true


find frontend/src \
-maxdepth 2 \
-type f \
-name "*.before*" \
-exec mv {} frontend/archive/ \; 2>/dev/null || true



echo "[3] Create System Info Page"


cat > frontend/src/pages/System.jsx <<'JS'


export default function System(){


return (

<div className="card">


<h1>
System Information
</h1>


<p>
Platform:
MUTEB SOC Enterprise
</p>


<p>
Version:
v1.0.0
</p>


<p>
Architecture:
SOC Monitoring Platform
</p>


<p>
Environment:
Defensive Security Laboratory
</p>


<p>
Status:
<span className="success">
 ONLINE
</span>
</p>



</div>


)

}

JS



echo "[4] Update Version File"


echo "MUTEB SOC Enterprise v1.0.0" > VERSION



echo "[5] Check Git Status"


git status --short



echo "======================================"
echo " CODE 7 COMPLETE"
echo "======================================"

echo "No services restarted"


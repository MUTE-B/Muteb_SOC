#!/bin/bash

echo "======================================"
echo " MUTEB SENTINEL X FRONTEND"
echo " COMMAND CENTER BUILD"
echo "======================================"


mkdir -p frontend/src/sentinel_x/{components,pages,services}



cat > frontend/src/sentinel_x/services/sentinelApi.js <<'JS'

import axios from "axios";

const sentinelAPI = axios.create({

baseURL:"http://172.20.10.4:8000/api/sentinel"

});

export default sentinelAPI;

JS



cat > frontend/src/sentinel_x/pages/CommandCenter.jsx <<'JSX'

import React from "react";

export default function CommandCenter(){

return (

<div className="sentinel-container">

<h1>MUTEB SOC Sentinel X</h1>

<h2>Security Command Center</h2>


<div>

<h3>Security Score</h3>
<p>92%</p>

<h3>Asset Intelligence</h3>
<p>Monitoring Active</p>


<h3>Risk Status</h3>
<p>LOW</p>


<h3>AI Security Director</h3>
<p>ONLINE</p>


</div>


</div>

);

}

JSX



cat > frontend/src/sentinel_x/pages/Assets.jsx <<'JSX'

import React from "react";

export default function Assets(){

return (

<div>

<h1>Asset Intelligence</h1>

<ul>

<li>Web Applications</li>

<li>APIs</li>

<li>Servers</li>

<li>Cloud Assets</li>

</ul>

</div>

);

}

JSX



cat > frontend/src/sentinel_x/pages/RiskCenter.jsx <<'JSX'

import React from "react";


export default function RiskCenter(){

return (

<div>

<h1>Risk Intelligence Center</h1>

<p>
Critical : 0
</p>

<p>
High : 0
</p>

<p>
Medium : 0
</p>

<p>
Low : 0
</p>


</div>

);

}

JSX



cat > frontend/src/sentinel_x/pages/AIDirector.jsx <<'JSX'

import React from "react";


export default function AIDirector(){

return (

<div>

<h1>
AI Security Director
</h1>


<p>
Recommendation:
</p>


<h3>
Maintain identity controls and continuous monitoring
</h3>


</div>

);

}

JSX



cat > frontend/src/sentinel_x/pages/ExecutiveReport.jsx <<'JSX'

import React from "react";


export default function ExecutiveReport(){

return (

<div>

<h1>
Executive Security Report
</h1>

<h2>
Security Posture 92%
</h2>


</div>

);

}

JSX



cat > frontend/src/sentinel_x/SentinelXRouter.jsx <<'JSX'

import React from "react";

import CommandCenter from "./pages/CommandCenter";

import Assets from "./pages/Assets";

import RiskCenter from "./pages/RiskCenter";

import AIDirector from "./pages/AIDirector";

import ExecutiveReport from "./pages/ExecutiveReport";


export default function SentinelXRouter(){


return (

<div>


<CommandCenter/>


<Assets/>


<RiskCenter/>


<AIDirector/>


<ExecutiveReport/>


</div>

);


}

JSX



echo ""
echo "======================================"
echo " SENTINEL X FRONTEND READY"
echo "======================================"


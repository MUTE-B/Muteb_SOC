#!/bin/bash


echo "======================================"
echo " MUTEB SOC SENTINEL X DASHBOARD LINK"
echo "======================================"


mkdir -p frontend/src/sentinel_x/components
mkdir -p frontend/src/sentinel_x/styles



####################################
# NAVIGATION BUTTON
####################################


cat > frontend/src/sentinel_x/components/SentinelButton.jsx <<'JSX'

import React from "react";


export default function SentinelButton({onOpen}){


return (

<button
onClick={onOpen}
style={{
background:"#071a33",
color:"#00eaff",
padding:"12px 20px",
borderRadius:"8px",
border:"1px solid #00eaff",
cursor:"pointer"
}}
>

🛡️ Sentinel X Command Center

</button>

);


}

JSX




####################################
# SECURITY SCORE CARD
####################################


cat > frontend/src/sentinel_x/components/SecurityScore.jsx <<'JSX'

import React from "react";


export default function SecurityScore(){


return (

<div className="security-card">


<h3>
Security Score
</h3>


<h1>
92%
</h1>


<p>
Enterprise Security Level
</p>


</div>

);


}

JSX




####################################
# ASSET CARD
####################################


cat > frontend/src/sentinel_x/components/AssetCard.jsx <<'JSX'

import React from "react";


export default function AssetCard(){


return (

<div className="security-card">


<h3>
Assets Intelligence
</h3>


<p>
120 Assets Monitored
</p>


<p>
Web / API / Cloud / Servers
</p>


</div>

);


}

JSX




####################################
# RISK CARD
####################################


cat > frontend/src/sentinel_x/components/RiskCard.jsx <<'JSX'

import React from "react";


export default function RiskCard(){


return (

<div className="security-card">


<h3>
Risk Intelligence
</h3>


<p>
Critical : 0
</p>


<p>
High : 0
</p>


<p>
Medium : 0
</p>


</div>


);


}

JSX




####################################
# AI DIRECTOR CARD
####################################


cat > frontend/src/sentinel_x/components/AIDirectorCard.jsx <<'JSX'

import React from "react";


export default function AIDirectorCard(){


return (

<div className="security-card">


<h3>
AI Security Director
</h3>


<p>

Priority:
NORMAL

</p>


<p>

Recommendation:
Continuous Monitoring

</p>


</div>


);


}

JSX




####################################
# SENTINEL DASHBOARD WRAPPER
####################################


cat > frontend/src/sentinel_x/components/SentinelDashboard.jsx <<'JSX'


import React from "react";


import SecurityScore from "./SecurityScore";

import AssetCard from "./AssetCard";

import RiskCard from "./RiskCard";

import AIDirectorCard from "./AIDirectorCard";



export default function SentinelDashboard(){


return (

<div>


<h1>
MUTEB SOC Sentinel X
</h1>


<h2>
Enterprise Security Intelligence Platform
</h2>



<div>


<SecurityScore/>


<AssetCard/>


<RiskCard/>


<AIDirectorCard/>


</div>



</div>


);


}


JSX





####################################
# CSS
####################################


cat > frontend/src/sentinel_x/styles/sentinel.css <<'CSS'


.security-card{


background:#07111f;

color:white;

padding:20px;

margin:10px;

border-radius:12px;

border:1px solid #00eaff;


}


.security-card h1{

color:#00eaff;

}



CSS




echo ""

echo "======================================"

echo " SENTINEL DASHBOARD INTEGRATION READY"

echo "======================================"



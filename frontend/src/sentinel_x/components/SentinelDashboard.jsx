

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



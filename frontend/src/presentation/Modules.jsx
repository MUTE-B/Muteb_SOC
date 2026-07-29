

import React from "react";


export default function Modules(){


const modules=[


"Sentinel X",

"AI Security Director",

"SOC Command Center",

"Threat Intelligence",

"Risk Engine",

"Compliance Center"


];



return (

<div>


<h1>
Enterprise Modules
</h1>


{modules.map((m)=>(

<p key={m}>

✓ {m}

</p>

))}



</div>

);


}


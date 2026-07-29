
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


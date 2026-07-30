import {useEffect,useState} from "react";
import {dashboard} from "../services/api";


export default function Dashboard(){

const [data,setData]=useState(null);


useEffect(()=>{

dashboard()
.then(setData)
.catch(console.error);

},[]);



if(!data){

return (

<div style={{
background:"#020617",
color:"white",
height:"100vh",
padding:"40px"
}}>

Loading SOC Dashboard...

</div>

);

}



return (

<div style={{
background:"#020617",
color:"#fff",
minHeight:"100vh",
padding:"40px",
fontFamily:"Arial"
}}>


<h1>
🛡️ MUTEB SOC Enterprise
</h1>


<h3>
Security Operations Center
</h3>



<div style={{
display:"grid",
gridTemplateColumns:"repeat(4,1fr)",
gap:"20px",
marginTop:"30px"
}}>


<Card
title="Active Users"
value={data.active_users}
/>


<Card
title="Threat Score"
value={data.threat_score}
/>


<Card
title="Critical Alerts"
value={data.critical_alerts}
/>


<Card
title="Open Incidents"
value={data.open_incidents}
/>


</div>



<div style={{
marginTop:"40px",
background:"#111827",
padding:"25px",
borderRadius:"12px"
}}>


<h2>
Security Events
</h2>


<p>
Threat Level:
{
data.threat_score >=70
?
" HIGH "
:
" NORMAL "
}

</p>


<p>
Scanner Status:
ONLINE
</p>


<p>
Logs:
Connected
</p>



</div>


</div>


)

}



function Card({title,value}){


return (

<div style={{
background:"#111827",
padding:"25px",
borderRadius:"15px",
border:"1px solid #334155"
}}>


<h3>
{title}
</h3>


<h1>
{value}
</h1>


</div>


)

}


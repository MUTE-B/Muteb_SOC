
import React,{useEffect,useState} from "react";

import {socket} from "./api/socket";


function Investigation(){


const [alerts,setAlerts]=useState([]);



useEffect(()=>{


socket.on(
"security_alert",
(data)=>{


setAlerts(
old=>[
...old,
data
]
);


}

);


return()=>{

socket.off(
"security_alert"
);

};


},[]);



return(

<div className="card">


<h2>
Live Security Alerts
</h2>


{

alerts.map(
(a,i)=>(

<pre key={i}>

{
JSON.stringify(
a,
null,
2
)
}

</pre>

)

)

}


</div>

);


}


export default Investigation;


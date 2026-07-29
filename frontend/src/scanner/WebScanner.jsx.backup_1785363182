

import React,{useState} from "react";

import axios from "axios";



export default function WebScanner(){


const [domain,setDomain]=useState("");

const [result,setResult]=useState(null);



async function scan(){


try{


const r=await axios.post(

"/api/scanner/start",

{

domain:domain

}

);


setResult(r.data);


}

catch(e){

alert(
"Scanner Error"
)

}


}




return (

<div className="soc-page">


<h1>

MUTEB WEB SECURITY SCANNER

</h1>


<div className="soc-card">


<input

className="soc-input"

placeholder="example.com"

value={domain}

onChange={
e=>setDomain(e.target.value)
}


/>



<button

className="soc-button"

onClick={scan}

>

START SCAN

</button>



</div>



{

result &&


<div className="soc-card">


<h2>

TARGET:

{result.target}

</h2>


<h3>

RISK:

{result.report.risk.risk_level}

</h3>



<h3>

FINDINGS

</h3>



{

result.report.risk.findings.map(

(item,index)=>(

<p key={index}>

{item.issue}

-

{item.severity}

</p>

)

)

}



</div>


}



</div>


)


}


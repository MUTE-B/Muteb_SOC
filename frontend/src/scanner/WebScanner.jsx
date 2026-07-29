
import React,{useEffect,useState} from "react";
import axios from "axios";

import "../App.css";


export default function WebScanner(){


const [target,setTarget]=useState("");

const [history,setHistory]=useState([]);

const [result,setResult]=useState(null);

const [progress,setProgress]=useState(0);

const [loading,setLoading]=useState(false);



async function startScan(){


if(!target){

alert("Target required");

return;

}


setLoading(true);

setProgress(10);



try{


setProgress(40);


const res=await axios.post(

"/api/scanner/v2/start",

{

target:target

}

);



setProgress(80);



setResult(res.data);



await loadHistory();



setProgress(100);



}

catch(e){


alert(
"Scanner Error"
);


}

finally{


setLoading(false);


}



}




async function loadHistory(){


const r=await axios.get(

"/api/scanner/v2/history"

);


setHistory(
r.data.history || []
);


}



async function exportReport(id){


const r=await axios.get(

"/api/scanner/v2/report/"+id

);


alert(

"PDF Generated: "+r.data.report

);


}




useEffect(()=>{

loadHistory();

},[]);



return (


<div className="soc-page">


<h1>

🛡️ MUTEB SOC SCANNER v2 ENTERPRISE

</h1>



<div className="soc-card">


<input

className="soc-input"

placeholder="example.com"

value={target}

onChange={
e=>setTarget(e.target.value)
}


/>



<button

className="soc-button"

onClick={startScan}

disabled={loading}

>

{loading ?

"SCANNING..."

:

"START SCAN"

}


</button>



</div>




{

loading &&

<div className="soc-card">

<h3>

SCAN PROGRESS

</h3>


<div

style={{

width:"100%",

background:"#222",

height:"20px"

}}

>


<div

style={{

width:progress+"%",

height:"20px",

background:"#00ff99"

}}

></div>


</div>


</div>


}






{

result &&

<div className="soc-card">


<h2>

TARGET

</h2>


<p>

{result.target}

</p>



<h2>

RISK

</h2>


<p>

{result.risk}

</p>



<h2>

FINDINGS

</h2>



<table>


<thead>

<tr>

<th>
Title
</th>


<th>
Severity
</th>


<th>
OWASP
</th>


</tr>

</thead>



<tbody>


{

result.findings.map(

(f,i)=>(


<tr key={i}>


<td>

{f.title}

</td>


<td>

{f.severity}

</td>


<td>

{f.owasp}

</td>


</tr>


)

)

}



</tbody>


</table>



<button

className="soc-button"

onClick={()=>exportReport(result.scan_id)}

>

EXPORT PDF REPORT

</button>



</div>


}







<div className="soc-card">


<h2>

SCAN HISTORY

</h2>



<table>


<thead>

<tr>

<th>
Target
</th>

<th>
Risk
</th>

<th>
Findings
</th>

<th>
Date
</th>

<th>
Report
</th>


</tr>


</thead>



<tbody>


{

history.map(

(item,i)=>(


<tr key={i}>


<td>

{item.target}

</td>


<td>

{item.risk}

</td>


<td>

{item.findings.length}

</td>


<td>

{item.date}

</td>



<td>


<button

className="soc-button"

onClick={()=>exportReport(item.scan_id)}

>

PDF

</button>


</td>


</tr>


)

)


}



</tbody>


</table>



</div>



</div>


)


}


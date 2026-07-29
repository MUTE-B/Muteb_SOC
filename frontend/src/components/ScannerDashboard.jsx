
import React,{useState} from "react";


export default function ScannerDashboard(){

const [target,setTarget]=useState("");

const [result,setResult]=useState(null);

const [loading,setLoading]=useState(false);



async function startScan(){

if(!target){
alert("Target required");
return;
}


setLoading(true);


try{


const response=await fetch(
"http://localhost:8000/api/scanner/start",
{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({
target
})
}
);



const data=await response.json();


setResult(data);


}

catch(error){

console.error(error);

alert("Backend connection failed");

}


setLoading(false);


}



return (

<div>


<h2>
MUTEB Web Security Scanner
</h2>


<input

placeholder="example.com"

value={target}

onChange={
e=>setTarget(e.target.value)
}

/>


<button onClick={startScan}>

{
loading?
"Scanning..."
:
"Start Scan"
}

</button>



<button
onClick={()=>window.print()}
>

Export PDF Report

</button>



{

result &&

<table border="1">

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
OWASP
</th>

<th>
Date
</th>

</tr>

</thead>



<tbody>


<tr>


<td>
{result.target}
</td>


<td>
{result.result?.risk}
</td>


<td>

{
result.result?.findings?.length || 0
}

</td>



<td>

{
result.result?.findings?.map(
(f,i)=>
<div key={i}>
{f.owasp}
</div>
)
}

</td>



<td>

{
new Date().toLocaleString()
}

</td>



</tr>


</tbody>


</table>


}



</div>


);


}



import React,{useState} from "react";

import API from "./api/client";


function UserManagement(){


const [result,setResult]=useState(null);



async function checkRole(){


const token=localStorage.getItem(
"token"
);


const res=await API.post(

"/api/rbac/check",

{

role:"ADMIN",

permission:"manage_users"

},

{

headers:{

Authorization:
"Bearer "+token

}

}

);


setResult(
res.data
);


}



return (

<div className="card">


<h2>
RBAC Management
</h2>


<button onClick={checkRole}>
CHECK ADMIN ACCESS
</button>



{

result &&

<pre>

{
JSON.stringify(
result,
null,
2
)
}

</pre>

}


</div>

);


}


export default UserManagement;


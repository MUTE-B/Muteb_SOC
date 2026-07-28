const API_URL="http://172.20.10.4:8000";


export async function login(username,password){

const response = await fetch(
`${API_URL}/api/login`,
{
method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({
username,
password
})

});


return await response.json();

}

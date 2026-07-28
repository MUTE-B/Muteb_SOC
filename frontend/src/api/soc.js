const API="http://172.20.10.4:8000";


export async function getDashboard(token){

const response = await fetch(
`${API}/api/dashboard`,
{

headers:{

"Authorization":
`Bearer ${token}`

}

});


return await response.json();

}

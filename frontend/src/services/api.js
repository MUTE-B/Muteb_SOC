const API =
import.meta.env.VITE_API_URL ||
"http://172.20.10.4:8000";


async function request(url,options={}){

const response = await fetch(
API+url,
{
...options,
headers:{
"Content-Type":"application/json",
...(options.headers||{})
}
}
);

return await response.json();

}


export function login(username,password){

return request(
"/api/login",
{
method:"POST",
body:JSON.stringify({
username,
password
})
}
);

}


export function dashboard(token){

return request(
"/api/dashboard",
{
headers:{
Authorization:"Bearer "+token
}
}
);

}

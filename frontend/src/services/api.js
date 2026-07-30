const API =
import.meta.env.VITE_API_URL ||
"http://172.20.10.4:8000";


async function request(url, options={}){

const token =
localStorage.getItem("token");


const response = await fetch(
API + url,
{
...options,
headers:{
"Content-Type":"application/json",

...(token && {
Authorization:"Bearer "+token
}),

...(options.headers||{})
}
}
);


if(response.status===401){

localStorage.clear();
window.location.reload();

}


return await response.json();

}


export function dashboard(){

return request(
"/api/dashboard"
);

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


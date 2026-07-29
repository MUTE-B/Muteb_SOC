
import {useState} from "react";
import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";
import "./App.css";


export default function App(){

const [user,setUser]=useState(
localStorage.getItem("user")
);


function login(data){

localStorage.setItem(
"user",
JSON.stringify(data)
);

setUser(data);

}


function logout(){

localStorage.removeItem("user");

setUser(null);

}


if(!user){

return <Login onLogin={login}/>

}


return (

<Dashboard logout={logout}/>

);


}


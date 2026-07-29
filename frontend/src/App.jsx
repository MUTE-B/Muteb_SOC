

import React,{useState} from "react";

import {
BrowserRouter,
Routes,
Route,
Link,
Navigate
} from "react-router-dom";


import Dashboard from "./pages/Dashboard";
import Alerts from "./pages/Alerts";
import Incidents from "./pages/Incidents";
import Login from "./pages/Login";

import "./App.css";



function App(){


const [user,setUser]=useState(

JSON.parse(localStorage.getItem("user"))

);



function logout(){

localStorage.removeItem("user");

setUser(null);

}



if(!user)

return (

<BrowserRouter>

<Routes>

<Route

path="*"

element={

<Login onLogin={setUser}/>

}

/>


</Routes>

</BrowserRouter>

);



return (

<BrowserRouter>


<nav>


<Link to="/">Dashboard</Link>

{" | "}

<Link to="/alerts">Alerts</Link>

{" | "}

<Link to="/incidents">Incidents</Link>


<button onClick={logout}>

Logout

</button>


</nav>




<Routes>


<Route path="/" element={<Dashboard/>}/>

<Route path="/alerts" element={<Alerts/>}/>

<Route path="/incidents" element={<Incidents/>}/>


</Routes>


</BrowserRouter>

)



}


export default App;



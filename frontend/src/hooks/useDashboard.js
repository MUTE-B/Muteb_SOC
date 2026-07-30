import {
useEffect,
useState
} from "react";


import {
dashboard
} from "../services/api";



export default function useDashboard(){

const [data,setData]=useState(null);

const [error,setError]=useState(null);



async function refresh(){

try{

const result =
await dashboard();

setData(result);


}catch(e){

setError(
e.message
);

}

}



useEffect(()=>{

refresh();


const timer =
setInterval(
refresh,
10000
);


return ()=>clearInterval(timer);


},[]);



return {
data,
error,
refresh
};


}

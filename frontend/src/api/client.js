const API_URL="http://172.20.10.4:8000";


export async function getHealth(){

try{

const response = await fetch(API_URL);

return await response.json();

}

catch(error){

return {
status:"OFFLINE"
};

}

}

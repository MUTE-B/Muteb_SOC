import axios from "axios";

const client = axios.create({

    baseURL: "http://172.20.10.4:8000",

    headers:{
        "Content-Type":"application/json"
    }

});

export default client;

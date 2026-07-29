
import axios from "axios";

const sentinelAPI = axios.create({

baseURL:"http://172.20.10.4:8000/api/sentinel"

});

export default sentinelAPI;


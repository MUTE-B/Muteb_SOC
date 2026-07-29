import client from "./client";


export async function getSOCStatus(){

const response =
await client.get("/soc/status");

return response.data;

}

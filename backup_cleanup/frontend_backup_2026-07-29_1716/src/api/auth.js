
import client from "./client";


export async function login(username,password){

    const response = await client.post(
        "/api/login",
        {
            username,
            password
        }
    );


    return response.data;

}


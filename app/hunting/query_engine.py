

from datetime import datetime



HUNT_QUERIES=[


{

"id":"HUNT-001",

"name":"SSH Brute Force Hunt",

"query":"Failed password",

"category":"Credential Attack"

},


{

"id":"HUNT-002",

"name":"Suspicious IP Hunt",

"query":"external connection",

"category":"Network Threat"

}


]



def execute_query(query):


    results=[]



    for item in HUNT_QUERIES:


        if query.lower() in item["query"].lower() or query.lower() in item["name"].lower():


            results.append(item)



    return results




def all_queries():


    return HUNT_QUERIES


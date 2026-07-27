

SEARCH_INDEX=[


{

"type":"ALERT",

"value":"SSH_BRUTE_FORCE"

},


{

"type":"IOC",

"value":"185.220.101.1"

},


{

"type":"RULE",

"value":"SIGMA-SSH-001"

}


]



def search(query):


    results=[]



    for item in SEARCH_INDEX:


        if query.lower() in item["value"].lower():


            results.append(item)



    return results


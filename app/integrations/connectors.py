

from datetime import datetime



CONNECTORS=[


{

"name":"Splunk",

"type":"SIEM",

"status":"READY"

},


{

"name":"Microsoft Sentinel",

"type":"SIEM",

"status":"READY"

},


{

"name":"Wazuh",

"type":"XDR/SIEM",

"status":"READY"

},


{

"name":"TheHive",

"type":"Incident Response",

"status":"READY"

},


{

"name":"MISP",

"type":"Threat Intelligence",

"status":"READY"

}


]



def get_connectors():


    return {


        "platform":

        "MUTEB SOC Enterprise",


        "connectors":

        CONNECTORS

    }




def connector_status(name):


    for connector in CONNECTORS:


        if connector["name"].lower()==name.lower():


            return connector



    return {


        "name":

        name,


        "status":

        "NOT_REGISTERED"

    }


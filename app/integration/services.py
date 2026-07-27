

from datetime import datetime



SERVICES=[


{

"name":"Authentication",

"status":"ONLINE"

},


{

"name":"Threat Intelligence",

"status":"ONLINE"

},


{

"name":"Detection Engine",

"status":"ONLINE"

},


{

"name":"SOAR Engine",

"status":"ONLINE"

},


{

"name":"Case Management",

"status":"ONLINE"

},


{

"name":"SIEM Connector",

"status":"ONLINE"

}


]



def get_services():


    return {


        "platform":

        "MUTEB SOC Enterprise",


        "services":

        SERVICES,


        "checked":

        str(datetime.utcnow())

    }


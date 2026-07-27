

from datetime import datetime



IOC_DATABASE=[


{

"value":"185.220.101.1",

"type":"IP",

"risk":"HIGH"

},


{

"value":"malware.example",

"type":"DOMAIN",

"risk":"CRITICAL"

}


]



def lookup(value):


    for item in IOC_DATABASE:


        if item["value"]==value:


            return {


                **item,


                "checked":

                str(datetime.utcnow())

            }



    return {


        "value":

        value,


        "risk":

        "UNKNOWN",


        "checked":

        str(datetime.utcnow())

    }


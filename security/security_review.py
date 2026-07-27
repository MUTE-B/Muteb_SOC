

from datetime import datetime



SECURITY_CHECKLIST=[


{

"control":"Authentication",

"status":"IMPLEMENTED"

},


{

"control":"JWT Security",

"status":"IMPLEMENTED"

},


{

"control":"RBAC Authorization",

"status":"IMPLEMENTED"

},


{

"control":"Audit Logging",

"status":"IMPLEMENTED"

},


{

"control":"Security Headers",

"status":"IMPLEMENTED"

},


{

"control":"Threat Detection",

"status":"IMPLEMENTED"

},


{

"control":"Incident Response",

"status":"IMPLEMENTED"

},


{

"control":"Compliance Mapping",

"status":"IMPLEMENTED"

}



]




def review():


    return {


        "platform":

        "MUTEB SOC Enterprise",


        "review":

        "Security Architecture Review",


        "controls":

        SECURITY_CHECKLIST,


        "date":

        str(datetime.utcnow())

    }


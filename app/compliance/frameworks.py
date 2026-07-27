

FRAMEWORKS={


"ISO27001":{


"name":"ISO/IEC 27001",

"controls":[


"A.5 Information Security Policies",

"A.8 Asset Management",

"A.9 Access Control",

"A.12 Operations Security",

"A.16 Incident Management"

],

"status":"IMPLEMENTED"

},



"NIST_CSF":{


"name":"NIST Cybersecurity Framework",

"functions":[


"IDENTIFY",

"PROTECT",

"DETECT",

"RESPOND",

"RECOVER"

],

"status":"ALIGNED"

},



"CIS_CONTROLS":{


"name":"CIS Critical Security Controls",

"version":"v8",

"status":"MAPPED"

}



}




def get_frameworks():

    return FRAMEWORKS


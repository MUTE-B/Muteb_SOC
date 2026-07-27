

DEMO_EVENTS=[


{

"id":1,

"type":"SSH_BRUTE_FORCE",

"source":"185.220.101.1",

"severity":"HIGH",

"score":80,

"status":"OPEN",

"mitre":"T1110",

"title":"Multiple Failed SSH Login Attempts"

},



{

"id":2,

"type":"MALICIOUS_IP",

"source":"45.33.32.156",

"severity":"CRITICAL",

"score":95,

"status":"OPEN",

"mitre":"TA0001",

"title":"Suspicious External Connection"

},



{

"id":3,

"type":"PRIVILEGE_ESCALATION",

"source":"server01",

"severity":"HIGH",

"score":85,

"status":"INVESTIGATING",

"mitre":"T1068",

"title":"Privilege Escalation Attempt"

}


]



def get_demo_events():


    return DEMO_EVENTS


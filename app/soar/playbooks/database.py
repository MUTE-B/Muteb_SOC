

PLAYBOOKS=[


{

"id":"PB-001",

"name":"SSH Brute Force Response",

"trigger":"SSH_BRUTE_FORCE",

"actions":[

"CREATE_INCIDENT",

"BLOCK_IP",

"NOTIFY_ANALYST"

],

"status":"ACTIVE"

},


{

"id":"PB-002",

"name":"Malware Response",

"trigger":"MALWARE",

"actions":[

"ISOLATE_HOST",

"CREATE_INCIDENT"

],

"status":"ACTIVE"

}


]



def get_playbooks():

    return PLAYBOOKS



def find_playbook(trigger):


    for pb in PLAYBOOKS:


        if pb["trigger"]==trigger:


            return pb



    return None


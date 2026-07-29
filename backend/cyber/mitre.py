

ATTACK={

"LOGIN":

"T1078 Valid Accounts",

"NETWORK":

"T1046 Network Discovery",

"FILE":

"T1204 User Execution"

}



def map_attack(event_type):

    return ATTACK.get(

    event_type,

    "UNKNOWN"

    )


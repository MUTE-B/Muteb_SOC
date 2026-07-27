

TECHNIQUES = [

    {
        "id":"T1110",
        "name":"Brute Force",
        "tactic":"Credential Access",
        "coverage":"ACTIVE"
    },

    {
        "id":"T1548",
        "name":"Privilege Escalation",
        "tactic":"Privilege Escalation",
        "coverage":"ACTIVE"
    },

    {
        "id":"T1046",
        "name":"Network Service Scanning",
        "tactic":"Discovery",
        "coverage":"ACTIVE"
    }

]



def get_coverage():

    return TECHNIQUES


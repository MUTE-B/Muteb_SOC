

from datetime import datetime



RULE_DATABASE=[



{

"id":"RULE-001",

"name":"SSH Brute Force",

"type":"SIGMA",

"severity":"HIGH",

"status":"ACTIVE",

"condition":"Failed password"

},



{

"id":"RULE-002",

"name":"Suspicious IP",

"type":"SIGMA",

"severity":"CRITICAL",

"status":"ACTIVE",

"condition":"malicious_ip"

}



]




def get_rules():

    return RULE_DATABASE




def add_rule(rule):


    rule["created_at"]=str(datetime.utcnow())


    RULE_DATABASE.append(rule)


    return rule




def update_rule(rule_id,status):


    for rule in RULE_DATABASE:


        if rule["id"]==rule_id:


            rule["status"]=status


            return rule



    return None


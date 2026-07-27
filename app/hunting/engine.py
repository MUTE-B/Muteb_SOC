

RULES=[


    {

        "name":

        "Suspicious IP Detection",

        "field":

        "ip"

    },


    {

        "name":

        "Malicious Command Detection",

        "field":

        "command"

    },


    {

        "name":

        "Credential Attack Detection",

        "field":

        "username"

    }

]




def hunt(event):


    matches=[]


    for rule in RULES:


        if rule["field"] in event:


            matches.append(rule)



    return matches


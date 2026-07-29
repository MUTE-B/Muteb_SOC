

RULES=[

{

"id":1,

"name":
"Suspicious Login",

"type":
"LOGIN",

"severity":
"HIGH"

}

]


def scan(event):

    result=[]


    for rule in RULES:

        if event.get(
        "type"
        )==rule["type"]:

            result.append(rule)


    return result



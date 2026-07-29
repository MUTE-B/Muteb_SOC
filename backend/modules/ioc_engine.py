

class IOCScanner:


    def scan(self,value):

        bad=[

        "malware",
        "virus",
        "attack",
        "exploit"

        ]


        found=[]


        for x in bad:

            if x in value.lower():

                found.append(x)


        return {

        "value":value,
        "threat":
        len(found)>0,
        "matches":found

        }


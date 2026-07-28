
class IOCScanner:


    def scan(self,data):


        indicators=[]


        suspicious=[

            "malware",
            "virus",
            "attack",
            "exploit"

        ]


        for item in suspicious:

            if item in data.lower():

                indicators.append(item)



        return indicators


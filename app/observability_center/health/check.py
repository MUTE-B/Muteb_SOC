

class HealthMonitor:



    services=[


    "SOC",

    "SIEM",

    "SOAR",

    "AI",

    "Database",

    "API"


    ]



    def status(self):


        return {


        "services":

        self.services,


        "availability":

        "99.9%",


        "health":

        "OPTIMAL"



        }




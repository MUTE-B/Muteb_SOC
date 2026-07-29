

class IntegrationCatalog:



    tools=[


    "SIEM",

    "EDR",

    "Firewall",

    "Threat Intelligence",

    "Ticketing System"


    ]



    def list(self):


        return {


        "integrations":

        self.tools,


        "connected":

        True



        }




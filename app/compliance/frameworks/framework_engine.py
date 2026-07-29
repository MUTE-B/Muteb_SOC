

class ComplianceFramework:



    frameworks={


    "ISO27001":[

        "Access Control",

        "Risk Management",

        "Asset Management",

        "Incident Management"

    ],


    "NIST":[

        "Identify",

        "Protect",

        "Detect",

        "Respond",

        "Recover"

    ],


    "CIS":[

        "Inventory",

        "Secure Configuration",

        "Monitoring"

    ]


    }



    def list(self):


        return self.frameworks




    def mapping(self,framework):


        return self.frameworks.get(

        framework,

        []

        )




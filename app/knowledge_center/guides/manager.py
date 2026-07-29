

class DocumentationManager:



    documents=[


    "Enterprise Architecture Guide",

    "SOC Analyst Manual",

    "Administrator Guide",

    "Incident Response Guide",

    "Security Operations Guide"


    ]



    def list(self):


        return {


        "documents":

        self.documents,


        "total":

        len(self.documents),


        "status":

        "AVAILABLE"



        }






class IncidentResponse:



    stages=[


    "Detection",

    "Analysis",

    "Containment",

    "Recovery",

    "Lessons Learned"


    ]



    def workflow(self):


        return {


        "process":

        self.stages


        }




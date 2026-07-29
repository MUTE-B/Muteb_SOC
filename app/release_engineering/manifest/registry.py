

class ReleaseManifest:



    modules=[


    "SOC",

    "SIEM",

    "SOAR",

    "AI",

    "Threat Intelligence",

    "DFIR",

    "GRC",

    "Vulnerability Management",

    "Purple Team",

    "Disaster Recovery",

    "Observability"


    ]



    def generate(self):


        return {


        "modules":

        self.modules,


        "count":

        len(self.modules),


        "release_ready":

        True



        }






class ServiceRegistry:



    services = {


    "SOC":

    "/api/soc",


    "AI":

    "/api/ai-copilot",


    "SIEM":

    "/api/siem",


    "SOAR":

    "/api/soar",


    "Threat Intelligence":

    "/api/threat-intel",


    "Incident Response":

    "/api/incidents"



    }



    def list(self):


        return {


        "services":

        self.services,


        "count":

        len(self.services)



        }




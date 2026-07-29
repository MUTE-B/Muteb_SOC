

from datetime import datetime



class AnalystWorkspace:



    def overview(self):


        return {


        "workspace":

        "SOC Analyst Workspace",


        "active_cases":

        0,


        "open_vulnerabilities":

        0,


        "critical_alerts":

        0,


        "last_update":

        str(datetime.utcnow())



        }




    def priority_queue(self):


        return [


        {

        "priority":"HIGH",

        "task":"Review security posture"

        },


        {

        "priority":"MEDIUM",

        "task":"Check compliance status"

        }


        ]




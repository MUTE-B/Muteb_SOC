

from datetime import datetime



class AnalystReport:



    def generate(self,data):


        return {


        "report_type":
        "Technical Analyst Report",


        "generated":
        str(datetime.utcnow()),


        "technical_findings":
        data.get("findings",[]),


        "risk":
        data.get("risk",{}),


        "recommendations":

        [

        "Review security controls",

        "Maintain monitoring",

        "Apply remediation process"

        ]



        }



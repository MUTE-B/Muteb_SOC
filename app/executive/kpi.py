

from datetime import datetime



def calculate_kpis():


    return {


        "platform":

        "MUTEB SOC Enterprise",


        "security_metrics":{


            "total_alerts":125,


            "critical_alerts":8,


            "high_alerts":32,


            "resolved_incidents":97,


            "open_incidents":28

        },



        "response_metrics":{


            "average_response_time":

            "5 minutes",


            "automation_rate":

            "85%",


            "analyst_efficiency":

            "92%"

        },



        "maturity":{


            "soc_level":

            "Level 4",


            "framework":

            "NIST CSF",


            "status":

            "ADVANCED"

        },



        "generated":

        str(datetime.utcnow())

    }



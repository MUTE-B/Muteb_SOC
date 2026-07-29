

import json



class DemoSOC:


    def load_alerts(self):

        with open(
        "demo/alerts/security_alerts.json"
        ) as file:

            return json.load(file)



    def run(self):

        alerts=self.load_alerts()


        return {


        "demo":

        "ACTIVE",


        "alerts":

        len(alerts),


        "workflow":

        "SOC INVESTIGATION"



        }



if __name__=="__main__":


    print(

    DemoSOC().run()

    )




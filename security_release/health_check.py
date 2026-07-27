

import os
import sys



class SystemHealth:



    def check(self):


        checks={


            "application":

            os.path.exists(
                "app"
            ),


            "database":

            os.path.exists(
                "instance"
            ),


            "logs":

            os.path.exists(
                "logs"
            ),


            "reports":

            os.path.exists(
                "reports"
            )


        }



        return {


            "platform":
            "MUTEB SOC Enterprise",


            "version":
            "3.0.0",


            "checks":
            checks,


            "status":
            "READY"

        }





health=SystemHealth()



if __name__=="__main__":

    print(
        health.check()
    )


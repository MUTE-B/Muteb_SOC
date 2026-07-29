

import os



class ProjectValidator:


    def check_structure(self):


        required=[


        "app",

        "MASTER_CONTROL_CENTER.md",

        "MUTEB_SOC_ENTERPRISE_FINAL.md",

        "requirements.txt"



        ]


        result={}


        for item in required:

            result[item]=os.path.exists(item)



        return result



if __name__=="__main__":


    print(

    ProjectValidator()

    .check_structure()

    )




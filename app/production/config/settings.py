

class EnterpriseConfig:



    settings={


    "environment":

    "enterprise",


    "logging":

    True,


    "audit":

    True,


    "monitoring":

    True


    }



    def get(self):


        return self.settings




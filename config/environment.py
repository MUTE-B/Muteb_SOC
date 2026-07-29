

import os



class EnvironmentConfig:



    APP_ENV=os.getenv(

    "APP_ENV",

    "production"

    )



    SECRET_KEY=os.getenv(

    "SECRET_KEY",

    "CHANGE_ME_IN_PRODUCTION"

    )



    DATABASE_URL=os.getenv(

    "DATABASE_URL",

    ""

    )



    DEBUG=False



    @classmethod

    def status(cls):


        return {


        "environment":

        cls.APP_ENV,


        "debug":

        cls.DEBUG,


        "secret_configured":

        cls.SECRET_KEY != "CHANGE_ME_IN_PRODUCTION"



        }




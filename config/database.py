

import os



class DatabaseConfig:



    DATABASE_URL=os.getenv(

    "DATABASE_URL",

    "postgresql://muteb:password@localhost/muteb_soc"

    )



    def get():

        return DatabaseConfig.DATABASE_URL




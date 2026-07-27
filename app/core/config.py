import os


class Config:

    """
    MUTEB-SOC Enterprise Configuration
    Central configuration management
    """


    SECRET_KEY = os.environ.get(
        "SECRET_KEY",
        "MUTEB-SOC-ENTERPRISE-SECRET"
    )


    JWT_SECRET_KEY = os.environ.get(
        "JWT_SECRET_KEY",
        "MUTEB-SOC-JWT-SECRET"
    )


    SQLALCHEMY_DATABASE_URI = os.environ.get(
        "DATABASE_URL",
        "sqlite:///muteb_soc.db"
    )


    SQLALCHEMY_TRACK_MODIFICATIONS = False



class DevelopmentConfig(Config):

    DEBUG = True



class ProductionConfig(Config):

    DEBUG = False

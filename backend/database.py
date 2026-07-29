import psycopg2
from config import Config


def get_db():
    return psycopg2.connect(
        host=Config.DB["host"],
        database=Config.DB["database"],
        user=Config.DB["user"],
        password=Config.DB["password"]
    )

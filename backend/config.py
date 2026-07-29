
import os
from dotenv import load_dotenv

load_dotenv()


JWT_SECRET=os.getenv(
"JWT_SECRET_KEY"
)


DATABASE={

"host":
os.getenv("DB_HOST"),

"database":
os.getenv("DB_NAME"),

"user":
os.getenv("DB_USER"),

"password":
os.getenv("DB_PASSWORD")

}


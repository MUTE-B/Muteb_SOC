import os
from dotenv import load_dotenv

load_dotenv()

JWT_SECRET=os.getenv(
"JWT_SECRET",
"CHANGE_ME"
)

DATABASE_PASSWORD=os.getenv(
"DATABASE_PASSWORD"
)

ADMIN_PASSWORD=os.getenv(
"ADMIN_PASSWORD"
)

import json
from pathlib import Path

USERS_FILE = Path("security/users.json")


def load_users():

    if not USERS_FILE.exists():

        return {}

    with open(USERS_FILE,"r") as f:
        return json.load(f)



def get_user(username):

    users=load_users()

    return users.get(username)



def check_password(username,password):

    user=get_user(username)

    if not user:
        return None

    if user["password"] == password:
        return user

    return None

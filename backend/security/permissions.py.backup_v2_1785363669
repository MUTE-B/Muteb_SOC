from functools import wraps
from flask import jsonify


def role_required(role):

    def decorator(fn):

        @wraps(fn)
        def wrapper(*args,**kwargs):

            return fn(*args,**kwargs)

        return wrapper

    return decorator

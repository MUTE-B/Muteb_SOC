#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC
# Dashboard Authentication Module
# ==========================================================
#

from functools import wraps
from flask import request, jsonify


USERNAME = "admin"
PASSWORD = "muteb123"



def check_auth(username, password):

    return (
        username == USERNAME
        and
        password == PASSWORD
    )



def require_auth(function):

    @wraps(function)

    def wrapper(*args, **kwargs):

        auth = request.authorization


        if not auth or not check_auth(
            auth.username,
            auth.password
        ):

            return jsonify({

                "error":
                "Authentication Required"

            }),401


        return function(*args, **kwargs)


    return wrapper


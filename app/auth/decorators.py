from functools import wraps

from flask import jsonify

from flask_jwt_extended import (
    verify_jwt_in_request,
    get_jwt_identity
)

from app.models.user import User

from app.auth.permissions import has_permission



def permission_required(permission):

    def decorator(function):

        @wraps(function)

        def wrapper(*args, **kwargs):

            verify_jwt_in_request()


            username = get_jwt_identity()


            user = User.query.filter_by(
                username=username
            ).first()


            if not user:

                return jsonify({
                    "error":"User not found"
                }),404



            if not has_permission(
                user.role,
                permission
            ):

                return jsonify({
                    "error":"Permission denied"
                }),403



            return function(
                *args,
                **kwargs
            )


        return wrapper


    return decorator

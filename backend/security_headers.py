

def apply_headers(response):

    response.headers["X-Frame-Options"]="DENY"

    response.headers["X-Content-Type-Options"]="nosniff"

    response.headers["Strict-Transport-Security"]="max-age=31536000"

    response.headers["Content-Security-Policy"]="default-src 'self'"


    return response


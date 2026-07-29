
bind = "0.0.0.0:8000"

workers = 4

worker_class = "sync"

timeout = 120

keepalive = 5

accesslog = "logs/gunicorn_access.log"

errorlog = "logs/gunicorn_error.log"

loglevel = "info"

capture_output = True


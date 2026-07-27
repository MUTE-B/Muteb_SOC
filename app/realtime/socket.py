

from flask_socketio import SocketIO


socketio = SocketIO(
    cors_allowed_origins="*"
)



def send_alert(data):

    socketio.emit(
        "security_alert",
        data
    )



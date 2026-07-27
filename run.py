
from app.core.application import create_app

print("MUTEB SOC STARTING...")

app = create_app()

print("APPLICATION CREATED")

if __name__ == "__main__":

    print("STARTING FLASK SERVER")

    app.run(
        host="0.0.0.0",
        port=8000,
        debug=False
    )



FROM python:3.12-slim


WORKDIR /app


COPY . .


RUN pip install flask gunicorn


EXPOSE 8000


CMD ["gunicorn",
"app.main:app",
"--bind",
"0.0.0.0:8000"]




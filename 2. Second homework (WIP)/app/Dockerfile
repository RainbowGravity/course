# syntax=docker/dockerfile:1
FROM python:3.8-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src/ .
ENV FLASK_APP=exampleapp:app
CMD [ "python", "./container.py", "cert.pem", "key.pem" ]

# syntax=docker/dockerfile:1
FROM python:3.8-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src/ .
CMD [ "python", "./container.py", "cert.pem", "key.pem" ]

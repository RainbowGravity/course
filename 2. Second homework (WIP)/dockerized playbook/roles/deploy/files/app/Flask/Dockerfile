FROM python:3.6-alpine AS builder

# First layer of image building
LABEL stage=builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt 

RUN find /root/.local/lib/python3.6/site-packages -name '*.dist-info' | xargs rm -r

# Second layer of image building
FROM python:3.6-alpine 

WORKDIR /app
COPY --from=builder /root/.local /usr/local
COPY src/ /app

# Running Gunicorn server with config
CMD [ "gunicorn","-c","config.py","wsgi:app" ]

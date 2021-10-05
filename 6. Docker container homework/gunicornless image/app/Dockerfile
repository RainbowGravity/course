FROM python:3.6-alpine AS builder

# First layer of image building
LABEL stage=builder

WORKDIR /app

COPY requirements.txt .
COPY src/ /app

RUN apk --update --no-cache add \
    zlib-dev \
    musl-dev \
    gcc \
    scons \
    patchelf && \
    pip install --upgrade pip --no-cache-dir \
    -r requirements.txt \
    staticx \
    pyinstaller && \
    pyinstaller -F --add-data "static:static" --add-data "templates:templates" main.py && \ 
    staticx /app/dist/main /app/app && \
    mkdir /app/tmp

# Second layer of image building

FROM scratch 

USER 1001

WORKDIR /app

ENV PATH="/app:${PATH}"

COPY --from=builder --chown=1001:1001 /app/app .
COPY --from=builder --chown=1001:1001 /app/tmp /tmp

# Run app
CMD [ "app" ]

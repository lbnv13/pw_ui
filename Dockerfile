FROM python:3.5.10-alpine
WORKDIR /app
COPY . /app

RUN apk --no-cache --update add build-base && \
    pip install --no-cache-dir --upgrade pip \
    pip install --no-cache-dir -r /app/requirements.txt && \
    apk del build-base

ENV MONGO mongo_db
ENV MONGO_PORT 27017
ENV FLASK_APP ui.py

WORKDIR /app/ui
ENTRYPOINT ["gunicorn", "ui:app" ,"-b", "0.0.0.0"]
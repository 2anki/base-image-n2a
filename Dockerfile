FROM node:12-slim

LABEL maintainer Alexander Alemayhu

RUN apt-get update || : && apt-get install python3 python3-pip -y && rm -rf /var/lib/apt/lists/*

RUN pip3 install -r /app/src/genanki/requirements.txt

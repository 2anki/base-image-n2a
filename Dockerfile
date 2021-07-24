FROM node:14-slim

LABEL maintainer Alexander Alemayhu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales python3 python3-pip

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8


RUN apt-get update || : && apt-get install python3 python3-pip -y && rm -rf /var/lib/apt/lists/*

COPY ./notion2anki/server/genanki/requirements.txt /tmp/requirements.txt 
RUN pip3 install -r /tmp/requirements.txt

RUN npm install -g pnpm

RUN mkdir /tmp/server 
RUN mkdir /tmp/web 

COPY ./notion2anki/server/package.json /tmp/server/package.json
COPY ./notion2anki/web/package.json /tmp/web/package.json

RUN cd /tmp/server && pnpm install
RUN cd /tmp/web && pnpm install

RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*
